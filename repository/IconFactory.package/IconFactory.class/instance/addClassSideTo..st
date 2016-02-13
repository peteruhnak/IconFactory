private - setup
addClassSideTo: aClass
	(aClass hasClassVarNamed: 'Current')
		ifFalse: [ aClass addClassVarNamed: 'Current' ].
	aClass class
		compile:
			'current
	^ Current ifNil: [ Current := self new ]'
		classified: 'instance creation'