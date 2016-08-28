tests
testRemoveFromClass
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