actions
updateReadme
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