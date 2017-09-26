<?php

namespace DrupalSkeletor;

use Composer\Script\Event;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Finder\Finder;
use DrupalFinder\DrupalFinder;

/**
 * Class ProductionBuild.
 *
 * @package DrupalSkeletor
 */
class ProductionBuild {

  /**
   * Get Drupal Root.
   *
   * @return string
   *   Path to Drupal Root.
   */
  protected static function getDrupalRoot($project_root) {
    $drupalFinder = new DrupalFinder();
    if ($drupalFinder->locateRoot(getcwd())) {
      return $drupalFinder->getDrupalRoot();
    }
  }

  public static function placeGitIgnore(Event $event) {
    $filesystem = new Filesystem();
    $project_root = getcwd();

    if ($filesystem->exists($project_root . '/prod.gitignore')) {
      $filesystem->copy($project_root . '/prod.gitignore', $project_root . '/.gitignore', TRUE);
      $event->getIO()->write("    Placed production gitignore in project root.");
    }
  }

  public static function removeGitFolders(Event $event) {
    $filesystem = new Filesystem();
    $finder = new Finder();
    $drupal_root = static::getDrupalRoot(getcwd());

    // Find all .git directories found in the drupal root,
    // searching only contrib, node_modules, or vendor folders.
    $git_dirs = $finder->directories()->ignoreVCS(FALSE)->ignoreDotFiles(FALSE)
      ->in($drupal_root)->name(".git")->path("/contrib|node_modules|vendor/");

    // Remove them.
    $filesystem->remove($git_dirs);

    $event->getIO()->write("    Removed git instances in vendor or contrib directories");
  }
}
