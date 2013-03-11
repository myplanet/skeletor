skeletor Install Profile
===========================

[![Build Status](https://travis-ci.org/myplanetdigital/drupal-skeletor.png)](https://travis-ci.org/myplanetdigital/drupal-skeletor)
[![Selenium Test Status](https://saucelabs.com/buildstatus/myplanet-skeletor)](https://saucelabs.com/u/myplanet-skeletor)

This is the D7 install profile for the skeletor project, to set up an
appropriate layout for a build-based development strategy, striving
toward continuous delivery and great good.

Layout
------

We will be attempting to follow the drush make guidelines laid out for
packaging distributions on drupal.org:

http://drupal.org/node/1476014

The rationale being that when we layout our projects according to these
guidelines, we don't need to document as much, and we will also know how
to package our own distribution for drupal.org in the future.

Here's the additional suggested folder structure for the install profile:

    +-modules/
    | +-contrib/  (gitignored - all contrib modules should go here via makefile)
    | +-custom/   (custom modules for the site)
    | +-features/ (all feature modules)
    +-themes/
    | +-contrib/  (gitignored - any contrib themes should go here via makefile)
    | +-custom/   (custom themes for the site)
    +-libraries/
    | +-contrib/  (gitignored - any libraries should go here via makefile)
    | +-custom/   (custom libraries for the site)
    +-tmp/        (for things that don't fit in standard install profile structure)
      +-conf/
      +-docs/     (project-specific docs)
      +-patches/
      +-scripts/  (any scripts related to project)
      +-snippets/ (settings.php and htaccess snippets)
      | +-htaccess/
      | +-settings.php/
      +-tests/

*The `tmp/` directory is intended to be removed before pushing to Acquia.*

* If you'd like any code to be appended to `settings.php`, simply add a
snippet as `tmp/snippets/settings.php/mysnippetname.settings.php`. These
snippets will be appended in alphabetical order during the build script.

To Build
--------

To build the site in full, run the following command:

    bash kickstart.sh path/to/build/docroot
