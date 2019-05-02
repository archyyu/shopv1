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
                    <img src="http://placehold.it/100x100" alt="">
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
                        <div class="func-btn-inner" @click="toWaterbar">点餐</div>
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
        info:function(){
        }
    }
});
</script>

{/literal}