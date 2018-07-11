<?php

/**
 * @file
 * Preprocess paragraph functions.
 */

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 */
function barebones_theme_suggestions_paragraph_alter(&$suggestions, $variables) {
  $paragraph = $variables['elements']['#paragraph'];

  // Add suggestions based on paragraph parent bundle.
  $parent = $paragraph->getParentEntity();
  if ($parent) {
    $suggestions[] = 'paragraph__' . $parent->bundle() . '__' . $paragraph->bundle();
    $suggestions[] = 'paragraph__' . $parent->bundle() . '__' . $paragraph->bundle() . '__' . $variables['elements']['#view_mode'];
  }
}
