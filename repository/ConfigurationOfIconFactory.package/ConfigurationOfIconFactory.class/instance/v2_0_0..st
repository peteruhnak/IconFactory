versions
v2_0_0: spec
	<version: 'v2.0.0'>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:v2.0.0/repository' ];
				import: 'IconFactory' ]