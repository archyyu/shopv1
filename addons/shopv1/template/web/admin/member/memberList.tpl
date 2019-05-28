{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

{include file="../../common/shopSelect.tpl"}
<div class="member-list">
  <div>
    <div class="search-member">
      <div class="form-inline">
        <div class="form-group form-group-sm">
          <label class="control-label">开卡时间</label>
          <input type="text" class="form-control muti-input range-picker-js">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">昵称\姓名\手机号\openid</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员等级</label>
          <select id="memberTypeSelect" class="form-control">
          </select>
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员活跃度</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员标签</label>
          <input type="text" class="form-control">
        </div>
        <button class="btn btn-sm btn-primary">查询</button>
      </div>
    </div>
    <div class="rate-setting encourage-setting">
      <table id="memberList" class="table table-bordered table-center">
        <thead>
        <tr>

        </tr>
        </thead>
      </table>
    </div>
  </div>
</div>

<script src="{$StaticRoot}/js/web/admin/member/member.js"></script>

{include file="../../common/footer.tpl"}