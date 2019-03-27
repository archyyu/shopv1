{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

{include file="../common/netbarSelect.tpl"}
<div class="member-level-setting">
  <div class="add-member-levle"><button class="btn btn-success" data-toggle="modal" onclick="memberLevel.openMemberTypeModal(0)">添加会员等级</button></div>
  <div class="">
    <label class="checkout-inline"><input type="checkbox"> 根据成长值自动升级</label>
  </div>
  <div>
    <table id="memberTypeList" class="table table-bordered table-center">
      <thead>
        <tr>
          <th>等级ID</th>
          <th>会员名称</th>
          <th>所需成长值</th>
          <th>等级优惠</th>
          <th>状态</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        
      </tbody>
    </table>
  </div>
</div>

<div id="memberLevelModal" class="modal fade member-level-modal" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">编辑会员等级</h4>
        <input type="hidden" id="membertypeid" />
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          <fieldset>
            <legend>基础设定</legend>
            <div class="form-group form-group-sm">
              <label class="col-xs-2 col-xs-offset-1 control-label">会员名称：</label>
              <div class="col-xs-4"><input type="text" id="membertypename" class="form-control"></div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-2 col-xs-offset-1 control-label">成长值：</label>
              <div class="col-xs-4"><input type="number" id="growth" class="form-control"></div>
            </div>
          </fieldset>
          
          <fieldset>
            <legend>等级优惠</legend>
            <div class="form-group form-group-sm">
              <label class="col-xs-2 col-xs-offset-1 control-label">商品折扣：</label>
              <div class="col-xs-4">
                <div class="input-group"><input type="number" id="productdiscount" class="form-control"><span class="input-group-addon">%</span></div>
              </div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-2 col-xs-offset-1 control-label">上网折扣：</label>
              <div class="col-xs-4">
                <div class="input-group"><input type="number" id="onlinediscount" class="form-control"><span class="input-group-addon">%</span></div>
              </div>
            </div>
          </fieldset>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="memberLevel.save()">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="{$StaticRoot}/js/web/tariffyRate/memberlevel.js"></script>

{include file="../common/footer.tpl"}