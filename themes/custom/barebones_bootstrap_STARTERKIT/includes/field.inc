<?php

/**
 * @file
 * Preprocess fields functions.
 */

use Drupal\file\Entity\File;

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 *
 * Declared for fields.
 */
function barebones_theme_suggestions_field_alter(array &$suggestions, array $variables) {
  $element = $variables['element'];
  $name = $element['#field_name'];
  $bundle = $element['#bundle'];
  $view_mode = $element['#view_mode'];
  $type = $element['#entity_type'];

  // Add per view mode template suggestions for fields.
  $suggestions[] = 'field__' . $name;
  $suggestions[] = 'field__' . $name . '__' . $view_mode;
  $suggestions[] = 'field__' . $name . '__' . $view_mode . '__' . $bundle;
  $suggestions[] = 'field__' . $name . '__' . $view_mode . '__' . $bundle . '__' . $type;

  return $suggestions;
}
