<?php

/**
 * @file
 * Preprocess views functions.
 */

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 *
 * Declared for views view unformatted.
 */
function barebones_theme_suggestions_views_view_unformatted_alter(array &$suggestions, array $variables, $hook) {
  $view = $variables['view'];
  $display = $view->getDisplay();

  // Add per view mode template suggestions for taxonomy.
  $suggestions[] = $hook . '__' . $view->id();
  $suggestions[] = $hook . '__' . $view->id() . '__' . $display->display['id'];

  return $suggestions;
}
