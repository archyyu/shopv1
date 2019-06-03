{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

<div class="">
  <h4>新手奖励</h4>
  <div class="form-horizontal">
    <div class="form-group">
      <label class="col-xs-2 control-label">新手积分奖励：</label>
      <div class="col-xs-4"><input type="text" class="form-control"></div>
    </div>
    <div class="form-group">
      <label class="col-xs-2 control-label">新手卡券奖励：</label>
      <div class="col-xs-4">
        <select type="text" class="form-control selectpicker">
          <option value="1">1</option>
        </select>
      </div>
    </div>
  </div>
</div>


<script src="{$StaticRoot}/js/web/admin/member/memberlevel.js?version=12"></script>

{include file="../../common/footer.tpl"}