installing
createIconFromFile: aFile inClass: aClass
	^ self new
		createIconFromFile: aFile asFileReference
		inClass: BormEditorIcons