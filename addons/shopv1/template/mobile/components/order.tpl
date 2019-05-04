<script type="text/x-template" id="order">
    {literal}
    <div class="order">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>订单列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll 
                direction="horizontal"
                class="horizontal-scroll-list-wrap"
                :options="{eventPassthrough:vertical}">
            <div class="list-wrapper">
                    <table class="table list-item">
                        <thead>
                            <tr>
                                <th class="orderIdTh">订单Id</th>
                                <th>价格</th>
                                <th>支付方式</th>
                                <th>订单来源</th>
                                <th>时间</th>
                                <th>操作</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="order in orderList">
                                <td class="orderIdTd">{{order.id}}</td>
                                <td>{{order.orderprice/100}}元</td>
                                <td>{{Store.paytypeStr(order.paytype)}}</td>
                                <td>{{Store.ordersourceStr(order.ordersource)}}</td>
                                <td class="orderTimeTd">{{DateUtil.parseTimeInYmdHms(order.paytime)}}</td>
                                <td><cube-button :inline="true" @click="lookOrderDetail(order.orderdetail)">商品详情</cube-button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>

        <cube-popup position="bottom" :mask-closable="true" ref="proDetailPopup">
            <div class="my-popup-wrap">
                <div class="my-popup-header">
                    <h5>商品详情</h5>
                    <cube-button  :inline="true" :outline="true" @click="closepopup">关闭</cube-button>
                </div>
                <div class="my-popup-content">
                    <cube-scroll>
                        <ul>
                            <li v-for="item in orderproductlist">
                                <div class="pro-title">{{item.productname}}</div>
                                <div class="pro-price">￥{{item.price}}</div>
                                <div class="pro-num">{{item.num}}</div>
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
            Store:Store,
            DateUtil:DateUtil,
            orderList: [],
            orderproductlist:[]
        };
    },
    created() {},
    mounted() {
        this.queryOrderList();
    },
    methods: {
        backToMain:function(){
            this.$root.toIndex();
        },
        
        lookOrderDetail:function(orderProductList){
            console.log(orderProductList);
            this.orderproductlist = JSON.parse(orderProductList);
            this.$refs.proDetailPopup.show();
        },
        clearCart:function(){ 
            this.$refs.proDetailPopup.hide(); 
        },
        queryOrderList:function(){
            let params = Store.createParams();
            let url = UrlHelper.createUrl("order", "cashierQueryOrder");
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            this.orderList = res.obj;
                        }
                        });
            
        },
        info: function () {

        }
    }
});
</script>

{/literal}