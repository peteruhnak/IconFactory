public
createIconFromFile: aFile inClass: aClass
	"Create the methods for the icon.
	aFileNamePrefix is the png file name prefix (without the .png suffix)"

	| aFileNamePrefix base64 contentsSelector selector source |
	aFileNamePrefix := aFile base.
	base64 := self base64ContentsOfFileNamed: aFile.
	contentsSelector := (aFileNamePrefix , 'IconContents') asSymbol.
	((aClass respondsTo: contentsSelector) and: [ (aClass perform: contentsSelector) = base64 ])
		ifFalse: [ 
			| contentsSource |
			contentsSource := self iconContentsMethodTemplate
				format:
					{aFileNamePrefix.
					aFile.
					base64}.
			aClass compile: contentsSource classified: 'private - contents' ].
	selector := (aFileNamePrefix , 'Icon') asSymbol.

	cached
		ifTrue: [ source := self cachedIconMethodTemplate format: {selector} ]
		ifFalse: [ source := self iconMethodTemplate format: {selector} ].
	aClass compile: source classified: 'accessing - icons'