<script type="text/x-template" id="order">
    {literal}
    <div class="count">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>订单列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="count-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>订单Id</th>
                                <th>价格</th>
                                <th>支付方式</th>
                                <th>订单来源</th>
                                <th>时间</th>
                                <th>操作</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="order in orderList">
                                <td>{{order.id}}</td>
                                <td>{{order.orderprice/100}}元</td>
                                <td>{{Store.paytypeStr(order.paytype)}}</td>
                                <td>{{Store.ordersourceStr(order.ordersource)}}</td>
                                <td>{{DateUtil.parseTimeInYmdHms(order.paytime)}}</td>
                                <td><cube-button @click="lookOrderDetail(order.orderdetail)">商品详情</cube-button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>
        </div>
        
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
            this.orderproductlist = orderProductList;
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
        showQrcode:function(){
            this.$refs.qrcodePopup.show();
        },
        info: function () {

        }
    }
});
</script>

{/literal}