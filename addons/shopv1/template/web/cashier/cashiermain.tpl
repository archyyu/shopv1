{include file="./common/header.tpl"}


<div id="app">
    <el-tabs value="waterbar" type="card" @tab-click="handleClick">
        <el-tab-pane name="waterbar" class="waterbar">
            <span slot="label"><i class="el-icon-date"></i> 水吧</span>
            <waterbar></waterbar>
        </el-tab-pane>
        <el-tab-pane name="broadcast" lazy>
            <span slot="label"><i class="el-icon-date"></i> 语音播报</span>
            <broadcast></broadcast>
        </el-tab-pane>
        <el-tab-pane name="shift" lazy>
            <span slot="label"><i class="el-icon-date"></i> 交班</span>
            <shift></shift>
        </el-tab-pane>
        <el-tab-pane name="order" lazy>
            <span slot="label"><i class="el-icon-date"></i> 订单管理</span>
            <order></order>
        </el-tab-pane>
  </el-tabs>
</div>

{include file="./components/waterbar.tpl"}
{include file="./components/broadcast.tpl"}
{include file="./components/shift.tpl"}
{include file="./components/order.tpl"}

<script src="{$StaticRoot}/js/cashier/index.js"></script>

{include file="./common/footer.tpl"}