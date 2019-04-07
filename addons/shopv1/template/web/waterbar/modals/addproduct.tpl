<div class="modal fade" id="addProductModal" role="dialog" aria-hidden="true">
  <div class="modal-dialog addProduct" id="actProduct">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center">添加<span class="commonname">商品</span></h5>
      </div>
      <div class="modal-body">
        <div class="addproduct_pop">
          <div class="form-horizontal" id="productForm">
            <div class="finished">
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span><span
                    class="commonname">商品</span>名称：</label>
                <div class="col-sm-8">
                  <span class="updiv">
                    <div class="tddiv">
                      <input id="productName" name="productName" class="form-control input-sm" type="text" placeholder="请输入名称或关键字"/>
                      <div class="linediv"></div>
                    </div>
                  </span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span class="commonname">商品</span>条形码：</label>
                <div class="col-sm-8">
                  <input type="text" id="barcode" name="barcode" class="input-sm form-control" placeholder="请扫描商品条形码">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span>所属类型：</label>
                <div class="col-sm-8">
                  <select class="form-control input-sm" id="typeid" name="typeid">
                    <option value="">请选择</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">制作来源：</label>
                <div class="col-sm-8">
                  <select class="form-control input-sm" id="makeSource" name="makeSource">
                    <option value="">请选择</option>
                    <option value="1">厨房制作</option>
                    <option value="2">水吧制作</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span class="commonname">商品</span>缩略图：</label>
                <div class="col-sm-8">
                  <input type="file" id="logoimg" name="logoimg" accept="image/*" onchange="showPreview(this);" />
                  <p class="help-block">缩微图请小于300*300px</p>
                </div>
              </div>
              <div class="form-group">
                <label for="name" class="col-sm-3 control-label">&nbsp;</label>
                <div class="col-sm-3" id="portrait"><img style="height:100px;" alt="缩微图" /></div>
              </div>
              <div class="form-group" id="proormat">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span>成品/自制：</label>
                <div class="col-sm-8">
                  <label class="radio-inline" id="commodity">
                    <input id="probut1" type="radio" name="protype" value="0" onclick="chooseProType(0)"> 成品
                  </label>
                  <label class="radio-inline">
                    <input id="probut2" type="radio" name="protype" value="1" onclick="chooseProType(1)"> 自制
                  </label>

                </div>
              </div>
              <div class="form-group self" id="materialsList">
                <div class="form-group self joinMaterial">
                  <label class="col-sm-3 control-label"><span style="color: red;"> * </span>关联<span
                      class="associatename">商品</span>：</label>
                  <div class="col-sm-3" id="associateTypeTemplate">
                      <select class="form-control input-sm">
                          <option value="unchoose">选择分类</option>
                      </select>
                  </div>
                  <div class="col-sm-2">
                    <select class="form-control input-sm joinMaterialName" onchange="chooseMaterial(this)">
                      <option>选择<span class="associatename">商品</span></option>
                    </select>
                  </div>
                  <div class="col-sm-2">
                    <input class="form-control input-sm joinMaterialNum">
                  </div>
                  <div class="col-sm-1">
                    <span class="joinMaterialUnit"></span>
                  </div>
                </div>
              </div>
              <div class="form-group self" id="addmaterialsList">
                <div class="col-sm-5 col-sm-offset-3">
                  <span class="help-block">关联库存的<span class="associatename">商品</span></span>
                </div>
                <div class="col-sm-3">

                  <button class="btn btn-block btn-xs btn-primary">增加<span class="associatename">商品</span></button>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span><span
                    class="commonname">商品</span>售价：</label>
                <div class="col-sm-8">
                  <div class="input-group">
                    <input type="text" class="form-control input-sm" id="saleprice" name="saleprice"
                      placeholder="请输入合适的售价">
                    <div class="input-group-addon">(元)</div>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span class="commonname">商品</span>排序：</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control input-sm" id="position" name="position"
                    placeholder="默认排在首位，此数值越小排序越靠前">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">允许下单场景：</label>
                <div class="col-sm-8">
                  <label class="checkbox-inline">
                    <input type="checkbox" checked="checked">
                    吧台
                  </label>
                  <label class="checkbox-inline">
                    <input type="checkbox" checked="checked"> 微信端
                  </label>
                  <label class="checkbox-inline">
                    <input type="checkbox" checked="checked">
                    客户机
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">销售时段：</label>
                <div class="col-sm-8">
                  <label class="radio-inline">
                    <input type="radio" name="saletype" value="0" checked="checked"> 全天
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="saletype" value="1"> 分时段(最多3个时段)
                  </label>
                  <button class="btn btn-xs btn-success pull-right" style="display:none;">增加时段</button>
                </div>
              </div>
              <div id="saleTimeList">
                <div class="form-group form-group-sm add_sell_time">
                  <div class="col-sm-7 col-sm-offset-3">
                    <div class="input-group input-group-sm">
                      <input type="text" class="datetimepicker datetime form-control" readonly="readonly"
                        placeholder="初始时间">
                      <span class="input-group-addon">-</span>
                      <input type="text" class="datetimepicker datetime form-control" readonly="readonly"
                        placeholder="终止时间">
                    </div>
                  </div>
                </div>
              </div>
              <div class="form-group productdiv">
                <label class="col-sm-3 control-label">商品多属性：</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control input-sm" id="attribute" name="attribute"
                    placeholder="用空格分割不同的属性，比如 无糖 多糖，热 冷等等">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style="color: red;"> * </span>虚物/实物：</label>
                <div class="col-sm-8">
                  <input type="radio" id="physical_" name="physical" value="0" /> <label class="control-label"
                    for="physical_">虚物</label>
                  <input type="radio" id="physical" name="physical" value="1" checked /> <label class="control-label"
                    for="physical">实物</label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="row addProduct_btn ">
          <div class="col-md-offset-1 col-md-5 text-center ">
            <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
          </div>
          <div class="col-md-5 text-center">
            <button class="btn btn-info">确&nbsp;&nbsp;&nbsp;&nbsp;认</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>