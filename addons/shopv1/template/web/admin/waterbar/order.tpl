{include file="../../common/header.tpl" logo=true}
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
    <div class="search-group">
        <div class="form-inline">
            <div class="form-group form-group-sm">
                <label class="control-label">时间起止</label>
                <input type="text" class="form-control range-picker-js">
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">卡券类型</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            
            <div class="form-group form-group-sm">
                <label class="control-label">卡券名称</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">订单状态</label>
                <labelclass="radio-inline">
                    <input type="radio"> 全部
                </label>
                <labelclass="radio-inline">
                    <input type="radio"> 已使用
                </label>
                <labelclass="radio-inline">
                    <input type="radio"> 未使用
                </label>
            </div>
            <button class="btn btn-sm btn-primary">搜索</button>
        </div>
    </div> 
    
<div class="staff-list">
  <div class="staff">
      <div class="staff-group-table">
        <table id="OrderListTable" class="table table-bordered">
          <thead>
            <tr>
              
            </tr>
          </thead>
        </table>
      </div>
  </div>
</div>

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script src="{$StaticRoot}/js/web/admin/order.js"></script>

{include file="../../common/footer.tpl"}
