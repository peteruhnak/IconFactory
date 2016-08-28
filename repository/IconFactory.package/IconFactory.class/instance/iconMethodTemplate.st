private - templates
iconMethodTemplate
	^ '{1}
	"Private - Generated method"
	^ self icons
		at: #{1}
		ifAbsentPut: [ Form
				fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self {1}Contents readStream) ]'