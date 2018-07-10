<?php

namespace Skeletor\composer;

/**
 * @file
 * Contains \Skeletor\composer\ProductionBuild.
 */

/**
 * Base class for Skeletor script handlers.
 */
abstract class BaseScriptHandler {

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

}
