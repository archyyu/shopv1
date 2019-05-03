<script type="text/x-template" id="index">
    {literal}
    <div class="index">
        <header class="header">
            <i class="cubeic-back"></i>
            <div class="title">
                <span>首页</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="qrcode">
                    <qrcode :value="qrcodeurl"></qrcode>
                </div>
                <div class="func-btn">
                    <div class="func-btn-item">
                        <div class="func-btn-inner" @click="toShift()">交班</div>
                    </div>
                    <div class="func-btn-item">
                        <div class="func-btn-inner" @click="toCount()">盘点</div>
                    </div>
                    <div class="func-btn-item">
                        <div class="func-btn-inner" @click="toOrder()">订单</div>
                    </div>
                    <div class="func-btn-item">
                        <div class="func-btn-inner" @click="toWaterbar()">点餐</div>
                    </div>
                    <div class="func-btn-item">
                        <div class="func-btn-inner" @click="toCard()">卡券</div>
                    </div>
                   <div class="func-btn-item">
                        <div class="func-btn-inner" @click="toMember()">会员</div>
                    </div>
                </div>
            </cube-scroll>
        </div>
    </div>

</script>

<script>
Vue.component('index', {
    name: 'Index',
    template: '#index',
    data: function(){
        return {
            qrcodeurl:'www.baidu.com'
        };
    },
    methods: {
        toShift:function(){
            this.$root.toShift();
        },
        
        toCount:function(){
            this.$root.toCount();
        },
        toWaterbar:function(){
            this.$root.toWaterbar();
        },
        toOrder:function(){
            this.$root.toOrder();
        },
        toCard:function(){
            this.$root.toCard();
        },
        toMember:function(){
            this.$root.toMember();
        },
        info:function(){
        }
    }
});
</script>

{/literal}