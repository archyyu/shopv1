<div class="bar-select">
  <label class="control-label">网吧：</label>
  <select id="barSelect" class="mysele" data-live-search="true" data-size="6">
    {nocache}
      {foreach $netbarList as $netbar}
          <option value='{$netbar.gid}' {if $netbar.gid == $gid}selected{/if} >{$netbar.netbarname}</option>
      {/foreach}
    {/nocache}
  </select>
</div>