{include file="./common/header.tpl"}

{literal}
<div id="app" oncontextmenu="self.event.returnValue=false">
    <el-dropdown class="message-list" v-if="isLogin">
        <span>
            消息提醒
            <el-badge
                class="message-badge"
                type="danger"
                :value="notifyList.length"
                :max="10"
                v-if="notifyList.length>0"></el-badge>
            <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
            <el-dropdown-item v-for="msg in notifyList">{{ msg }}</el-dropdown-item>
            <el-dropdown-item divided @click="clearNotifyList">清除</el-dropdown-item>
        </el-dropdown-menu>
    </el-dropdown>
    <el-tabs value="waterbar" type="card" @tab-click="tab"  v-if="isLogin">
        <el-tab-pane name="waterbar" class="waterbar">
            <span slot="label"><iconfont iconclass="icon-wangdianguanli"></iconfont> 水吧</span>
            <waterbar ref="waterbar"></waterbar>
        </el-tab-pane>
        {*<el-tab-pane name="broadcast">
            <span slot="label"><iconfont iconclass="icon-xingxiaoxiaoguo"></iconfont> 语音播报</span>
            <broadcast></broadcast>
        </el-tab-pane>*}
        <el-tab-pane name="shift">
            <span slot="label"><iconfont iconclass="icon-shouzhiliushuizhang"></iconfont> 交班</span>
            <shift ref="shift"></shift>
        </el-tab-pane>
        <el-tab-pane name="order">
            <span slot="label"><iconfont iconclass="icon-liushui"></iconfont> 订单管理</span>
            <order ref="order"></order>
        </el-tab-pane>
        <el-tab-pane name="member">
            <span slot="label"><iconfont iconclass="icon-jiti"></iconfont> 会员</span>
            <member ref="member"></member>
        </el-tab-pane>
    </el-tabs>

    <!-- login -->
    <div class="login-container" v-if="!isLogin">
        <el-form :modal="loginMsg" ref="loginForm" class="login-form">
            <h3 class="title">水吧登录</h3>
            <el-form-item prop="account">
                <span class="iconfont-wrap" @click="showPw = !showPw">
                    <span class="iconfont icon-account"></span>
                </span>
                <el-input v-model="loginMsg.account"></el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input :type="showPw?'text':'password'" prefix-icon="iconfont icon-lock" v-model="loginMsg.password">
                </el-input>
                <span class="iconfont-wrap show-pw" @click="showPw = !showPw">
                    <span :class="showPw?'icon-eye':'icon-hide'" class="iconfont eye-icon">
                </span>
            </el-form-item>
            <el-button :loading="loading" type="primary" class="login-btn" @click="login">
                登 录
            </el-button>
        </el-form>
    </div>

</div>
{/literal}
<script src="{$StaticRoot}/js/cashier/store.js"></script>
<script src="{$StaticRoot}/js/common/urlUtil.js"></script>
<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>
<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>
<script>Vue.component(VueQrcode.name, VueQrcode);</script>

{include file="./components/waterbar.tpl"}
{include file="./components/broadcast.tpl"}
{include file="./components/shift.tpl"}
{include file="./components/order.tpl"}
{include file="./components/member.tpl"}
{include file="./components/iconfont.tpl"}

<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>
<script src="{$StaticRoot}/js/cashier/index.js"></script>



{include file="./common/footer.tpl"}