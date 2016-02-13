private - setup
addIconSelectorTo: aClass
	aClass
		compile:
			'iconSelectors
	^ self class selectors select: [ :each | ''*Icon'' match: each asString ]'
		classified: 'initialization'