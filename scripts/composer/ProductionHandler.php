<?php

namespace Skeletor\composer;

/**
 * @file
 * Contains \Skeletor\composer\ProductionBuild.
 */

use Composer\Script\Event;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Finder\Finder;

class ProductionHandler extends BaseScriptHandler {

  public static function placeGitIgnore(Event $event) {
    $filesystem = new Filesystem();
    $project_root = static::getProjectRoot();

    if ($filesystem->exists($project_root . '/prod.gitignore')) {
      $filesystem->copy($project_root . '/prod.gitignore', $project_root . '/.gitignore', TRUE);
      $event->getIO()->write("    Placed production gitignore in project root.");
    }
  }

  public static function removeGitFolders(Event $event) {
    $filesystem = new Filesystem();
    $finder = new Finder();
    $drupal_root = static::getDrupalRoot();

    // Find all .git directories found in the drupal root.
    $git_dirs = $finder->directories()->ignoreVCS(FALSE)->ignoreDotFiles(FALSE)
      ->in($drupal_root)->name(".git")->path(static::getContribDirs());

    // Remove them.
    $filesystem->remove($git_dirs);

    $event->getIO()->write("    Removed git instances in vendor or contrib directories");
  }

  public static function installNPM(Event $event) {
    $finder = new Finder();
    $drupal_root = static::getDrupalRoot();

    // Find all npm instances in the drupal root,
    // that are not contained in contrib or vendor directories.
    $npm = $finder->in($drupal_root)->notPath(static::getContribDirs())->name("package.json");

    foreach ($npm as $package) {
      $path = $package->getRelativePath();
      $event->getIO()->write("    Running npm install in $path");
      exec("cd $drupal_root/$path; npm install");
    }
  }

}
