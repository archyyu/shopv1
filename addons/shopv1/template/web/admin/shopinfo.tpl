{include file="../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

<div class="container-fluid">
  <div class="row">
    <button class="btn btn-success add-shop" data-toggle="modal" data-target="#addShop" name="add_shop" onclick="NetbarInfoLogic.openAddModal()">新增门店</button>
  </div>
  <div class="row">
    <table id="barList" class="table table-bordered">
      <tr>
        <th>门店编号</th>
        <th>门店名称</th>
        <th>地址</th>
        <th>负责人</th>
        <th>电话</th>
        <th>操作</th>
      </tr>
    </table>
  </div>
</div>

<div id="addShop" class="modal fade add-shop-modal" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" name="title">新增门店</h4>
        <input type="hidden" name="gid" value="0"/>
        <input type="hidden" name="dataversion" value="1"/>
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          <div class="form-group form-group-sm">
            <div class="col-xs-6">
              <div class="row bar-name">
                <label class="col-xs-4 control-label">门店名称：</label>
                <div class="col-xs-8">
                  <input type="text" name="netbarname" class="form-control">
                </div>
              </div>
              <div class="row">
                <label class="col-xs-4 control-label">机器数量：</label>
                <div class="col-xs-8">
                  <input type="text" name="pcnum" class="form-control">
                </div>
              </div>
            </div>
            <div class="col-xs-6">
              <div class="row">
                <label class="col-xs-4 control-label">网吧LOGO：</label>
                <div class="col-xs-8">
                  <input type="text" name="" class="form-control">
                </div>
              </div>
            </div>
          </div>
          <div class="form-group form-group-sm">
            <label class="col-xs-2 control-label">负责人：</label>
            <div class="col-xs-4"><input type="text" name="principal" class="form-control"></div>
          </div>
          <div class="form-group form-group-sm">
            <label class="col-xs-2 control-label">电话：</label>
            <div class="col-xs-4"><input type="text" name="thephone" class="form-control"></div>
            <label class="col-xs-2 control-label">成立时间：</label>
            <div class="col-xs-4"><input name="setuptime" type="text" id="buildTime" class="form-control"></div>
          </div>
          <div class="form-group form-group-sm">
            <label class="col-xs-2 control-label">地址：</label>
            <div class="col-xs-8"><input name="address" type="text" class="form-control"></div>
          </div>
        </div>
        <div class="addShop-map">map</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
        <button type="button" class="btn btn-primary" name="add">确 认</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- <script src="{$StaticRoot}/js/web/mockData.js"></script> -->
<script src="{$StaticRoot}/js/web/admin/shop.js"></script>

{include file="../common/footer.tpl"}
