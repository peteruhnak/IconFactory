loading
loadDirectory: aDirectory intoClass: aClassOrName
	| cls |
	cls := self ensureClassFor: aClassOrName.
	self createIconsFromDirectory: aDirectory asFileReference inClass: cls