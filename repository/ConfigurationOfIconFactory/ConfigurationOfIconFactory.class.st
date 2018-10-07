"
I am a configuration for https://github.com/peteruhnak/IconFactory
"
Class {
	#name : #ConfigurationOfIconFactory,
	#superclass : #ConfigurationOf,
	#category : 'ConfigurationOfIconFactory'
}

{ #category : #catalog }
ConfigurationOfIconFactory class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ '
- 1.0 - initial release
'
]

{ #category : #catalog }
ConfigurationOfIconFactory class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'https://github.com/peteruhnak/IconFactory'
]

{ #category : #catalog }
ConfigurationOfIconFactory class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'IconFactory is an utility for persisting icons inside image. Give it path to icons on your disk and it will generate methods for you in ==ThemeIcons== style.'
]

{ #category : #catalog }
ConfigurationOfIconFactory class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'IconFactory'
]

{ #category : #catalog }
ConfigurationOfIconFactory class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(#icons)
]

{ #category : #versions }
ConfigurationOfIconFactory >> baseline_v2_x: spec [
	<version: '2.x-baseline'>
	spec
		for: #common
		do: [ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:master/repository' ];
				import: 'IconFactory' ]
]

{ #category : #'symbolic versions' }
ConfigurationOfIconFactory >> development: spec [
	<symbolicVersion: #development>
	spec for: #common version: '2.x-baseline'
]

{ #category : #'symbolic versions' }
ConfigurationOfIconFactory >> stable: spec [
	<symbolicVersion: #stable>
	spec for: #'pharo4.x' version: 'v1.1.1'.
	spec for: #'pharo5.x' version: 'v2.0.0'.
	spec for: #'pharo6.x' version: 'v2.0.0'
]

{ #category : #versions }
ConfigurationOfIconFactory >> v1_1_0: spec [
	<version: 'v1.1.0'>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:v1.1.0/repository' ];
				import: 'IconFactory' ]
]

{ #category : #versions }
ConfigurationOfIconFactory >> v1_1_1: spec [
	<version: 'v1.1.1'>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:v1.1.1/repository' ];
				import: 'IconFactory' ]
]

{ #category : #versions }
ConfigurationOfIconFactory >> v2_0_0: spec [
	<version: 'v2.0.0'>
	spec
		for: #common
		do:
			[ spec
				baseline: 'IconFactory'
					with: [ spec repository: 'github://peteruhnak/IconFactory:v2.0.0/repository' ];
				import: 'IconFactory' ]
]
