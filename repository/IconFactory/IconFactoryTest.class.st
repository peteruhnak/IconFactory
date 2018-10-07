Class {
	#name : #IconFactoryTest,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : 'IconFactory'
}

{ #category : #'instance creation' }
IconFactoryTest >> exampleIconContents [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAJYAAACWAQMAAAAGz+OhAAAABlBMVEX///8AAABVwtN+AAAB
Y0lEQVRIib2WsQ2FMAxEjShSZgRvAoshAmKxn00yQkoKFP9zAhIDOFii4FE4sc9nSBB5TEQ0
OckBbxdZs5NoyCGJuAK+4OnAZtnzqAf44ePiJXViIV0s8ezKiMd0TjT3Ylq/hYkkSsyvmnZm
VRtLPYuLb70YsjugQGX0DjOGRDueUdA38ke7pjFzUTY0i5i0b0E21M+a1bwH5ggaR/jtuZsh
g7BX0jmC/jT0bl8wNGuAD118DvhMFJI903T+Uv3NKsVaU2smxe/qp+zK00JzhrwrqUeoZ2te
tmewagxoGgX1m6DxWlNjhrsVXQeM+hUvkOL1CcMBoHucxuE0mK2j1tSa0eo3VmNF3+Bz3IUN
1URdrAo82kiZsjagmNbmp146sHsvEEvBP8jSdG/M6n7DXhD3g5/eXvcF032O+yb1oafOPVgQ
ZEPX1Ov6MdX4HWTP6n/iI8S2V61Z0waMGkQt6UifsD9ep9m08O+1TQAAAABJRU5ErkJggg=='
]

{ #category : #running }
IconFactoryTest >> setUp [
	factory := IconFactory new
]

{ #category : #running }
IconFactoryTest >> tearDown [
	(self class environment hasClassNamed: #IFTestIcons)
		ifTrue: [ (self class environment at: #IFTestIcons) removeFromSystem ]
]

{ #category : #tests }
IconFactoryTest >> testEnsureClass [
	| cls |
	self deny: (self class environment hasClassNamed: #IFTestIcons).
	cls := factory ensureClassFor: #IFTestIcons.
	self assert: (self class environment hasClassNamed: #IFTestIcons).
	self assert: cls instVarNames equals: #().
	self assert: cls classVarNames equals: #(icons)
]

{ #category : #tests }
IconFactoryTest >> testEnsureClassMethods [
	| cls |
	cls := factory ensureClassFor: #IFTestIcons.
	self assert: cls selectors equals: #().
	self assert: cls class selectors asSet equals: #(icons resetIcons gtInspectorIconsIn:) asSet
]

{ #category : #tests }
IconFactoryTest >> testRemoveFromClass [
	| root cls |
	(root := FileSystem memory / 'icons') ensureCreateDirectory.
	root / 'myIcon.png'
		writeStreamDo: [ :stream | stream nextPutAll: self exampleIconContents ].
	root / 'another.png'
		writeStreamDo: [ :stream | stream nextPutAll: self exampleIconContents ].
	cls := factory ensureClassFor: #IFTestIcons.
	IconFactory loadDirectory: root intoClass: cls.
	(root / 'another.png') ensureDelete.
	IconFactory removeFromClass: cls notInDirectory: root.
	self deny: (cls class selectors includes: #anotherIcon).
	self deny: (cls class selectors includes: #anotherContents).
	self assert: (cls class selectors includes: #myIcon).
	self assert: (cls class selectors includes: #myIconContents)
]

{ #category : #tests }
IconFactoryTest >> testSelectorForName [
	self assert: (factory selectorForName: 'myIcon') equals: 'my'.
	self assert: (factory selectorForName: 'my') equals: 'my'.
	self assert: (factory selectorForName: 'my-image') equals: 'myImage'
]

{ #category : #tests }
IconFactoryTest >> testSyncDirectory [
	| root cls |
	(root := FileSystem memory / 'icons') ensureCreateDirectory.
	root / 'myIcon.png'
		writeStreamDo: [ :stream | stream nextPutAll: self exampleIconContents ].
	cls := factory ensureClassFor: #IFTestIcons.
	IconFactory syncDirectory: root intoClass: cls.
	self assert: (cls class selectors includes: #myIcon).
	self assert: (cls class selectors includes: #myIconContents)
]
