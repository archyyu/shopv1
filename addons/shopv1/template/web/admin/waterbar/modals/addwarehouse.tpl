<div class="modal fade" id="addWarehouseModal" role="dialog" aria-hidden="true">
  <div class="modal-dialog add_warehouse">
    <div class="modal-content">
      <div class="modal-header">
        <button class="close" data-dismiss="modal"><span>&times;</span></button>
        <h5 class="modal-title">添加库房</h5>
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          {*<div class="form-group form-group-sm">
            <label class="control-label col-xs-3 col-xs-offset-1">操作员：</label>
            <p class="form-control-static col-xs-7"></p>
          </div>*}
            <input type="hidden" id="storeid" value="0" />
          <div class="form-group form-group-sm">
            <label for="" class="col-xs-3 col-xs-offset-1 control-label">库房名称：</label>
            <div class="col-xs-7"><input type="text" id="storename" class="form-control" placeholder="请输入库房名称">
            </div>
          </div>
          <div class="form-group form-group-sm">
            <label class="col-sm-3 control-label">
              <span style="color: red;"> * </span>所属门店：
            </label>
            <div class="col-sm-8">
              <select class="form-control selectpicker" name="shopid" id="shopid">
                <option value="">请选择</option>
                {foreach $shopList as $store}
                    <option value='{$store.id}' >{$store.shopname}</option>
                {/foreach}
              </select>
            </div>
          </div>
        </div>
      </div>
    <div class="modal-footer">
      <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
      <button class="btn btn-primary" onclick="Warehouse.save();">保 &nbsp;&nbsp; 存</button>
    </div>
  </div>
</div>
</div>