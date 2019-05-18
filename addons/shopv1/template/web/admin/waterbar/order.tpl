{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

<div class="bar-select">
    <label class="control-label">门店：</label>
    <select id="shopSelect" class="mysele" data-live-search="true" data-size="6">

        {foreach $shopList as $store}
        <option value='{$store.id}'>{$store.shopname}</option>
        {/foreach}

    </select>
</div>
<div class="search-group">
    <div class="form-inline">
        <div class="form-group form-group-sm">
            <label class="control-label">时间起止</label>
            <input type="text" id="timearea" class="form-control range-picker-js">
        </div>
        <div class="form-group form-group-sm">
            <label class="control-label">吧员</label>
            <select id="usersList" class="form-control input-sm selectpicker">
                <option value="">请选择</option>
            </select>
        </div>
        <!-- <div class="form-group form-group-sm">
            <label class="control-label">卡券类型</label>
            <select class="form-control input-sm selectpicker">
                <option value="">请选择</option>
            </select>
        </div>
        <div class="form-group form-group-sm">
            <label class="control-label">卡券名称</label>
            <select class="form-control input-sm selectpicker">
                <option value="">请选择</option>
            </select>
        </div> -->
        <div class="form-group form-group-sm">
            <label class="control-label">订单状态</label>
            <label class="radio-inline">
                <input class="orderstate" name="orderstate" type="radio" value="2" checked> 全部
            </label>
            <label class="radio-inline">
                <input class="orderstate" name="orderstate" type="radio" value="0"> 已支付
            </label>
            <label class="radio-inline">
                <input class="orderstate" name="orderstate" type="radio" value="-1"> 未支付
            </label>
            <label class="radio-inline">
                <input class="orderstate" name="orderstate" type="radio" value="1"> 已完成
            </label>
        </div>
        <button class="btn btn-sm btn-primary" onclick="Order.refreshTable();">搜索</button>
        
    </div>
</div>

<div class="staff-list">
    <div class="staff">
        <div class="staff-group-table">
            <table id="OrderListTable" class="table table-bordered">
                <thead>
                    <tr>

                    </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script>
    $(".range-picker-js").daterangepicker();
</script>

<script src="{$StaticRoot}/js/web/admin/order.js"></script>

{include file="../../common/footer.tpl"}