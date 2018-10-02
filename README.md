# <img src="skeletor.svg" alt="Skeletor icon">Skeletor Install Profile 

[![Build Status](https://travis-ci.org/myplanetdigital/drupal-skeletor.svg?branch=8.2.x)](https://travis-ci.org/myplanetdigital/drupal-skeletor)

A skeleton Drupal install profile that scaffolds Myplanet projects.

<small>[Skull icon by Andre Cameron](https://thenounproject.com/CrocodileJock/collection/skulls/?oq=skull&cidx=0&i=131083)</small>

<!-- TOC depthFrom:2 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [1. Build Instructions](#1-build-instructions)
	- [Requirements](#requirements)
	- [Building Drupal](#building-drupal)
	- [Customizing your build](#customizing-your-build)
		- [Script List](#script-list)
		- [Full Example](#full-example)
	- [Adjusting Drupal files](#adjusting-drupal-files)
- [2. Layout](#2-layout)
- [3. Theme](#3-theme)
- [4. Modules](#4-modules)
- [5. Features](#5-features)
- [6. Documentation](#6-documentation)
- [7. Configuration Management](#7-configuration-management)
- [8. Production Build Requirements](#8-production-build-requirements)
	- [Trusted host security setting in Drupal 8](#trusted-host-security-setting-in-drupal-8)

<!-- /TOC -->

## 1. Build Instructions

### Requirements

* PHP 7.0.*
* Composer 1.0.0+

### Building Drupal

To start a new project based on Skeletor in `[target-dir-name]`, run:

``` bash
composer create-project drupal-composer/drupal-project:8.x-dev some-dir --stability dev --no-interaction
cd some-dir
```

Open `composer.json` in `some-dir` and add `"enable-patching": true` in the `"extra"` section.

``` json
{
    "extra": {
        "enable-patching": true
    }
}
```    

Now add skeletor as a dependency to your build:

``` bash
composer require myplanet/skeletor:8.2.x-dev
```

Once skeletor has successfully been added to the build we need to include scaffold files provided by skeletor. By default you will get Acquia cloud hooks, travis scripts, a .gitignore file to use on production and a .travis.yml file with sensible defaults. From the **project root**:

``` bash
./vendor/bin/skeletor-init-project.sh
```

In order to create a sub profile based on Skeletor, you have to apply a patch to Drupal core (until it's incorporated [into core](https://www.drupal.org/project/drupal/issues/1356276)). To do so, add the following to your ```composer.json```

```json
"patches": {
    "drupal/core": {
        "1356276 - Allow profiles to provide a base/parent profile and load them in the correct order":
        "https://www.drupal.org/files/issues/1356278-408--8.5.x-real.patch"
    }
},
```

Then connect your new project to a git repository, from the project folder run:

``` bash
git init
git remote add origin [git-url]
git add -A
git commit -m "Initial Commit"
git push origin
```

### Customizing your build

Skeletor ships with composer scripts which can be viewed inside `skeletor/scripts/composer`. These can be added to your `composer.json` to automate parts of your build.

**These scripts run during `composer install` or `composer update` so you will have to execute those again.**

#### Script List

- `Skeletor\\composer\\PHPCSHandler::installDrupalSniffs`

    PHP Code Sniffer is installed at the project level. Because Drupal has unique lint rules we include them with the `coder` project. This script attaches the Drupal specific lint rules to PHP Code Sniffer.

- `Skeletor\\composer\\ProductionHandler::installNPM`

    Searches project directories and runs `npm install` in directories where package.json is discovered.

- `Skeletor\\composer\\ProductionBuild::placeGitIgnore`

    Looks for `prod.gitignore` in the project root and copies it to `.gitignore`. This is useful as a deploy step for Acquia.

- `Skeletor\\composer\\ProductionBuild::removeGitFolders`

    Searches project directories looking for `.git` directories which signify a git repository. It removes the discovered `.git` directories to prepare these dependencies to be committed to the Acquia deployment repository.

#### Full Example
Example of the `scripts` section of your `composer.json`.

``` json
{
    "scripts": {
        "deploy": [
            "@composer install --prefer-dist --no-dev",
            "Skeletor\\composer\\ProductionBuild::removeGitFolders",
            "Skeletor\\composer\\ProductionBuild::placeGitIgnore"
        ],
        "pre-install-cmd": [
            "DrupalProject\\composer\\ScriptHandler::checkComposerVersion"
        ],
        "pre-update-cmd": [
            "DrupalProject\\composer\\ScriptHandler::checkComposerVersion"
        ],
        "post-install-cmd": [
            "DrupalProject\\composer\\ScriptHandler::createRequiredFiles",
            "Skeletor\\composer\\ProductionHandler::installNPM",
            "Skeletor\\composer\\PHPCSHandler::installDrupalSniffs"
        ],
        "post-update-cmd": [
            "DrupalProject\\composer\\ScriptHandler::createRequiredFiles",
            "Skeletor\\composer\\ProductionHandler::installNPM",
            "Skeletor\\composer\\PHPCSHandler::installDrupalSniffs"
        ]
    }
}
```

### Adjusting Drupal files

You can make adjustments to files provided by Drupal directly, such as `settings.php`, `.htaccess`, or `robots.txt`.

Commit the file with the changes in it's desired place within the docroot (web), such as `robots.txt`. Add it to drupal-scaffold:excludes array in composer.json, to prevent it from being overwritten during the build process.

``` json
{
    "extra": {
        "drupal-scaffold": {
            "excludes": [
                "robots.txt"
            ]
        }
    }
}
```

By default, we have excluded the settings.php file in the build process already. You can read more about further [customizing the drupal build process at the Drupal-Scaffold documentation](https://github.com/drupal-composer/drupal-scaffold/blob/master/README.md).

## 2. Layout

With 8.2.x we have pared Skeletor down to an install profile.

Skeletor will be installed within a drupal-project composer build: [guidelines for a Drupal 8 composer project](https://github.com/drupal-composer/drupal-project).

Skeletor profile is installed in `web/profiles/contrib/skeletor`

Installation of Skeletor will scaffold the project with the following:

- A starter `.travis.yml` to ease CI.
- Default **Acquia cloud hooks** are symlinked to the project root. You are free remove the symlink and implement your own hooks.
- PHP Codesniffer installed as a project dependency with Drupal code sniffs pre-installed.
- Drush alias boilerplate.
- local configuration files (settings.local.php, etc)
- Opt In **git hooks** which can be linked into the project `.git/hooks` directory.

## 3. Theme

Skeletor has a base theme (`barebones`) and one starterkit sub-theme that implements Bootstrap. Teams that want to create a child theme that is based on a different framework, they can base them off the base theme.

The base theme (`barebones`) has the following:

- Mixin/preprocess for easily inserting SVG as data-uri in sass
- Libraries for each feature in css framework
- Out-of-the-box template suggestions for:
  - form
  - form elements
  - container
  - fields
  - blocks
  - taxonomy terms
  - paragraphs
  - media

The child theme (barebones_bootstrap_STARTER) has the following:

- Bootstrap
- Linters (sass-linter, eslint)
- Live style guide
- Templates for common features
- Webpack integration
- Images in src/images moved and optimized to dist/images dir
- SVG in src/svg moved and optimized to dist/svg
- Icon font with svg files in src/icons

Note: Teams should feel free to create new child themes from the base theme with different CSS frameworks and add new starterkit themes

## 4. Modules

Skeletor contains modules that are commonly used in Myplanet projects:

- paragraphs
- pathauto
- devel
- admin_toolbar
- rabbit_hole
- google_tag
- robotstxt
- field_group
- twig_tweak
- coder
- squizlabs/php_codesniffer
- svg_image
- memcache
- config_split
- xmlsitemap
- metatag
- seckit

## 5. Features

Skeletor contains the following features:

- Skeletor Acquia
- Skeletor Media
- Skeletor Search

## 6. Documentation

Documentation for this project (and Skeletor based projects) should be placed in their [github wiki](/wiki).

## 7. Configuration Management

The Configuration Management system provides a consistent API for defining and syncing configuration between instances of a Drupal site. [Read more about configuration management in our wiki](https://github.com/myplanetdigital/drupal-skeletor/wiki/Setup-&-Working-with-Configuration-Management)

## 8. Production Build Requirements

### Trusted host security setting in Drupal 8

Drupal 8 supports [trusted host patterns](https://www.drupal.org/node/2410395), where you can (and should) specify a set of regular expressions that the domains on incoming requests must match. It is important to setup them before deploying to ACQUIA or PANTHEON environments.
