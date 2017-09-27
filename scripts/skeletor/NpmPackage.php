<?php

namespace DrupalSkeletor;

use Composer\Script\Event;
use Symfony\Component\Finder\Finder;
use DrupalFinder\DrupalFinder;

/**
 * Class NpmPackage.
 *
 * @package DrupalSkeletor
 */
class NpmPackage {

  /**
   * NPM Install.
   *
   * @param \Composer\Script\Event $event
   *   Event to echo output.
   */
  public static function npmInstall(Event $event) {
    static::runNpmCommand('install', $event);
  }

  /**
   * NPM Run Test.
   *
   * @param \Composer\Script\Event $event
   *   Event to echo output.
   */
  public static function npmTest(Event $event) {
    static::runNpmCommand('run test', $event);
  }

  /**
   * NPM Run Build.
   *
   * @param \Composer\Script\Event $event
   *   Event to echo output.
   */
  public static function npmBuild(Event $event) {
    static::runNpmCommand('run build', $event);
  }

  /**
   * Get Package Root.
   *
   * @return string
   *   Path to Drupal Root.
   */
  protected static function getPackageRoot() {
    $drupalFinder = new DrupalFinder();
    if ($drupalFinder->locateRoot(getcwd())) {
      return $drupalFinder->getDrupalRoot();
    }
  }

  /**
   * Find the NPM packages, excluding some directories.
   *
   * @param string $packageRoot
   *   Path to Drupal Root.
   *
   * @return array
   *   Array of found package.json files.
   */
  protected static function findNpmPackages($packageRoot) {
    // Find all npm instances in the package root,
    // that are not contained in contrib, vendor or node_module directories.
    $finder = new Finder();
    return $finder->in($packageRoot)->notPath("/core|contrib|vendor|node_modules/")->name("package.json");
  }

  /**
   * Helper to run arbitrary npm scripts.
   *
   * @param string $command
   *   Command to run.
   * @param \Composer\Script\Event $event
   *   Event to echo output.
   */
  protected static function runNpmCommand($command, Event $event) {
    $packageRoot = static::getPackageRoot();
    foreach (static::findNpmPackages($packageRoot) as $package) {
      $path = $package->getRelativePath();
      $event->getIO()->write("    Running npm $command in $path");
      exec("cd $packageRoot/$path; npm $command");
    }
  }

}
