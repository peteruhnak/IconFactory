public
setup: aClass
	self addClassSideTo: aClass.
	self addInitializeIconsTo: aClass.
	self addInitializeTo: aClass.
	self addGtInspectorTo: aClass.
	self addIconSelectorTo: aClass