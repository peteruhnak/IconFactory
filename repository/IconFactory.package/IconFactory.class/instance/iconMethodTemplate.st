private - templates
iconMethodTemplate
	^ '{1}
	"Private - Generated method"
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self {1}Contents readStream)'