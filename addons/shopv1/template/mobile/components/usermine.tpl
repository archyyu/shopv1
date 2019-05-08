<script type="text/x-template" id="mine">
    {literal}
    <div class="user-mine">
        <header class="header">
            <div class="title">
                <span>我的</span>
            </div>
        </header>
        <div class="container">
            <div class="mine-base">
                <div class="avatar"><img src="" alt=""></div>
                <div class="mine-name">
                    <p class="name">姓名</p>
                    <p class="cellphone">手机号</p>
                </div>
            </div>
            <cube-scroll>
                <div class="mine-info">
                    <div class="weui-cells">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>身份证</p>
                            </div>
                            <div class="weui-cell__ft">12345678910</div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>积分</p>
                            </div>
                            <div class="weui-cell__ft">5000</div>
                        </div>
                        <div class="weui-cell weui-cell_access" @click="toCard">
                            <div class="weui-cell__bd">
                                <p>卡券</p>
                            </div>
                            <div class="weui-cell__ft">5 张</div>
                        </div>
                    </div>
                </div>
            </cube-scroll>
        </div>
    </div>

</script>

<script>
Vue.component('mine', {
    name: 'Mine',
    template: '#mine',
    data: function(){
        return {
        };
    },
    methods: {
        open:function(){
        },
        toCard:function(){
            this.$root.selectedLabel = 'card';
        },
        info: function () {

        }
    }
});
</script>

{/literal}