private - loading
createIconFromFile: aFile inClass: aClass
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