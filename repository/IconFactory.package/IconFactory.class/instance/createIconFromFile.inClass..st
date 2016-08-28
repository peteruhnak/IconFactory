private - loading
createIconFromFile: aFile inClass: aClass
	"Create the methods for the icon.
	aFileNamePrefix is the png file name prefix (without the .png suffix)"

	| file aFileNamePrefix base64 contentsSelector selector |
	file := aFile asFileReference.
	aFileNamePrefix := file base withoutSuffix: 'Icon'.
	base64 := self base64Of: file.
	contentsSelector := (aFileNamePrefix , 'IconContents') asSymbol.
	((aClass class selectors includes: contentsSelector)
		and: [ (aClass perform: contentsSelector) = base64 ])
		ifFalse: [ | contentsSource |
			contentsSource := self iconContentsMethodTemplate
				format:
					{aFileNamePrefix.
					file.
					base64}.
			aClass class compile: contentsSource classified: 'private - contents' ].
	selector := (aFileNamePrefix , 'Icon') asSymbol.
	aClass class
		compile: (self iconMethodTemplate format: {selector})
		classified: 'accessing - icons'