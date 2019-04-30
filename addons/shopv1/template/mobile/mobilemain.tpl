{include file="./common/header.tpl"}

{literal}
<div id="app">
    <div class="page-wrap" v-if="isLogin">
        <cube-tab-bar v-model="selectedLabel" show-slider>
            <cube-tab v-for="(item, index) in tabs" :icon="item.icon" :label="item.label" :key="item.label">
            </cube-tab>
        </cube-tab-bar>
        <cube-tab-panels v-model="selectedLabel">
            <cube-tab-panel label="shift">
                <shift></shift>
            </cube-tab-panel>
            <cube-tab-panel label="count">
                <count></count>
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

{include file="./components/count.tpl"}
{include file="./components/shift.tpl"}


<script src="{$StaticRoot}/js/mobile/store.js"></script>
<script src="{$StaticRoot}/js/mobile/urlHelper.js"></script>
<script src="{$StaticRoot}/js/common/urlUtil.js"></script>


<script src="{$StaticRoot}/js/mobile/index.js"></script>
<script src="{$StaticRoot}/js/mobile/toast.js"></script>
<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>



{include file="./common/footer.tpl"}