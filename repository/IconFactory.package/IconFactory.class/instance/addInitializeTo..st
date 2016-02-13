private - setup
addInitializeTo: aClass
	aClass
		compile:
			'initialize
	super initialize.
	self initializeIcons'
		classified: 'initialization'