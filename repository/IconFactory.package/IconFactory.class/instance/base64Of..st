private - utilities
base64Of: aFileReference
	^ (Base64MimeConverter mimeEncode: aFileReference readStream binary) contents