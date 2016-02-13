versions
v1_1_1: spec
	<version: 'v1.1.1'>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:v1.1.1/repository' ];
				import: 'IconFactory' ]