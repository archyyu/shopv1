<script type="text/x-template" id="order">
    {literal}
    <div class="order">
        <header class="header">
            <div class="title">
                <span>订单列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll direction="horizontal" class="horizontal-scroll-list-wrap" :options="scrollOptions">
                <div class="list-wrapper">
                    <table class="table list-item">
                        <thead>
                            <tr>
                                <th>订单Id</th>
                                <th>价格</th>
                                <th>支付方式</th>
                                <th>订单来源</th>
                                <th>时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="order in orderList">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <cube-button :inline="true">商品详情
                                    </cube-button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>

            <cube-popup position="bottom" :mask-closable="true" ref="proDetailPopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>商品详情</h5>
                        <cube-button :inline="true" :outline="true" @click="closepopup">关闭</cube-button>
                    </div>
                    <div class="my-popup-content">
                        <cube-scroll :options="{scrollbar:true}">
                            <ul>
                                <li>
                                    <div class="pro-title">商品名称</div>
                                    <div class="pro-price">总价</div>
                                    <div class="pro-num">数量</div>
                                </li>
                                <li>
                                    <div class="pro-title"></div>
                                    <div class="pro-price"></div>
                                    <div class="pro-num"></div>
                                </li>
                            </ul>
                        </cube-scroll>

                    </div>
                </div>
            </cube-popup>

        </div>
    </div>

</script>

<script>
Vue.component('order', {
    name: 'Order',
    template: '#order',
    data: function(){
        return {
            scrollOptions:{
                freeScroll: true,
                eventPassthrough:'vertical'
            },
            Store:Store,
            DateUtil:DateUtil,
            orderList: [],
            orderproductlist:[]
        };
    },
    created() {},
    mounted() {
        
    },
    methods: {
        open:function(){
        },
        closepopup:function(){ 
            this.$refs.proDetailPopup.hide(); 
        },
        info: function () {

        }
    }
});
</script>

{/literal}