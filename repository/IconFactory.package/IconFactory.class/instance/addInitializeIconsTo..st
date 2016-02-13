private - setup
addInitializeIconsTo: aClass
	(aClass hasInstVarNamed: 'icons')
		ifFalse: [ aClass addInstVarNamed: 'icons' ].
	aClass
		compile:
			'initializeIcons
	icons := LRUCache new 
		maximumWeight: 64;
		factory: [ :key | self perform: key ];
		yourself'
		classified: 'initialization'