<?php

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 *
 * Provide region based menu suggestions.
 */
function barebones_theme_suggestions_menu_alter(&$suggestions, array $variables) {
  if (isset($variables['attributes']['region'])) {
    // Create a template suggestions based on block region location.
    $region_suggestion = 'menu__' . $variables['menu_name'] . '__' . $variables['attributes']['region'];
    $suggestions[] = barebones_suggestion_safe($region_suggestion);
  }
  return $suggestions;
}
