<script type="text/x-template" id="waterbar">
    {literal}
    <div class="waterbar">
        <header class="header">
            <i class="cubeic-back" @click="backToMain()"></i>
            <div class="title">
                <span>点单</span>
            </div>
        </header>
        <div class="container">
            <div class="side-container">
                <cube-scroll-nav-bar direction="vertical" :current="currentNav" :labels="navList"
                    @change="changeHandler">
                    <i slot-scope="props">{{props.txt.typename}}</i>
                </cube-scroll-nav-bar>
            </div>
            <div class="product-container">
                <cube-scroll ref="scroll" :data="productlist" :options="pullOptions" @pulling-down="refresh"
                    @pulling-up="loadMore">
                    <ul class="foods-wrapper">
                        <li class="food-item" v-for="o in productlist">
                            <div class="icon"><img src="http://placehold.it/57x57">
                            </div>
                            <div class="food-content" @click="addCart(o.id,o.productname,o.memberprice,o.inventory)">
                                <h2 class="name">{{o.productname}}</h2>
                                <p class="description"></p>
                                <div class="price">
                                    <span class="now">￥{{o.memberprice/100}}</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </cube-scroll>
            </div>
            <div class="food-submit">
                <div class="cart" @click="showCart"><iconfont iconclass="icon-home1"></iconfont></div>
                <div class="price">￥{{getCartPrice()}}</div>
                <div class="checkout">
                    <cube-button :primary="true" @click="createOrder(0)">现金</cube-button>
                    <cube-button :primary="true" @click="createOrder(1)">微信</cube-button>
                    <cube-button :primary="true" @click="createOrder(2)">支付宝</cube-button>
                </div>
            </div>
            <cube-popup type="my-popup" position="bottom" :mask-closable="true" ref="cartPopup">
                <div class="cart-wrap">
                    <div class="cart-header">
                        <h5>已选商品</h5>
                        <cube-button  :inline="true" :outline="true" @click="clearCart">清空</cube-button>
                    </div>
                    <div class="cart-content">
                        <cube-scroll>
                            <ul>
                                <li v-for="item in cartlist">
                                    <div class="pro-title">{{item.productname}}</div>
                                    <div class="pro-price">￥{{item.price}}</div>
                                    <div class="pro-num">{{item.num}}</div>
                                </li>
                            </ul>
                        </cube-scroll>
                    </div>
                </div>
            </cube-popup>
            <cube-popup type="my-popup" position="bottom" :mask-closable="true" ref="qrcodePopup">
                <div class="cart-wrap">
                    <div class="cart-header">
                        <h5>请{{orderpaytype}}扫描下面二维码</h5>
                        <cube-button  :inline="true" :outline="true" @click="closeQrcode">取消</cube-button>
                    </div>
                    <div class="cart-content scan-code">
                        <qrcode :value="qrcodeurl"></qrcode>
                    </div>
                </div>
            </cube-popup>
        </div>
    </div>

</script>

