{include file="./common/header.tpl"}


<div id="app">
    <el-tabs value="waterbar" type="card" @tab-click="handleClick">
        <el-tab-pane name="waterbar" class="waterbar">
            <span slot="label"><i class="el-icon-date"></i> 水吧</span>
            <waterbar></waterbar>
        </el-tab-pane>
        {include file="./components/broadcast.tpl"}
        {include file="./components/shift.tpl"}
        {include file="./components/order.tpl"}
  </el-tabs>
</div>

{include file="./components/waterbar.tpl"}

<script src="{$StaticRoot}/js/cashier/index.js"></script>

{include file="./common/footer.tpl"}