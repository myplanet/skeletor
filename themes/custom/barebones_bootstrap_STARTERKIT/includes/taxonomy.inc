<?php

/**
 * @file
 * Preprocess term functions.
 */

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 *
 * Declared for taxonomy terms.
 */
function barebones_theme_suggestions_taxonomy_term_alter(array &$suggestions, array $variables) {
  $elements = $variables['elements'];
  $bundle = $elements['name']['#bundle'];
  $view_mode = $elements['#view_mode'];
  $type = $elements['#entity_type'];

  // Add per view mode template suggestions for taxonomy.
  $suggestions[] = $type . '__' . $bundle;
  $suggestions[] = $type . '__' . $bundle . '__' . $view_mode;

  return $suggestions;
}
