IconFactory is a utility for creating icons from files.

!! 1. Preparing an Icons Class.
If you wish to have support for:
- GTInspector support listing the icons
- icon cache
- singleton icon class

Then run (MyIcons class must already exist)

IconFactory new setup: MyIcons.

Note that this will create/override initialize method in MyIcons!

!! 2. Loading the Icons and Creating Selectors

To create the selectors you need to run

IconFactory new 
	createIconsFromDirectory: '/my/directory/containing/png/icons'
	inClass: MyIcons.
	
If you skipped the first step and do not want to use cache, use this instead

IconFactory new
	noCache;
	createIconsFromDirectory: '/my/directory/containing/png/icons'
	inClass: MyIcons.

