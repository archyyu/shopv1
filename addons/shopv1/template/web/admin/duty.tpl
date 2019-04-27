{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

<div class="bar-select">
  <label class="control-label">门店：</label>
  <select id="shopSelect" class="mysele" data-live-search="true" data-size="6">
    
	{foreach $shopList as $store}
	  <option value='{$store.id}' >{$store.shopname}</option>
	{/foreach}
    
  </select>
</div>

<div class="staff-list">
  <div class="staff">
      <div class="staff-group-table">
        <table id="dutyListTable" class="table table-bordered">
          <thead>
            <tr>
              <th>交班流水</th>
              <th>商品</th>
              <th>库房</th>
              <th>变动类型</th>
              <th>变动数量</th>
              <th>时间</th>
              <th>操作员</th>
              <th>备注</th>
            </tr>
          </thead>
        </table>
      </div>
  </div>
</div>

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script src="{$StaticRoot}/js/web/admin/duty.js"></script>

{include file="../common/footer.tpl"}
