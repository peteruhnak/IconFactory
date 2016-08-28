private - loading
createIconsFromDirectory: aDirectory inClass: aClass
	aDirectory allFiles
		select: [ :each | each extension = 'png' ]
		thenDo: [ :each | self createIconFromFile: each inClass: aClass ]