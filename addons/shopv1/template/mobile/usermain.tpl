{include file="./common/header.tpl"}

{literal}
<div id="app">
    <div class="page-wrap user-page">
    <router-view></router-view>
        <cube-tab-panels v-model="selectedLabel">
            <cube-tab-panel label="index">
                index
            </cube-tab-panel>
            <cube-tab-panel label="shift">
                shift
            </cube-tab-panel>
            <cube-tab-panel label="count">
                count
            </cube-tab-panel>
            <cube-tab-panel label="cardList">
                card list
            </cube-tab-panel>
        </cube-tab-panels>
        <cube-tab-bar
            v-model="selectedLabel"
            :data="tabs">
        </cube-tab-bar>
    </div>
</div>

{/literal}

{include file="./common/iconfont.tpl"}

<script src="{$StaticRoot}/js/mobile/user.js"></script>


{include file="./common/footer.tpl"}