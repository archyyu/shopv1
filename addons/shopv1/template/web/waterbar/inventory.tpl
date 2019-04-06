{include file="../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="inventory">
  <div class="panel panel-search">
    <div class="panel-heading search">
      <h3 class="panel-title">查询</h3>
    </div>
    <div class="panel-body">
      <div class="clearfix">
        <form id="productSelectForm" class="form-horizontal">
          <div class="form-group">
            <label for="name" class="col-sm-1 control-label">查询类型</label>
            <div class="col-sm-3">
              <select class="form-control input-sm" name="type" id="selectType" onchange="Inventory()">
                <option value="">请选择</option>
                @foreach($typeList as $k =>$v)
                <option value="{{$v->id}}">{{$v->name}}</option>
                @endforeach

              </select>
            </div>
            <label for="name" class="col-sm-1 col-sm-offset-1 control-label">查询商品</label>
            <div class="col-sm-3">
              <input type="text" class="form-control input-sm" name="product" id="selectProduct"
                placeholder="请输入商品名称或关键字">
            </div>
            <div class="col-sm-2">

            </div>
          </div>
        </form>
      </div>

    </div>
  </div>
  <div class="water-btn-group">
    <div class="left-group">
      <button class="btn btn-primary" data-toggle="modal" data-target="#productClassModal">商品分类</button>
      <button class="btn btn-primary" data-toggle="modal" data-target="#addProductModal">添加商品</button>
      <button class="btn btn-primary" data-toggle="modal" data-target="#productClassModal">添加套餐</button>
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