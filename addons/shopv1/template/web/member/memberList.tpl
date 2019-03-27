{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

{include file="../common/netbarSelect.tpl"}
<div class="member-list">
  <div>
    <div class="search-member">
      <div class="form-inline">
        <div class="form-group form-group-sm">
          <label class="control-label">开卡时间</label>
          <input type="text" id="createDate" class="form-control muti-input">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">账号</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员等级</label>
          <select class="form-control">
            <option value="">1</option>
            <option value="">2</option>
          </select>
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员姓名</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">性别</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">出生日期</label>
          <input type="text" id="birthdate" class="form-control muti-input">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">最后下机时间</label>
          <input type="text" id="lastPlay" class="form-control muti-input">
        </div>
        <button class="btn btn-sm btn-primary">查询</button>
      </div>
    </div>
    <div id="toolbar">
      <button class="btn btn-success" onclick="Member.refresh()">发送短信</button>
      <button class="btn btn-success">发送微信</button>
      <div class="sum-info">
        <div>会员总余额：<span id="sumBalance"></span> 本金余额：<span id="baseBalance"></span> 赠费余额：<span id="giftBalance"></span> </div>
        <div>
          <ul>
            <li>工作人员：2</li>
            <li>黄金会员：3</li>
          </ul>
        </div>
      </div>
    </div>
    <table id="memberList" class="table table-bordered table-center">
      <thead>
        <tr>
          <th>ID</th>
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

<script src="{$StaticRoot}/js/web/member/member.js"></script>

{include file="../common/footer.tpl"}