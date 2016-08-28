tests
testEnsureClass
	| cls |
	self deny: (self class environment hasClassNamed: #IFTestIcons).
	cls := factory ensureClassFor: #IFTestIcons.
	self assert: (self class environment hasClassNamed: #IFTestIcons).
	self assert: cls instVarNames equals: #().
	self assert: cls classVarNames equals: #(icons)