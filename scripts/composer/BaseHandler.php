<?php

namespace Skeletor\composer;

/**
 * @file
 * Contains \Skeletor\composer\ProductionBuild.
 */

use Composer\Script\Event;

/**
 * Base class for Skeletor script handlers.
 */
abstract class BaseHandler {

  /**
   * Get the project root path.
   */
  protected static function getProjectRoot() {
    return getcwd();
  }

  /**
   * Get the Drupal root path.
   */
  protected static function getDrupalRoot() {
    return self::getProjectRoot() . '/web';
  }

  /**
   * String of the most common contrib install paths.
   */
  protected static function getContribDirs() {
    return '/bower_components|core|contrib|libraries|node_modules|vendor/';
  }

  /**
   * Provides the full path of the operation package.
   */
  protected static function getPackageInstallPath(Event $event) {
    $installManager = $event->getComposer()->getInstallationManager();
    $package = $event->getOperation()->getPackage();

    return $installManager->getInstallPath($package);
  }

}
