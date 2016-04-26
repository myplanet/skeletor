# Skeletor Install Profile 

[![Build Status](https://travis-ci.org/myplanetdigital/drupal-skeletor.svg?branch=8.x)](https://travis-ci.org/myplanetdigital/drupal-skeletor)

A skeleton Drupal install profile to set up an appropriate layout for Myplanet's install profile development strategy, striving toward continuous delivery and greater good.

## Build instructions

### 1. Requirements

* PHP 5.5.9 or higher
* Drush 8.0.0
* Drupal Console 8.0.0+

May be useful to get multiple versions of drush locally https://www.lullabot.com/articles/switching-drush-versions

### 2. Building drupal

From the install profile folder:

`bash tmp/scripts/build.sh [ project ] [ path/to/build/docroot ] [ branch ]`

[ branch ] - Specify a branch (or commit) to build. Avoid this parameter for a production build process.

## ACQUIA or PANTHEON build requirements

### Trusted host security setting in Drupal 8

Drupal 8 supports [trusted host patterns](https://www.drupal.org/node/2410395), where you can (and should) 
specify a set of regular expressions that the domains on incoming requests must match. 
It is important to setup them before deploying to ACQUIA or PANTHEON environments.

Trusted host settings location: tmp/snippets/settings.php/*-trusted-hosts.settings.php 

## Layout

We will be attempting to follow [the Drupal 8 installation profile guidelines laid out for 
packaging distributions on drupal.org](https://www.drupal.org/node/2210443).

The rationale being that when we layout our projects according to these
guidelines, we don't need to document as much, and we will also know how
to package our own distribution for drupal.org in the future.

Here's the additional suggested folder structure for the install profile:

    +-modules/
    | +-contrib/        (gitignored - all contrib modules should go here via makefile)
    | +-custom/         (custom modules for the site)
    +-themes/
    | +-contrib/        (gitignored - any contrib themes should go here via makefile)
    | +-custom/         (custom themes for the site)
    +-tmp/              (for things that don't fit in standard install profile structure)
    | +-docs/           (project-specific docs)
    | +-patches/
    | +-scripts/        (any scripts related to project)
    | +-snippets/       (settings.php and htaccess snippets)
    | | +-htaccess/
    | | +-settings.php/
    | | +-robots.txt/
    | +-travis_scripts/ (travis specific scripts)

* The `tmp/` directory is intended to be removed before pushing to production.*

* If you'd like any code to be appended to `settings.php`, simply add a
snippet as `tmp/snippets/settings.php/mysnippetname.settings.php`. These
snippets will be appended in alphabetical order during the build script.

