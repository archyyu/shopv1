{literal}
<script type="text/x-template" id="confirmOrder">
    <div class="confirm-order">
        <header class="header">
            <span class="cubeic-back" @click="back"></span>
            <div class="title">
                <span>订单详情</span>
            </div>
        </header>
        <div class="container">
            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>订单编号</p>
                    </div>
                    <div class="weui-cell__ft">123456</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>座位号</p>
                    </div>
                    <div class="weui-cell__ft">123456</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>商品列表</p>
                    </div>
                    <div class="weui-cell__ft">123456</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>优惠券</p>
                    </div>
                    <div class="weui-cell__ft">123456</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>支付方式</p>
                    </div>
                    <div class="weui-cell__ft">钱包支付</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>实际支付</p>
                    </div>
                    <div class="weui-cell__ft">123456</div>
                </div>
                <div class="weui-cell">
                    <cube-button :primary="true" @click="showPassword">确认支付</cube-button>
                </div>
            </div>
        </div>
    </div>
</script>


<script>
Vue.component('confirm-order', {
    name: 'ConfirmOrder',
    template: '#confirmOrder',
    data() {
        return {}
    },
    methods: {
        open: function () {},

        back: function () {
            this.$root.toIndex();
        },

        showPassword: function () {
            this.passowrdPopup = this.$createDialog({
                type: 'prompt',
                title: '请输入密码',
                prompt: {
                    value: '',
                    placeholder: '请输入密码'
                },
                onConfirm: function(e, value) {
                    console.log(value);
                }
            }).show();
        },

        info: function () {

        }

    }
});
</script>
{/literal}