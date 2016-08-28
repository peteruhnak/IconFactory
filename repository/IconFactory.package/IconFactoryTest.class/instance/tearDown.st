running
tearDown
	(self class environment hasClassNamed: #IFTestIcons)
		ifTrue: [ (self class environment at: #IFTestIcons) removeFromSystem ]