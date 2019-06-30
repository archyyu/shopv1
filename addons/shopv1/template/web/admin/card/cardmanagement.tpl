{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<textarea id="products" style="display:none;">{$products}</textarea>

<div class="card-management">
  <div class="water-btn-group clearfix">
    <div class="left-group">
        <div class="btn-group">
            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
              添加卡券 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li onclick="CardType.openCardModal(0,null);">
                    <a>添加抵现券</a>
                </li>
                <li onclick="CardType.openNetfeeCardModal(0,null);">
                    <a>添加网费兑换券</a>
                </li>
                <li onclick="CardType.openProductCardModal(0,null);">
                    <a>添加商品兑换券</a>
                </li>
            </ul>
          </div>

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
{include file="./modals/addnetfeecard.tpl"}

<script src="{$StaticRoot}/js/common/dateUtil.js"></script>
<script src="{$StaticRoot}/js/web/admin/cardtype.js"></script>
{include file="../../common/footer.tpl"}