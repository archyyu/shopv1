{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

{include file="../common/netbarSelect.tpl"}
<div class="online-list">
  <div>
    <div class="search-member">
      <div class="form-inline">
        <div class="form-group form-group-sm">
          <label class="control-label">上机时间</label>
          <input type="text" id="onlineDate" class="form-control online-date-input">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">卡类型</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">卡号</label>
          <input type="text" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">电脑</label>
          <select class="form-control">
            <option value="">1</option>
            <option value="">2</option>
          </select>
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">上机区域</label>
          <select class="form-control">
            <option value="">1</option>
            <option value="">2</option>
          </select>
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">上机类型</label>
          <select class="form-control">
            <option value="">1</option>
            <option value="">2</option>
          </select>
        </div>
        <button class="btn btn-sm btn-primary">查询</button>
      </div>
    </div>
    <div id="toolbar">
      <div class="online-info">上网总消费：<span id="sumOnlineConsum"></span> 上网总人数：<span id="sumOnlineperson"></span> 上网总时长：<span id="sumOnlineTime"></span>
      </div>
    </div>
    <table id="onlineList" class="table table-bordered table-center">
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