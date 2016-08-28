tests
testEnsureClassMethods
	| cls |
	cls := factory ensureClassFor: #IFTestIcons.
	self assert: cls selectors equals: #().
	self assert: cls class selectors asSet equals: #(icons resetIcons gtInspectorIconsIn:) asSet