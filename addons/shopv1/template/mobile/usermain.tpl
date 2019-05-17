{include file="./common/header.tpl"}

{literal}
<div id="app">
    <div class="page-wrap user-page">
        <cube-tab-panels v-model="selectedLabel" :class="{'bar-hide': !tabbarShow}">
            <cube-tab-panel label="waterbar">
                <waterbar ref="waterbar"></waterbar>
            </cube-tab-panel>
            <cube-tab-panel label="order">
                <order ref="order"></order>
            </cube-tab-panel>
            <cube-tab-panel label="mine">
                <mine ref="mine"></mine>
            </cube-tab-panel>
            <cube-tab-panel label="cardList"> 
                <card-list ref="cardList"></card-list>
            </cube-tab-panel>
        </cube-tab-panels>
        <cube-tab-bar
            v-model="selectedLabel"
            v-if="tabbarShow"
            :data="tabs">
        </cube-tab-bar>
    </div>
</div>

{/literal}

{include file="./common/iconfont.tpl"}
{include file="./common/bottompopup.tpl"}
{include file="./components/userwaterbar.tpl"}
{include file="./components/userorder.tpl"}
{include file="./components/usermine.tpl"}
{include file="./components/usercardlist.tpl"}


<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>
<script src="{$StaticRoot}/js/mobile/store.js"></script>
<script src="{$StaticRoot}/js/mobile/urlHelper.js"></script>
<script src="{$StaticRoot}/js/common/urlUtil.js"></script>
<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>
<script src="{$StaticRoot}/js/mobile/user.js"></script>
<script src="{$StaticRoot}/js/mobile/toast.js"></script>


{include file="./common/footer.tpl"}