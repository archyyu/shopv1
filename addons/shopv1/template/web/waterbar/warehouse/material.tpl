{include file="../../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="material">
  <div class="panel panel-search">
    <div class="panel-heading search">
      <h3 class="panel-title">查询</h3>
    </div>
    <div class="panel-body">
      <div class="clearfix">
        <div class="form-inline">
          <div class="form-group">
            <label class="control-label">查询类型</label>
            <select class="form-control input-sm">
              <option value="">请选择</option>
            </select>
            <label class="control-label">查询商品</label>
            <input type="text" class="form-control input-sm" name="product" id="selectProduct"
              placeholder="请输入商品名称或关键字">
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="water-btn-group">
    <div class="left-group">
      <button class="btn btn-primary" data-toggle="modal" data-target="#addMaterialModal">添加原料</button>
      <button class="btn btn-primary" data-toggle="modal" data-target="#specModal">维护进购规格</button>
      <button class="btn btn-primary" data-toggle="modal" data-target="#materialClassModal">维护原料分类</button>
      <button class="btn btn-primary" data-toggle="modal" data-target="#supplierModal">我的供货单位</button>
    </div>
    <div class="right-group">
      <button class="btn btn-success">导出</button>
      <button class="btn btn-success">导入原料</button>
    </div>
  </div>
  <div class="material-list">
    <table id="materialTable"></table>
  </div>

  {include file="../modals/addmaterial.tpl"}
  {include file="../modals/materialSpec.tpl"}
  {include file="../modals/materialClass.tpl"}
  {include file="../modals/supplier.tpl"}
</div>

<script src="{$StaticRoot}/js/web/waterbar/material.js"></script>
{include file="../../common/footer.tpl"}