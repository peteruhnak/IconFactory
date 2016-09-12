versions
baseline_v2_x: spec
	<version: '2.x-baseline'>
	spec
		for: #common
		do: [ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:master/repository' ];
				import: 'IconFactory' ]