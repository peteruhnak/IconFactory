loading
loadZip: aZipFile intoClass: aClassOrName
	| cls tmpDir |
	cls := self ensureClassFor: aClassOrName.
	tmpDir := (FileLocator temp asFileReference / UUID new asString) createDirectory.
	(ZipArchive new readFrom: aZipFile) members
		do: [ :member | member extractInDirectory: tmpDir overwrite: true ].
	self createIconsFromDirectory: tmpDir asFileReference inClass: cls.
 	tmpDir delete