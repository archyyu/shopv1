{include file="./common/header.tpl"}

{literal}
<div id="app">
    <div class="page-wrap user-page">
        <cube-tab-panels v-model="selectedLabel">
            <cube-tab-panel label="waterbar">
                <waterbar ref="waterbar"></waterbar>
            </cube-tab-panel>
            <cube-tab-panel label="order">
                <order></order>
            </cube-tab-panel>
            <cube-tab-panel label="mine">
                <mine></mine>
            </cube-tab-panel>
            <cube-tab-panel label="cardList">
                card list
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
{include file="./components/userwaterbar.tpl"}
{include file="./components/userorder.tpl"}
{include file="./components/usermine.tpl"}

<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>
<script src="{$StaticRoot}/js/mobile/user.js"></script>


{include file="./common/footer.tpl"}