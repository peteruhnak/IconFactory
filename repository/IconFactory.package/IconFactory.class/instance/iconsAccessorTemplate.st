private - templates
iconsAccessorTemplate
	^ 'icons
	^ icons
		ifNil: [ (icons := LRUCache new)
				maximumWeight: 64;
				factory: [ :key | self perform: key ] ]'