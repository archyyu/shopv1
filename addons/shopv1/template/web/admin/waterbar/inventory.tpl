{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<textarea id="products" style="display:none;">{$products}</textarea>

<div class="inventory">
  <div class="search-group">
    <div class="form-inline">
      <div class="form-group form-group-sm">
        <label class="control-label">商品分类</label>
        <select class="form-control input-sm selectpicker" id="typeSelectQuery">
          <option value="">请选择</option>
          {foreach $typelist as $type}
            <option value='{$type.id}'>{$type.typename}</option>
        {/foreach}
        </select>
      </div>
      <div class="form-group form-group-sm">
        <label class="control-label">库房选择</label>
        <select class="form-control input-sm selectpicker" id="storeSelect">
          {foreach $storelist as $store}
            <option value='{$store.id}'>{$store.storename}</option>
          {/foreach}
        </select>
      </div>
      <div class="form-group form-group-sm">
        <label class="control-label">查询商品</label>
        <input type="text" class="form-control" placeholder="请输入商品名称或关键字" id="productName">
      </div>
      <button class="btn btn-sm btn-primary" onclick="Inventory.goodsTableReload();">搜索</button>
    </div>
  </div>
  <div class="water-btn-group clearfix">
    <div class="left-group">
      <button class="btn btn-primary" onclick="Inventory.openClassModal()">商品分类</button>
      <button class="btn btn-primary" onclick="Inventory.openProductModal(0)">添加商品</button>
    </div>
    <div class="right-group">
    </div>
  </div>
  <div class="goods-list">
    <table id="goodsTable"></table>
  </div>
  {include file="./modals/addproduct.tpl"}
  {include file="./modals/joinproduct.tpl"}
  {include file="./modals/productclass.tpl"}
  {include file="./modals/materialSpec.tpl"}
  {include file="./modals/productdamage.tpl"}
  {include file="./modals/damage.tpl"}
  {include file="./modals/transgoods.tpl"}
  {include file="./modals/productin.tpl"}
  {include file="./modals/stock.tpl"}
</div>

<script src="{$StaticRoot}/js/web/admin/waterbar/inventory.js"></script>
{include file="../../common/footer.tpl"}