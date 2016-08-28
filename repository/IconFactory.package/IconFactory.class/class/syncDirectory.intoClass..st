installing
syncDirectory: aDirectory intoClass: aClassOrName
	self
		loadDirectory: aDirectory
		intoClass: aClassOrName.
	self
		removeFromClass: aClassOrName
		notInDirectory: aDirectory