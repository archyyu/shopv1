{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<textarea id="products" style="display:none;">{$products}</textarea>

<div class="card-management">
  <div class="water-btn-group clearfix">
    <div class="left-group">
        <button class="btn btn-primary" data-toggle="modal" onclick="CardType.openCardModal(0,null);">添加卡券</button>
    </div>
    <div class="card-filter">
      <select name="" id="" class="form-group selectpicker">
        <option value="">卡券</option>
      </select>
    </div>
  </div>
  <div class="detail_content">
    <table id="cardList" class="table">
    </table>
  </div>
</div>

{include file="./modals/addcard.tpl"}
{include file="./modals/sendcard.tpl"}
{include file="./modals/selectmember.tpl"}

<script src="{$StaticRoot}/js/web/admin/cardtype.js"></script>
{include file="../../common/footer.tpl"}