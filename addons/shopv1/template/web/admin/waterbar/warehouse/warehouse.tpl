{include file="../../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="warehouse">
  <div class="water-btn-group clearfix">
    <div class="left-group">
      <button class="btn btn-primary" data-toggle="modal" onclick="Warehouse.openStore(0);">添加库房</button>
    </div>
  </div>
  <div class="detail_content">
    <table id="warehouseList" class="table">
    </table>
  </div>
  {include file="../modals/addwarehouse.tpl"}
</div>

<script src="{$StaticRoot}/js/web/admin/waterbar/warehouse.js"></script>
{include file="../../../common/footer.tpl"}