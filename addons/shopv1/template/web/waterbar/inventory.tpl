{include file="../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="inventory">
  <div class="search-group">
    <div class="form-inline">
      <div class="form-group form-group-sm">
        <label class="control-label">查询类型</label>
        <select class="form-control input-sm selectpicker">
          <option value="">请选择</option>
        </select>
      </div>
      <div class="form-group form-group-sm">
        <label class="control-label">查询商品</label>
        <input type="text" class="form-control" placeholder="请输入商品名称或关键字">
      </div>
      <button class="btn btn-sm btn-primary">搜索</button>
    </div>
  </div>
  <div class="water-btn-group clearfix">
    <div class="left-group">
      <button class="btn btn-primary" onclick="Inventory.openClassModal()">商品分类</button>
      <button class="btn btn-primary" onclick="Inventory.openProductModal(0)">添加商品</button>
      <button class="btn btn-primary" onclick="Inventory.openProductModal(1)">添加套餐</button>
    </div>
    <div class="right-group">
      <button class="btn btn-success">导出</button>
      <button class="btn btn-success">批量添加</button>
    </div>
  </div>
  <div class="goods-list">
    <table id="goodsTable"></table>
  </div>
  {include file="./modals/productclass.tpl"}
  {include file="./modals/addproduct.tpl"}
</div>

<script src="{$StaticRoot}/js/web/waterbar/inventory.js"></script>
{include file="../common/footer.tpl"}