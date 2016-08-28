IconFactory is a utility for importing PNG images from a directory into a class.

Each file will be compiled into the **class-side** of the target class as `<fileName>Icon` selector. (Icon suffix will not be duplicated.).

Once imported, you can access the `Form` (Pharo's image representation) by sending the appropriate selector, e.g. `MyIcons myCoolIcon`.

![](figures/playground-demo.png)

Only PNG files are currently supported.

## Loading images into a class

If `MyIcons` class doesn't exist, it will be created in a category of the same name.

This method will install all images not present in #MyIcons and remove all icons not present in the directory.

```st
IconFactory
	syncDirectory: '/home/some/path/myIcons'
	intoClass: #MyIcons
```

It effectively combines the following two options.

## Add only images

Add all images from the directory into the class.

```st
IconFactory
	loadDirectory: 'd:\some\path\myIcons'
	intoClass: #MyIcons
```

## Remove old selectors

Remove all selectors (icons) from the class that are not present in the directory.

```st
IconFactory
	removeFromClass: #MyIcons
	notInDirectory: 'd:\some\path\myIcons'
```

## Creating icon for a single file

There are private methods that you can use at your own risk. Adding manually images one by one suggests a flaw in a workflow (that was the case for me anyway); but feel free to open a issue with your use case.