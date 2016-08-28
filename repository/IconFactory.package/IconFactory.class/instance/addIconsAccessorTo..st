private - utilities
addIconsAccessorTo: aClass
	(aClass hasClassVarNamed: 'icons')
		ifFalse: [ aClass addClassVarNamed: 'icons' ].
	(aClass class selectors includes: #icons)
		ifFalse: [ aClass class compile: self iconsAccessorTemplate classified: 'accessing' ].
	(aClass class selectors includes: #resetIcons)
		ifFalse: [ aClass class compile: self resetIconsTemplate classified: 'accessing - reset' ].
	(aClass class selectors includes: #gtInspectorIconsIn:)
		ifFalse: [ aClass class compile: self gtInspectorTemplate classified: 'GT-InspectorExtensions' ].