# Skeletor Install Profile

A skeleton Drupal install profile to set up an appropriate layout for Myplanet's install profile development strategy, striving toward continuous delivery and greater good.

## Status
[![Build Status](https://magnum.travis-ci.com/myplanetdigital/relay-robin-support-portal.svg?token=s3BFKzEdHAWesqwWTSpU&branch=develop)](https://magnum.travis-ci.com/myplanetdigital/relay-robin-support-portal)

## Build instructions

### 1. Requirements

* PHP 5.5.9 or higher
* Drush 8
* Drupal Console 8.0.0+

May be usefull to get multiple versions of drush locally https://www.lullabot.com/articles/switching-drush-versions

### 2. Building drupal

From the install profile folder:

`bash tmp/scripts/build-dev.sh [ path/to/your/profile.make.yml] [ path/to/build/docroot ]`

### 3. Installing drupal from the profile

From the path/to/build/docroot/profile/profile folder:

`bash install.sh [ mysql:// db url ] [ desired account pass ]`

## Layout

We will be attempting to follow [the Drupal 8 installation profile guidelines laid out for 
packaging distributions on drupal.org](https://www.drupal.org/node/2210443).

The rationale being that when we layout our projects according to these
guidelines, we don't need to document as much, and we will also know how
to package our own distribution for drupal.org in the future.

Here's the additional suggested folder structure for the install profile:

    +-modules/
    | +-contrib/  (gitignored - all contrib modules should go here via makefile)
    | +-custom/   (custom modules and features for the site)
    +-themes/
    | +-contrib/  (gitignored - any contrib themes should go here via makefile)
    | +-custom/   (custom themes for the site)
    +-libraries/  (gitignored - any libraries should go here via makefile)
    +-tmp/        (for things that don't fit in standard install profile structure)
    | +-conf/
    | +-docs/     (project-specific docs)
    | +-patches/
    | +-scripts/  (any scripts related to project)
    | +-snippets/ (settings.php and htaccess snippets)
    | | +-htaccess/
    | | +-settings.php/
    | +-tests/

*The `tmp/` directory is intended to be removed before pushing to production.*

* If you'd like any code to be appended to `settings.php`, simply add a
snippet as `tmp/snippets/settings.php/mysnippetname.settings.php`. These
snippets will be appended in alphabetical order during the build script.

