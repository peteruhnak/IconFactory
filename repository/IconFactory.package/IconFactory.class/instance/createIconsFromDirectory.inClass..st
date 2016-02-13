public
createIconsFromDirectory: aDirectory inClass: aClass
	| dir files |
	dir := aDirectory asFileReference.
	files := dir allFiles select: [ :each | each extension = 'png' ].
	files do: [ :each | self createIconFromFile: each inClass: aClass ].
	cached
		ifTrue: [ aClass new initializeIcons ]