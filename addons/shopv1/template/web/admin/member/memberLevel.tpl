{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

{include file="../../common/shopSelect.tpl"}
<div class="top-btn-group add-member-levle">
  <button class="btn btn-primary" data-toggle="modal" onclick="memberLevel.openMemberTypeModal(0)">
    <span class="iconfont icon-addition"></span> 添加会员等级
  </button>
</div>
<div class="member-level-setting">
  <div class="">
    <label class="checkbox-inline checkbox-wrap">
      <input id="autoUpdate"  type="checkbox">
      <span class="checkbox-text">根据成长值自动升级</span>
    </label>
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
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">编辑会员等级</h4>
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          <fieldset>
            <legend>基础设定</legend>
            <div class="form-group form-group-sm">
              <label class="col-xs-4 control-label">会员名称</label>
              <div class="col-xs-6"><input type="text" class="form-control"></div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-4 control-label">成长值</label>
              <div class="col-xs-6"><input type="number" class="form-control"></div>
            </div>
          </fieldset>
          
          <fieldset>
            <legend>等级优惠</legend>
            <div class="form-group form-group-sm">
              <label class="col-xs-4 control-label">商品折扣</label>
              <div class="col-xs-6">
                <div class="input-group"><input type="number" class="form-control"><span class="input-group-addon">%</span></div>
              </div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-4 control-label">上网折扣</label>
              <div class="col-xs-6">
                <div class="input-group"><input type="number" class="form-control"><span class="input-group-addon">%</span></div>
              </div>
            </div>
          </fieldset>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="{$StaticRoot}/js/web/admin/member/memberlevel.js"></script>

{include file="../../common/footer.tpl"}