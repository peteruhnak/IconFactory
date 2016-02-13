private - utilities
selectIconsIn: aClass
	^ aClass selectors select: [ :each | '*Icon' match: each asString ]