<script>
Vue.component('waterbar', {
    name: 'Waterbar',
    template: '#waterbar',
    data: function () {
        return {
            currentNav: {"id":"饮料"},
            navList: [],
            productlist:[],
            cartlist:[],
            qrcodeurl:'www.baidu.com',
            orderstate:-1,
            orderpaytype:"微信",
            orderid:"",
            pullOptions: {
                pullDownRefresh: {
                    threshold: 60,
                    txt: '刷新成功'
                },
                pullUpLoad: {
                    threshold: 0,
                    txt: {
                        more: '加载更多',
                        noMore: '没有数据了'
                    }
                },
                scrollbar: true
            },
            cartItem: [
                {
                    text: 'cart',
                    action: 'showCart'
                },
                {
                    text: 'money'
                },
                {
                    text: '去结算',
                    action: 'checkout'
                }
            ]
        };
    },
    computed: {
    },
    created:function(){
        setInterval(()=>{
                this.queryOrderState();
                },2000);
    },
    mounted() {
        this.queryTypeList();
    },
    methods: {
        
        changeHandler:function(cur){
            this.defaulttypeid = cur.id;
            this.queryProductList(this.defaulttypeid);
        },
        
        queryTypeList: function () {
            var params = Store.createParams();
            //params.shopid = typeid;
            axios.post(UrlHelper.createUrl('product','loadProductTypeList'), params)
                .then((res) => {
                    res = res.data;
                    if (res.state == 0) {
                        //this.navList = res.obj;
                        
                        for(var i = 0;i<res.obj.length;i++){
                            this.navList.push(res.obj[i]);
                        }
                        
                        console.log(this.navList);
                        this.defaulttypeid = res.obj[0].id;
                        this.queryProductList(this.defaulttypeid);
                    }
                });
        },
        
        addCart: function (productid, productname, price,inventory) {

            if(this.orderState != -1){
                this.orderState = -1;
            }
                
            this.editBtnShow = true;

            if(inventory <= 0){
                this.$message.error("库存不足,请进货或者调货");
                return;
            }
            
            Toast.success("已添加购物车");

            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == productid) {
                    this.cartlist[i].num += 1;
                    this.cartlist[i].price += price / 100;
                    return;
                }
            }

            var cart = {};
            cart.productid = productid;
            cart.num = 1;
            cart.price = price / 100;
            cart.productname = productname;
            this.cartlist.push(cart);
            
        },
        
        getCartPrice:function(){
            let sum = 0;
            for(let cart of this.cartlist){
                sum += cart.price;
            }
            return sum;
        },
        
        clearCart:function(){
            this.cartlist = [];
            Toast.success("购物车已经清空");
            this.closeCart();
        },
        
        queryProductList: function (type) {
            let params = Store.createParams();
            params.type = type;
            if(type){
                this.activeNav = type;
            }
            
            params.typeid = type;
            
            axios.post(UrlHelper.createUrl('product','loadProduct'), params)
                .then((res) => {
                    res = res.data;
                    console.log(res);
                    if (res.state == 0) {
                        this.productlist = res.obj;
                    }
                });
        },
        
        
        
        refresh: function () {
            console.log('refresh');
        },
        
        loadMore: function () {
            console.log('load');
        },
        
        backToMain:function(){
            this.$root.toIndex();
        },
        
        createOrder:function(paytype){
            
            if(this.cartlist.length <= 0){
                this.$message.error("购物车为空");
                return;
            }
            
            var url = UrlHelper.createUrl('order','createOrder');
            var params = Store.createParams();
            params.address = this.address;
            params.paytype = paytype;
            params.productlist = JSON.stringify(this.cartlist);
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            console.log("create order ok");
                            Toast.success("下单成功");
                            
                            if(paytype == 0){
                                this.orderState = 1;
                                
                            }
                            else if(paytype == 1 || paytype == 2){
                                this.orderState = 0;
                                this.qrcodeurl = res.obj.payurl;
                                this.orderid = res.obj.orderid;
                                
                                if(paytype == 1){
                                    this.orderpaytype = "微信";
                                }
                                else if(paytype == 2){
                                    this.orderpaytype = "支付宝";
                                }
                                
                                this.orderstate = 0;
                                
                                this.showQrcode();
                                
                            }
                            
                            this.cartlist = [];
                            
                        }
                        else{
                            this.$message.error(res.msg);
                        }
                        });
            
        },
        
        queryOrderState:function(){
            
            if(this.orderstate != 0){
                return;
            }
            
            var params = Store.createParams();
            params.orderid = this.orderid;
            var url = UrlHelper.createUrl("order","queryOrderState");
            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    console.log(res);
                    if(res.state == 0){
                        if(res.obj >= 0){
                            Toast.success("订单已经支付");
                            this.closeQrcode();
                            this.orderstate = -1;
                        }
                    }
                });
            
            
        },

        showCart: function(){
            this.$refs.cartPopup.show();
        },
        
        closeCart:function(){
            this.$refs.cartPopup.hide();
        },
        
        showQrcode:function(){
            this.$refs.qrcodePopup.show();
        },
        closeQrcode:function(){
            this.orderstate = -1;
            this.$refs.qrcodePopup.hide();
        }
    }
}); 
</script>

{/literal}