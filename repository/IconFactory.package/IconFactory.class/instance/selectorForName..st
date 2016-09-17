private - utilities
selectorForName: aString
	| parts |
	parts := (aString withoutSuffix: 'Icon') splitOn: '-'.
	^ ((parts collect: #capitalized) joinUsing: '') uncapitalized