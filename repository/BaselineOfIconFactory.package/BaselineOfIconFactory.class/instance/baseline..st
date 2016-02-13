baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do:
			[ spec blessing: #baseline.
			spec package: 'IconFactory'.
			spec group: 'default' with: #('IconFactory') ]