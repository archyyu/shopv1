{include file="./common/header.tpl"}


<div id="app">
    <el-tabs value="waterbar" type="card" @tab-click="handleClick">
        <el-tab-pane name="waterbar" class="waterbar">
            <span slot="label"><iconfont iconclass="icon-wangdianguanli"></iconfont> 水吧</span>
            <waterbar></waterbar>
        </el-tab-pane>
        <el-tab-pane name="broadcast" lazy>
            <span slot="label"><iconfont iconclass="icon-xingxiaoxiaoguo"></iconfont> 语音播报</span>
            <broadcast></broadcast>
        </el-tab-pane>
        <el-tab-pane name="shift" lazy>
            <span slot="label"><iconfont iconclass="icon-shouzhiliushuizhang"></iconfont> 交班</span>
            <shift></shift>
        </el-tab-pane>
        <el-tab-pane name="order" lazy>
            <span slot="label"><iconfont iconclass="icon-liushui"></iconfont> 订单管理</span>
            <order></order>
        </el-tab-pane>
  </el-tabs>
</div>

<script src="{$StaticRoot}/js/cashier/store.js"></script>
<script src="{$StaticRoot}/js/cashier/urlHelper.js"></script>
<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>

{include file="./components/waterbar.tpl"}
{include file="./components/broadcast.tpl"}
{include file="./components/shift.tpl"}
{include file="./components/order.tpl"}
{include file="./components/iconfont.tpl"}

<script src="{$StaticRoot}/js/cashier/index.js"></script>


{include file="./common/footer.tpl"}