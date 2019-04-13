<div id="addProductModal" class="modal fade add-product-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">添加商品</h5>
        <input type="hidden" name="productid" value="0" />
      </div>
      <div class="modal-body">
        <div class="addproduct_pop">
          <div class="form-horizontal">
            <div class="finished">
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">
                  <span style="color: red;"> * </span>
                  商品名称：
                </label>
                <div class="col-sm-8">
                  <span class="updiv">
                    <div class="tddiv">
                      <input id="productName" name="productname" class="form-control" type="text"
                        placeholder="请输入名称或关键字" />
                      <div class="linediv"></div>
                    </div>
                  </span>
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">
                  商品条形码：
                </label>
                <div class="col-sm-8">
                  <input type="text" name="productcode" class="input-sm form-control" placeholder="请扫描商品条形码">
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">
                  <span style="color: red;"> * </span>所属类型：
                </label>
                <div class="col-sm-8">
                  <select class="form-control selectpicker" name="typeid">
                    <option value="">请选择</option>
                    {foreach $typelist as $type}
                        <option value='{$type.id}'  >{$type.typename}</option>
                    {/foreach}
                  </select>
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">制作来源：</label>
                <div class="col-sm-8">
                  <select name="make" class="form-control selectpicker">
                    <option value="0">请选择</option>
                    <option value="1">厨房制作</option>
                    <option value="2">水吧制作</option>
                  </select>
                </div>
              </div>
              <div class="form-group form-group-sm" id="proormat">
                <label class="col-sm-3 control-label">
                  <span style="color: red;"> * </span>商品类型：
                </label>
                <div class="col-sm-8">
                    <label class="radio-inline" id="commodity">
                    <input type="radio" name="producttype" value="-1"> 虚拟商品
                  </label>
                  <label class="radio-inline" id="commodity">
                    <input type="radio" name="producttype" value="0" checked="checked"> 成品
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="producttype" value="1"> 自制
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="producttype" value="2"> 原料
                  </label>      
                  <label class="radio-inline">
                    <input type="radio" name="producttype" value="3"> 套餐
                  </label>  
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">
                  <span style="color: red;"> * </span>关联商品：
                </label>
                <div class="col-sm-4">
                  商品
                </div>
                <div class="col-sm-2">
                  数量
                </div>
              </div>
              <div class="form-group form-group-sm associalproduct">
                <label class="col-sm-3 control-label">
                </label>
                <div class="col-sm-4">
                  <select id="productSelect" class="form-control">
                    <option>选择商品</option>
                  </select>
                </div>
                <div class="col-sm-2">
                    <span></span><input class="form-control">
                </div>
              </div>
              <div class="form-group form-group-sm associalproduct">
                <label class="col-sm-3 control-label">
                </label>
                <div class="col-sm-4">
                  <select name="linkproductid" class="form-control">
                    <option value="">选择商品</option>
                  </select>
                </div>
                <div class="col-sm-2">
                    <input name="linkproductnum" class="form-control">
                </div>
              </div>
              <div class="form-group form-group-sm">
                <div class="col-sm-3 col-sm-offset-3">
                    <button class="btn btn-block btn-xs btn-primary" onclick="Inventory.addMoreProduct();">增加关联商品</button>
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span>商品原价：</label>
                <div class="col-sm-8">
                  <div class="input-group">
                    <input type="text" class="form-control" name="normalprice" placeholder="请输入售价">
                    <span class="input-group-addon">(元)</span>
                  </div>
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span>商品会员价：</label>
                <div class="col-sm-8">
                  <div class="input-group">
                    <input type="text" class="form-control" name="memberprice" placeholder="请输入售价">
                    <span class="input-group-addon">(元)</span>
                  </div>
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">
                  商品排序：
                </label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" name="index" placeholder="默认排在首位，此数值越小排序越靠前">
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">
                  商品单位：
                </label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" name="unit" placeholder="比如个，瓶，袋">
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-sm-3 control-label">商品多属性：</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" name="attributes" placeholder="用空格分割不同的属性，比如 无糖 多糖，热 冷等等">
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
        <button class="btn btn-primary" onclick="Inventory.saveGood();">确&nbsp;&nbsp;&nbsp;&nbsp;认</button>
      </div>
    </div>
  </div>
</div>