private - utilities
ensureClassFor: aClassOrName
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