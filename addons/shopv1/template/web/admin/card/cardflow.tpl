{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="card-flow">
    <div class="search-group">
        <div class="form-inline">
            <div class="form-group form-group-sm">
                <label class="control-label">时间起止</label>
                <input type="text" id="timearea" class="form-control range-picker-js">
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">发放门店</label>
                <select id="sendshopid" class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                    {foreach $shopList as $store}
                    <option id="option_{$store.id}" value='{$store.id}'>{$store.shopname}</option>
                    {/foreach}
                </select>
            </div>
            <!-- <div class="form-group form-group-sm">
                <label class="control-label">卡券类型</label>
                <select id="cardtype" class="form-control input-sm selectpicker">
                    <option value="2">请选择</option>
                    <option value="0">抵现卷</option>
                    <option value="1">兑换卷</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">搜索会员</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div> -->
            <div class="form-group form-group-sm">
                <label class="control-label">使用门店</label>
                <select id="usedshopid" class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                    {foreach $shopList as $store}
                    <option value='{$store.id}'>{$store.shopname}</option>
                    {/foreach}
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">卡券名称</label>
                <select id="cardid" class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                    {foreach $cardlist as $card}
                    <option value='{$card.id}'>{$card.cardname}</option>
                    {/foreach}
                    
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">卡券状态</label>
                <label class="radio-inline">
                    <input name="useflag" type="radio" value="2" checked> 全部
                </label>
                <label class="radio-inline">
                    <input name="useflag" type="radio" value="0"> 未使用
                </label>
                <label class="radio-inline">
                    <input name="useflag" type="radio" value="1"> 已使用
                </label>
            </div>
            <button class="btn btn-sm btn-primary" onclick="Cardflow.refreshTable();">搜索</button>
        </div>
    </div>
    <div class="card-info">
        <ul class="clearfix">
            <li>卡券总支出：<span>0</span> 张</li>
            <li>已使用：<span>0</span> 张</li>
            <li>使用率：<span>0</span> %</li>
        </ul>
    </div>
    <div class="detail_content">
        <table id="cardFlowTable" class="table">
        </table>
    </div>
</div>

{include file="./modals/addcard.tpl"}
{include file="./modals/sendcard.tpl"}
{include file="./modals/selectmember.tpl"}

<script>
    $(".range-picker-js").daterangepicker();
    
</script>

<script src="{$StaticRoot}/js/web/admin/cardflow.js"></script>

{include file="../../common/footer.tpl"}