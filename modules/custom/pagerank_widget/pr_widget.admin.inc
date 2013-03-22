<?php
/**
 * @file
 * The admin settings for the PageRank Widget module.
 */

/**
 * Implements hook_settings().
 */
function pr_widget_admin_settings() {

  $last_refresh = variable_get('pr_widget_next_execution', 0) - variable_get('pr_widget_interval', 24*60*60);
  // Execution time has to be reset to force an instant cron run.
  variable_set('pr_widget_next_execution', 0);
  // To find a cron call here looks odd, but it's the only way to have any
  // changed variables in the form being processed in the hook_cron(). After
  // submitting the form you come back on the same form and that's when all
  // new variables are available. The only drawback is that cron runs twice
  // (once at the first form load and once at the second), but that's not a
  // big deal.
  drupal_cron_run();

  $form['pr_settings'] = array(
    '#type' => 'fieldset',
    '#title' => t('PageRank'),
  );

  $form['pr_settings']['pagerank_enabled'] = array(
    '#type' => 'checkbox',
    '#title' => t('Enabled'),
    '#default_value' => variable_get('pagerank_enabled', 1),
    '#description' => t('Disabling removes the pagerank display.'),
  );

  $form['pr_settings']['pr_widget_string'] = array(
    '#type' => 'textfield',
    '#title' => t('Text'),
    '#default_value' => variable_get('pr_widget_string', t('PageRank')),
    '#description' => t('String to use. Suggestions "PR", "Google PageRank", "PageRank" (default)'),
  );

  $form['pr_settings']['pr_widget_suffix'] = array(
    '#type' => 'textfield',
    '#title' => t('Suffix'),
    '#default_value' => variable_get('pr_widget_suffix', ''),
    '#description' => t('String to append. Suggestions " / 10", " out of 10" or nothing (default). <strong>Do not forget desired spaces.</strong>'),
  );

  $form['pr_settings']['pr_widget_link'] = array(
    '#type' => 'textfield',
    '#title' => t('Link to a third party PR check'),
    '#default_value' => variable_get('pr_widget_link', 'http://domaintyper.com/PageRankCheck/'),
    '#description' => t('Leave empty to disable, but the reliability of the widget is perceived better it leads to a third party PR check (default: "http://domaintyper.com/PageRankCheck/").<br /><strong>Use only services that accept a trailing domain in the URL to query. Do not forget the trailing slash or "?q=http://"</strong>, depending on the used service.'),
  ); 
  
  // Grabbing the PageRank once a day is enough, but leave it up to the
  // site owner to decide.
  $form['pr_settings']['pr_widget_interval'] = array(
    '#type' => 'radios',
    '#title' => t('Update interval'),
    '#options' => array(
      24*60*60 => t('24 hours (recommended)'),
      0 => format_interval(DRUPAL_CRON_DEFAULT_THRESHOLD, 2) . ' ' . t('(every cron run)'),
    ),
    '#default_value' => variable_get('pr_widget_interval', 24*60*60),
    '#description' => t('Saving this form updates the PageRank instantly, independent from this setting.'),
  );

  $form['pr_widget_notice'] = array(
    '#type' => 'fieldset',
    '#title' => t('Copyright notice'),
  );

  $form['pr_widget_notice']['pr_widget_notice_enabled'] = array(
    '#type' => 'checkbox',
    '#title' => t('Enabled'),
    '#default_value' => variable_get('pr_widget_notice_enabled', 0),
  );

  // For the examples we use real data.
  // Current domain name without the leading protocol.
  $host = parse_url($GLOBALS['base_url'], PHP_URL_HOST);
  // For our example use real data from user, but fictional when unset..
  $year = variable_get('pr_widget_year', '');
  $notice = variable_get('pr_widget_prepend', 'Copyright') . ' © ' . (($year != date('Y') && !empty($year)) ? $year . '-' . date('Y') : date('Y'));
  $form['pr_widget_notice']['pr_widget_url_name'] = array(
    // Create different types of notices to choose from.
    '#type' => 'radios',
    '#title' => t('Choose a notice'),
    '#options' => array(
      $host => '<strong>' . $notice . ' ' . $host . '</strong> ' . t('(default)'),
      variable_get('site_name', '') => '<strong>' . $notice . ' ' . variable_get('site_name', '') . '</strong> ' . t('(preferable if the site name is a person\'s full name or a company name)'),
      ' ' => '<strong>' . $notice . '</strong> ' . t('(leaving out the designation of owner is not recommended)'),
    ),
    '#default_value' => variable_get('pr_widget_url_name', $host),
    '#description' => t('\'Year of first publication\' is not used until entered below, for example © 2009-') . date('Y') . '. ' . t('Save this form to refresh above examples.'),
  );

  $form['pr_widget_notice']['pr_widget_year'] = array(
    '#type' => 'textfield',
    '#title' => t('What year was the domain first online?'),
    '#default_value' => variable_get('pr_widget_year', ''),
    '#description' => t('Leave empty to display only the current year (default). Also if the \'starting year\' equals the \'current year\' only one will be displayed until next year.<br />To play safe legally, it\'s best to enter a \'Year of first publication\', although copyright is in force even without any notice.'),
    '#size' => 4,
    '#maxlength' => 4,
  );

  $form['pr_widget_notice']['pr_widget_prepend'] = array(
    '#type' => 'textfield',
    '#title' => t('Prepend text'),
    '#default_value' => trim(variable_get('pr_widget_prepend', '')),
    '#description' => t('For example \'All images\' on a photographer\'s website.'),
  );

  return system_settings_form($form);
}

/**
 * Validate pr_widget settings submission.
 */
function pr_widget_admin_settings_validate($form, &$form_state) {
  // Before 1991 there was no world wide web and the future can't be a
  // 'year of first publication' but it can be left empty.
  $limit = $form_state['values']['pr_widget_year'];
  if ((!is_numeric($limit) || $limit < 1991 || $limit > date('Y')) && !empty($limit)) {
    form_set_error('pr_widget_year',  '<strong>' . t('INVALID YEAR.') . '</strong>');
  }
}