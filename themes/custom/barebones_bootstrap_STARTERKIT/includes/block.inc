<?php

use Drupal\block\Entity\Block;

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 *
 * Declared for blocks.
 */
function barebones_theme_suggestions_block_alter(array &$suggestions, array $variables) {
  $elements = $variables['elements'];

  $bundle = '';
  if (isset($elements['content']['#block_content'])) {
    if (is_object($elements['content']['#block_content'])) {
      $bundle = $elements['content']['#block_content']->bundle();
    }
  }

  // Add per region block theme hook suggestions.
  if (!empty($elements['#id'])) {
    $block = Block::load($elements['#id']);
    $suggestions[] = 'block__' . $block->getRegion();
    if ($bundle) {
      $suggestions[] = 'block__' . $bundle;
      $suggestions[] = 'block__' . $block->getRegion() . '__' . $bundle;
    }
    $suggestions[] = 'block__' . $block->getRegion() . '__' . $elements['#base_plugin_id'];
    $suggestions[] = 'block__' . $elements['#id'];
  }
  return $suggestions;
}


/**
 * Implements hook_preprocess_HOOK().
 *
 * Pass block region value to content so this can be used in
 * MYTHEME_theme_suggestions_menu_alter.
 */
function barebones_preprocess_block(&$variables) {
  $elements = $variables['elements'];

  if (isset($elements['#id'])) {
    // Pass block region to entity inside block (used for menus).
    $region = Block::load($elements['#id'])->getRegion();
    $variables['content']['#attributes']['region'] = $region;
  }
}
