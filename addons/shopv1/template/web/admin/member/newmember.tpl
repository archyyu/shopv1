{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/member.css">

<input id="awardid" type="hidden" value="{$award['id']}" />
<div class="">
  <h4>新手奖励</h4>
  <div class="form-horizontal">
    <div class="form-group">
      <label class="col-xs-2 control-label">新手积分奖励：</label>
      <div class="col-xs-4"><input id="points" type="text" class="form-control" value="{$award['points']}"></div>
    </div>
    <div class="form-group">
      <label class="col-xs-2 control-label">新手卡券奖励：</label>
      <div class="col-xs-4">
        <select id="cardtypeid" type="text" class="form-control selectpicker">
          <option value="0" {if $award['cardtypeid'] == 0} selected {/if}>无奖励</option>
          {foreach $cardlist as $card}
            <option value='{$card.id}' {if $award['cardtypeid'] == $card['id']} selected {/if}>{$card.cardname}</option>
          {/foreach}
        </select>
      </div>
    </div>
  </div>
</div>



<script src="{$StaticRoot}/js/web/admin/member/NoviceAward.js?version=12"></script>

{include file="../../common/footer.tpl"}