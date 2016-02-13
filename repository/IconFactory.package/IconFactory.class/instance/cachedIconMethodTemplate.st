private - templates
cachedIconMethodTemplate
	^ '{1}
	"Private - Generated method"
	^icons 
			at: #{1}
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self {1}Contents readStream) ].'