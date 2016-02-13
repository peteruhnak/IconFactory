versions
v1_1_0: spec
	<version: 'v1.1.0'>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:v1.1.0' ];
				import: 'IconFactory' ]