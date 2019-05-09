{include file="./common/header.tpl"}

{literal}
<div id="app">
    <div class="page-wrap" v-if="isLogin">
        <cube-tab-panels v-model="selectedLabel">
            <cube-tab-panel label="index">
                <index ref="index"></index>
            </cube-tab-panel>
            <cube-tab-panel label="shift">
                <shift ref="shift"></shift>
            </cube-tab-panel>
            <cube-tab-panel label="count">
                <count ref="count"></count>
            </cube-tab-panel>
            <cube-tab-panel label="order">
                <order ref="order"></order>
            </cube-tab-panel>
            <cube-tab-panel label="waterbar">
                <waterbar ref="waterbar"></waterbar>
            </cube-tab-panel>
            <cube-tab-panel label="card">
                <card ref="card"></card>
            </cube-tab-panel>
            <cube-tab-panel label="member">
                <member ref="member"></member>
            </cube-tab-panel>
            <cube-tab-panel label="memberDetail">
                <member-detail ref="memberDetail"></member-detail>
            </cube-tab-panel>
        </cube-tab-panels>
    </div>
    <div class="login-container" v-if="!isLogin">
        <cube-form :model="loginMsg">
            <cube-form-group>
                <cube-form-item v-model="loginMsg.account" :field="fields[0]"></cube-form-item>
                <cube-form-item v-model="loginMsg.password" :field="fields[1]"></cube-form-item>
            </cube-form-group>
            <cube-form-group>
                <cube-button @click="login" type="submit">登 录</cube-button>
            </cube-form-group>
        </cube-form>
    </div>
</div>

{/literal}

{include file="./common/iconfont.tpl"}
{include file="./components/mobileindex.tpl"}
{include file="./components/count.tpl"}
{include file="./components/shift.tpl"}
{include file="./components/waterbar.tpl"}
{include file="./components/card.tpl"}
{include file="./components/member.tpl"}
{include file="./components/memberdetail.tpl"}
{include file="./components/order.tpl"}


<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>
<script src="{$StaticRoot}/js/mobile/store.js"></script>
<script src="{$StaticRoot}/js/mobile/urlHelper.js"></script>
<script src="{$StaticRoot}/js/common/urlUtil.js"></script>
<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>
<script>Vue.component(VueQrcode.name, VueQrcode);</script>

<script src="{$StaticRoot}/js/mobile/index.js"></script>
<script src="{$StaticRoot}/js/mobile/toast.js"></script>


{include file="./common/footer.tpl"}