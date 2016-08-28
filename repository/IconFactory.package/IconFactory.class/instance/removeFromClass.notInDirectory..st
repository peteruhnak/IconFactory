loading
removeFromClass: aClassOrName notInDirectory: aDirectory
	| cls inClass inDirectory |
	(aClassOrName isString and: [ (self class environment hasClassNamed: aClassOrName) not ])
		ifTrue: [ ^ self ].
	cls := aClassOrName isClass
		ifTrue: [ aClassOrName ]
		ifFalse: [ self class environment at: aClassOrName asSymbol ].
	inClass := (cls class selectorsInCategory: 'accessing - icons') collect: [ :each | each withoutSuffix: 'Icon' ].
	inDirectory := aDirectory asFileReference allFiles collect: [ :each | each base withoutSuffix: 'Icon' ].
	(inClass copyWithoutAll: inDirectory)
		do: [ :each | 
			(cls class includesSelector: (each , 'Icon') asSymbol)
				ifTrue: [ cls class removeSelector: (each , 'Icon') asSymbol ].
			(cls class includesSelector: (each , 'IconContents') asSymbol)
				ifTrue: [ cls class removeSelector: (each , 'IconContents') asSymbol ] ]