tests
testSelectorForName
	self assert: (factory selectorForName: 'myIcon') equals: 'my'.
	self assert: (factory selectorForName: 'my') equals: 'my'.
	self assert: (factory selectorForName: 'my-image') equals: 'myImage'