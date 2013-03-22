<?php
/**
 * @file
 * Template for the PageRank Widget module.
 */
?>
<div class="pr_widget-wrap">
  <?php if (variable_get('pr_widget_enabled', 1)): ?>
    <?php $link = variable_get('pr_widget_link', 'http://domaintyper.com/PageRankCheck/'); ?>
    <?php if (!empty($link)): ?>
      <a href="<?php print $link . parse_url($GLOBALS['base_url'], PHP_URL_HOST); ?>" title="<?php print t('Check on') . ' ' . parse_url($link, PHP_URL_HOST); ?>">
    <?php endif; ?>
    <table class="pr_widget-table"">
      <tbody class="pr_widget-body">
        <tr>
          <td class="pr_widget-first">
            <?php print variable_get('pr_widget_string', t('PageRank')); ?>
          </td>
          <td class="pr_widget-last">
            <?php
              print variable_get('pr_widget_ratio', t('[No data yet] ')) . variable_get('pr_widget_suffix', '');
            ?>
          </td>
        </tr>
      </tbody>
    </table>
    <?php if (!empty($link)): ?>
      </a>
    <?php endif; ?>
  <?php endif; ?>
  <table class="pr_widget-table notice" style="width: auto;">
    <tbody class="pr_widget-body">
      <tr>
        <td class="pr_widget-notice">
          <?php
            $host = variable_get('pr_widget_url_name', parse_url($GLOBALS['base_url'], PHP_URL_HOST));
            $year = variable_get('pr_widget_year', '');
            // If the notice is enabled we want it..
            if (variable_get('pr_widget_notice_enabled', 0)) {
              $notice = ' ' . variable_get('pr_widget_prepend', '') . ' © ' . (($year != date('Y') && !empty($year)) ? $year . '-' . date('Y') : date('Y'));
            }
            else {
              // ..and leave it empty if it's disabled.
              $notice = '';
              $host = '';
            }
            print $notice . ' ' . $host; ?>
        </td>
      </tr>
    </tbody>
  </table>
</div>