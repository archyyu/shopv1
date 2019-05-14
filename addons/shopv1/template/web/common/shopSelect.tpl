<div class="bar-select">
  <label class="control-label">网吧：</label>
  <select id="barSelect" class="mysele" data-live-search="true" data-size="6">
    {nocache}
      {foreach $shopList as $shop}
          <option value='{$shop.id}' {if $shop.id == $sid}selected{/if} >{$shop.shopname}</option>
      {/foreach}
    {/nocache}
  </select>
</div>