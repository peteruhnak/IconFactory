"
IconFactory is a utility for importing PNG images from a directory into a class.

Each file will be compiled into the **class-side** of the target class as `<fileName>Icon` selector in base64 format. (Icon suffix will not be duplicated.).

This enables you to distribute the images directly with your source code.

Once imported, you can access the `Form` (Pharo's image representation) by sending the appropriate selector, e.g. `MyIcons myCoolIcon`.

![](figures/playground-demo.png)

Only PNG files are currently supported.

## Installation

Install `IconFactory` from **Catalog Browser**.

Or run the following script.

```
Metacello new
    baseline: #IconFactory;
    repository: 'github://peteruhnak/IconFactory';
    load
```

## Loading images into a class

If `MyIcons` class doesn't exist, it will be created in a category of the same name.

This method will install all images not present in #MyIcons and remove all selectors representing images that are not longer present in the directory.

```st
IconFactory
	syncDirectory: '/home/some/path/myIcons'
	intoClass: #MyIcons
```

You can use a bit of GUI too.

```
d := UIManager default chooseDirectory.
IconFactory syncDirectory: d intoClass: #MyIcons
```

It effectively combines the following two options.

## Add only images

Add all images from the directory into the class.

```st
IconFactory
	loadDirectory: 'd:\some\path\myIcons'
	intoClass: #MyIcons
```

## Remove old selectors

Remove all selectors (images) from the class that are not present in the directory.

```st
IconFactory
	removeFromClass: #MyIcons
	notInDirectory: 'd:\some\path\myIcons'
```

## Creating icon for a single file

There are private methods that you can use at your own risk. Adding manually images one by one suggests a flaw in a workflow (that was the case for me anyway); but feel free to open a issue with your use case.

## Performance note

The data is stored as base64 in one `<name>IconContents` method and is converted to `Form` in `<name>Icon`. Because the conversion is slow, it is automatically cached by a Dictionary.

Depending on the size of the image (tested on 24x24) it can easily be 1000x times faster.

```st
""Without dictionary""
[ BormEditorIcons personIcon ] bench. ""'2,271 per second'""

""With dictionary""
[ BormEditorIcons personIcon ] bench. ""'3,228,827 per second'""
```
"
Class {
	#name : #IconFactory,
	#superclass : #Object,
	#category : 'IconFactory'
}

{ #category : #installing }
IconFactory class >> loadDirectory: aDirectory intoClass: aClassOrName [
	^ self new loadDirectory: aDirectory intoClass: aClassOrName
]

{ #category : #installing }
IconFactory class >> removeFromClass: aClassOrName notInDirectory: aDirectory [
	self new removeFromClass: aClassOrName notInDirectory: aDirectory
]

{ #category : #installing }
IconFactory class >> syncDirectory: aDirectory intoClass: aClassOrName [
	self
		loadDirectory: aDirectory
		intoClass: aClassOrName.
	self
		removeFromClass: aClassOrName
		notInDirectory: aDirectory
]

{ #category : #'private - utilities' }
IconFactory >> addIconsAccessorTo: aClass [
	(aClass hasClassVarNamed: 'icons')
		ifFalse: [ aClass addClassVarNamed: 'icons' ].
	(aClass class selectors includes: #icons)
		ifFalse: [ aClass class compile: self iconsAccessorTemplate classified: 'accessing' ].
	(aClass class selectors includes: #resetIcons)
		ifFalse: [ aClass class compile: self resetIconsTemplate classified: 'accessing - reset' ].
	(aClass class selectors includes: #gtInspectorIconsIn:)
		ifFalse: [ aClass class compile: self gtInspectorTemplate classified: 'GT-InspectorExtensions' ].
]

{ #category : #'private - utilities' }
IconFactory >> base64Of: aFileReference [
	^ (Base64MimeConverter mimeEncode: aFileReference readStream binary) contents
]

{ #category : #'private - loading' }
IconFactory >> createIconFromFile: aFile inClass: aClass [
	"Create the methods for the icon.
	aFileNamePrefix is the png file name prefix (without the .png suffix)"

	| file base64 contentsSelector baseSelector |
	file := aFile asFileReference.
	baseSelector := self selectorForName: file base.
	base64 := self base64Of: file.
	contentsSelector := (baseSelector , 'IconContents') asSymbol.
	((aClass class selectors includes: contentsSelector)
		and: [ (aClass perform: contentsSelector) = base64 ])
		ifFalse: [ | contentsSource |
			contentsSource := self iconContentsMethodTemplate
				format:
					{baseSelector.
					file.
					base64}.
			aClass class compile: contentsSource classified: 'private - contents' ].
	aClass class
		compile: (self iconMethodTemplate format: {(baseSelector , 'Icon') asSymbol})
		classified: 'accessing - icons'
]

{ #category : #'private - loading' }
IconFactory >> createIconsFromDirectory: aDirectory inClass: aClass [
	aDirectory allFiles
		select: [ :each | each extension = 'png' ]
		thenDo: [ :each | self createIconFromFile: each inClass: aClass ]
]

{ #category : #'private - utilities' }
IconFactory >> ensureClassFor: aClassOrName [
	| cls |
	cls := aClassOrName isClass
		ifTrue: [ aClassOrName ]
		ifFalse: [ self class environment
				at: aClassOrName asSymbol
				ifAbsent: [ Object
						subclass: aClassOrName asSymbol
						slots: {}
						classVariables: {#icons}
						category: aClassOrName ] ].
	self addIconsAccessorTo: cls.
	^ cls
]

{ #category : #'private - templates' }
IconFactory >> gtInspectorTemplate [
	^ 'gtInspectorIconsIn: composite
	<gtInspectorPresentationOrder: 0>
	<script: ''self inspect''>
	composite table
		title: ''Icons'';
		display: [ (self class selectorsInCategory: ''accessing - icons'') sorted
				collect: [ :each | each -> (self perform: each) ] ];
		column: ''Icon'' evaluated: #value width: 50;
		column: ''Selector'' evaluated: #key'
]

{ #category : #'private - templates' }
IconFactory >> iconContentsMethodTemplate [
	^ '{1}IconContents
	"Private - Method generated with the content of the file {2}"
	^ ''{3}'''
]

{ #category : #'private - templates' }
IconFactory >> iconMethodTemplate [
	^ '{1}
	"Private - Generated method"
	^ self icons
		at: #{1}
		ifAbsentPut: [ Form
				fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self {1}Contents readStream) ]'
]

{ #category : #'private - templates' }
IconFactory >> iconsAccessorTemplate [
	^ 'icons
	^ icons ifNil: [ icons := Dictionary new ]'
]

{ #category : #loading }
IconFactory >> loadDirectory: aDirectory intoClass: aClassOrName [
	| cls |
	cls := self ensureClassFor: aClassOrName.
	self createIconsFromDirectory: aDirectory asFileReference inClass: cls
]

{ #category : #loading }
IconFactory >> removeFromClass: aClassOrName notInDirectory: aDirectory [
	| cls inClass inDirectory |
	(aClassOrName isString and: [ (self class environment hasClassNamed: aClassOrName) not ])
		ifTrue: [ ^ self ].
	cls := aClassOrName isClass
		ifTrue: [ aClassOrName ]
		ifFalse: [ self class environment at: aClassOrName asSymbol ].
	inClass := (cls class selectorsInCategory: 'accessing - icons')
		collect: [ :each | each withoutSuffix: 'Icon' ].
	inDirectory := aDirectory asFileReference allFiles
		collect: [ :each | self selectorForName: each base ].
	(inClass copyWithoutAll: inDirectory)
		do: [ :each | 
			(cls class includesSelector: (each , 'Icon') asSymbol)
				ifTrue: [ cls class removeSelector: (each , 'Icon') asSymbol ].
			(cls class includesSelector: (each , 'IconContents') asSymbol)
				ifTrue: [ cls class removeSelector: (each , 'IconContents') asSymbol ] ]
]

{ #category : #'private - templates' }
IconFactory >> resetIconsTemplate [
	^ 'resetIcons
	<script>
	^ icons := nil'
]

{ #category : #'private - utilities' }
IconFactory >> selectorForName: aString [
	| parts |
	parts := (aString withoutSuffix: 'Icon') splitOn: '-'.
	^ ((parts collect: #capitalized) joinUsing: '') uncapitalized
]
