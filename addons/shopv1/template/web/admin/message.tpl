{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

<div class="bar-select">
    <label class="control-label">门店：</label>
    <select id="shopSelect" class="mysele" data-live-search="true" data-size="6">

        {foreach $shopList as $store}
            <option value='{$store.id}' >{$store.shopname}</option>
        {/foreach}

    </select>
</div>

<div class="staff-list">
    <div class="staff">
        <div class="staff-group-table">
            <table id="messageListTable" class="table table-bordered">
                <thead>
                <tr>

                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script src="{$StaticRoot}/js/web/admin/message.js"></script>

{include file="../common/footer.tpl"}
