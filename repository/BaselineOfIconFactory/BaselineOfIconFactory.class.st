"
I am a baseline for https://github.com/peteruhnak/IconFactory
"
Class {
	#name : #BaselineOfIconFactory,
	#superclass : #BaselineOf,
	#category : 'BaselineOfIconFactory'
}

{ #category : #actions }
BaselineOfIconFactory class >> updateReadme [
	<script>
	| repo |
	repo := MCFileTreeGitRepository allInstances
		detect: [ :each | each shortDirectoryDescription = 'IconFactory/repository' ].
	(repo directory parent / 'README.md')
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream wantsLineEndConversion: true.
			stream
				nextPutAll: '# IconFactory ';
				nextPutAll:
					'[![Build Status](https://travis-ci.org/peteruhnak/IconFactory.svg?branch=master)](https://travis-ci.org/peteruhnak/IconFactory)';
				nextPutAll: String lf;
				nextPutAll: String lf.
			stream nextPutAll: IconFactory comment ]
]

{ #category : #baseline }
BaselineOfIconFactory >> baseline: spec [
	<baseline>
	spec
		for: #common
		do:
			[ spec blessing: #baseline.
			spec package: 'IconFactory'.
			spec group: 'default' with: #('IconFactory') ]
]
