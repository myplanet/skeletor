<?php

/**
 * @file
 * Preprocess media/images functions.
 */

/**
 * Implements hook_theme_suggestions_HOOK_alter() for container templates.
 */
function barebones_theme_suggestions_responsive_image_alter(&$suggestions, array $variables) {
  $suggestions[] = $variables['theme_hook_original'] . '__' . $variables['responsive_image_style_id'];
}


/**
 * Implements hook_theme_suggestions_HOOK_alter() for container templates.
 */
function barebones_theme_suggestions_responsive_image_formatter_alter(&$suggestions, array $variables) {
  $suggestions[] = $variables['theme_hook_original'] . '__' . $variables['responsive_image_style_id'];
}
