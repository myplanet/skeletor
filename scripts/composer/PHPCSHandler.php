<?php

namespace Skeletor\composer;

/**
 * @file
 * Contains \Skeletor\composer\PHPCSHandler.
 */

use Composer\Script\Event;

/**
 * Adds Drupal code sniffs to the installed PHP Codesniffer.
 */
class PHPCSHandler extends BaseHandler {

  /**
   * Runs the configuration command to associate PHPCS with coder Drupal sniffs.
   */
  public static function installDrupalSniffs(Event $event) {
    $path = static::getProjectRoot();
    exec("cd $path; vendor/bin/phpcs --config-set installed_paths vendor/drupal/coder/coder_sniffer");
  }

}
