tests
testSyncDirectory
	| root cls |
	(root := FileSystem memory / 'icons') ensureCreateDirectory.
	root / 'myIcon.png'
		writeStreamDo: [ :stream | stream nextPutAll: self exampleIconContents ].
	cls := factory ensureClassFor: #IFTestIcons.
	IconFactory syncDirectory: root intoClass: cls.
	self assert: (cls class selectors includes: #myIcon).
	self assert: (cls class selectors includes: #myIconContents)