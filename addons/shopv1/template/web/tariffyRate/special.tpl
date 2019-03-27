{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

{include file="../common/netbarSelect.tpl"}
<div class="rate-setting normal-rate">
  <div class="form-inline">
    <div class="form-group">
      <label class="control-label">女性上机折扣：</label>
      <div class="input-group">
        <input type="tel" class="form-control" id='girlRate' value='{$netbar.girldiscount}' />
        <span class="input-group-addon">%</span>
      </div>
    </div>
    <button class="btn btn-primary" onclick='special.setRate()'>保存</button>
  </div>
</div>
<script src="{$StaticRoot}/js/web/tariffyRate/special.js"></script>

{include file="../common/footer.tpl"}
