{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

{* {include file="../../common/shopSelect.tpl"} *}
<textarea id="groupsList" style="display:none;">{$groupsList}</textarea>
<div class="member-list">
  <div>
    <div class="search-member">
      <div class="form-inline">
        <div class="form-group form-group-sm">
          <label class="control-label">开卡时间</label>
          <input type="text" id="timearea" class="form-control muti-input range-picker-js">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">昵称</label>
          <input type="text" id="nickname" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">手机号</label>
          <input type="text" id="moblie" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员等级</label>
          <select id="groupid" class="form-control">
            <option value='0'>未选择</option>
            {foreach $groups as $group}
              <option value='{$group.groupid}'>{$group.title}</option>
            {/foreach}
          </select>
        </div>
        <!-- <div class="form-group form-group-sm">
          <label class="control-label">会员活跃度</label>
          <input type="text" id="timearea" class="form-control">
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">会员标签</label>
          <input type="text" id="timearea" class="form-control">
        </div> -->
        <button class="btn btn-sm btn-primary" onclick="Member.refreshTable();">查询</button>
        <button class="btn btn-sm btn-success pull-right" onclick="Member.massSendCard()">发送卡券</button>
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

<div class="modal fade" id="sendCard" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="we7-modal-dialog modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
        <div class="modal-title">赠送卡券</div>
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          <input type="hidden" id="uid">
          <div class="form-group">
            <label class="col-xs-2 control-label">卡券：</label>
            <div class="col-xs-10">
              <select type="text" id="cardid" class="form-control">
                <option value="0">请选择</option>
                {foreach $cardlist as $card}
                  <option value='{$card.id}'>{$card.cardname}</option>
                {/foreach}
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label">数量：</label>
            <div class="col-xs-10">
              <input type="text" id="num" class="form-control">
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label">通知：</label>
            <div class="col-xs-10">
              <!-- <input id='smsMsg' type="radio" name="msg">
              <label for="smsMsg">短信通知</label> -->
              <input id="weixinMsg" type="radio" name="msg" checked="checked">
              <label for="weixinMsg"> 微信通知</label>
              <span class="help-block">24小时内未与公众号交互的会员可能会接收不到<strong> 微信通知</strong>。</span>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="Member.sendCard();"
          data-dismiss="modal">确定</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="massSendCard" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="we7-modal-dialog modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
        <div class="modal-title">赠送卡券</div>
      </div>
      <div class="modal-body">
        <input type="hidden" id="memberData">
        <div class="form-horizontal">
          <div class="form-group">
              <label class="col-xs-2 control-label">会员：</label>
              <div class="col-xs-10">
                  <p id="sendMemberList" class="form-control-static"></p>
                  <span class="help-block">共计：<span id="memberLength">0</span> 人</span>
              </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label">卡券：</label>
            <div class="col-xs-10">
              <select type="text" id="cardid" class="form-control">
                <option value="0">请选择</option>
                {foreach $cardlist as $card}
                  <option value='{$card.id}'>{$card.cardname}</option>
                {/foreach}
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label">数量：</label>
            <div class="col-xs-10">
              <input type="text" id="num" class="form-control">
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label">通知：</label>
            <div class="col-xs-10">
              <input id="weixinMsg" type="radio" name="msg" checked="checked">
              <label for="weixinMsg"> 微信通知</label>
              <span class="help-block">24小时内未与公众号交互的会员可能会接收不到<strong> 微信通知</strong>。</span>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="Member.sendCard();"
          data-dismiss="modal">确定</button>
      </div>
    </div>
  </div>
</div>

<script src="{$StaticRoot}/js/web/admin/member/member.js"></script>

{include file="../../common/footer.tpl"}