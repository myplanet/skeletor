# Skeletor Install Profile <img  height="30px" width="30px" src="https://cdn.rawgit.com/wiki/myplanetdigital/drupal-skeletor/images/noun_131083_cc.svg" alt="Skeletor"> 

[![Build Status](https://travis-ci.org/myplanetdigital/drupal-skeletor.svg?branch=8.x)](https://travis-ci.org/myplanetdigital/drupal-skeletor)

A skeleton Drupal install profile to set up an appropriate layout for Myplanet's install profile development strategy, striving toward continuous delivery and greater good.

<small>[Skull icon by Andre Cameron](https://thenounproject.com/CrocodileJock/collection/skulls/?oq=skull&cidx=0&i=131083)</small>

## Table of Contents

1. [Build Instructions](#1-build-instructions)
2. [Layout](#2-layout)
3. [Documentation](#3-documentation)
4. [Configuration Management](#4-configuration-management)
5. [Production Build Requirements](#5-production-build-requirements)

## 1. Build Instructions

### Requirements

* PHP 5.6.*
* Drush 8.0.*
* Drupal Console 8.0.*
* Compass 1.0.*

May be useful to get [multiple versions of drush locally](https://www.lullabot.com/articles/switching-drush-versions)

### Building drupal

From the project root:

`composer install`


### Adjusting Drupal files

You an make adjustments to files provided by Drupal directly, such as `settings.php`, `.htaccess`, or `robots.txt`.

Commit the file with the changes in it's desired place within the docroot, such as `robots.txt`. Add it to
drupal-scaffold:excludes array in composer.json, to prevent it from being overwritten during the build process.

    "extra": {
      "drupal-scaffold": {
        "excludes": [
          "robots.txt",
          "sites/default/default.settings.php"
        ]

By default, we have excluded the settings.php file in the build process already. You can read more about further
[customizing the drupal build process at the Drupal-Scaffold
documentation](https://github.com/drupal-composer/drupal-scaffold/blob/master/README.md).

## 2. Layout

We will be attempting to follow [guidelines for a Drupal 8 composer project](https://github.com/drupal-composer/drupal-project).

From the project root, we will be following this structure:

    +-config/         (configuration that will be version controlled)
    +-docroot/        (configuration that will be version controlled)
    | +-core/         (drupal 8 core)
    | +-sites/        (sites directory with required settings.php et al.)
    | +-profiles/     
    | | +-skeletor/   (full installation profile including modules for Skeletor project)
    +-drush/          (commands, configuration and site aliases for Drush)
    +-hooks/          (Acquia cloud hooks)
    +-scripts/        
    | +-composer/     (scripts used during the composer build process)
    | +-travis/       (scripts used during the travis build process)

Here's the additional suggested folder structure for the install profile:

    +-modules/
    | +-contrib/        (gitignored - all contrib modules should go here via makefile)
    | +-custom/         (custom modules for the site)
    +-themes/
    | +-contrib/        (gitignored - any contrib themes should go here via makefile)
    | +-custom/         (custom themes for the site)

## 3. Documentation

Documentation for this project (and Skeletor based projects) should be placed in their [github wiki](/wiki).

## 4. Configuration Management

The Configuration Management system provides a consistent API for defining and 
syncing configuration between instances of a Drupal site. [Read more about 
configuration management in our wiki](https://github.com/myplanetdigital/drupal-skeletor/wiki/Setup-&-Working-with-Configuration-Management)

## 5. Production Build Requirements

### Trusted host security setting in Drupal 8

Drupal 8 supports [trusted host patterns](https://www.drupal.org/node/2410395), where you can (and should) 
specify a set of regular expressions that the domains on incoming requests must match. 
It is important to setup them before deploying to ACQUIA or PANTHEON environments.
