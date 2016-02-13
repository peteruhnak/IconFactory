symbolic versions
development: spec
	<symbolicVersion: #development>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:master/repository' ];
				import: 'IconFactory' ]