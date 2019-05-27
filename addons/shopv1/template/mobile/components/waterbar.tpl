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
                            <div class="icon"><img :src="getImgUrl(o)">
                            </div>
                            <div class="food-content" @click="addCart(o)">
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
                <div class="cart" @click="showCart"><iconfont iconclass="icon-shopcar"></iconfont></div>
                <div class="price">￥{{getCartPrice()}}</div>
                <div class="checkout">
                    <cube-button :primary="true" :disabled="orderState == 0" @click="showPayMethod()">支 付</cube-button>
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
                                    <div class="pro-price">￥{{(item.price*item.num).toFixed(2)}}</div>
                                    <div class="pro-num">
                                        <cube-button  :inline="true" :outline="true" @click="cartDeduct(cart.productid)">-</cube-button>
                                        <span>{{item.num}}</span>
                                        <cube-button  :inline="true" :outline="true" @click="cartAdd(cart.productid)">+</cube-button>
                                    </div>
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

            <bottom-popup label="payMethod" title="支付选项" height="auto" cubeclass="pay-popup" ref="payPopup">
                <template v-slot:content>
                    <cube-form :model="payModel">
                        <cube-form-item :field="payFields[0]"></cube-form-item>
                        <cube-form-item :field="payFields[1]"></cube-form-item>
                        <cube-form-item :field="payFields[2]"></cube-form-item>
                    </cube-form>
                </template>
                <template v-slot:footer>
                    <cube-button :inline="true" @click="createOrder()">确认下单</cube-button>
                </template>
            </bottom-popup>
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
            orderState:-1,
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
            ],
            payModel: {
                seat: '',
                phone: '',
                paytype: '',
            },
            payFields: [
                {
                    type: 'input',
                    modelKey: 'seat',
                    label: '座位号',
                },
                {
                    type: 'input',
                    modelKey: 'phone',
                    label: '手机号'
                },
                {
                    type: 'radio-group',
                    modelKey: 'paytype',
                    label: '支付方式',
                    props: {
                        options: [
                            {
                                label: '现金',
                                value: 0
                            },
                            {
                                label: '微信',
                                value: 1
                            },
                            {
                                label: '支付宝',
                                value: 2
                            },
                        ],
                        position: 'right'
                    },
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
        
        getImgUrl:function(p){
            return UrlHelper.getWebBaseUrl() + p.productimg;
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
        
        
        cartAdd:function(productid){
        
            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == productid) {
                    this.cartlist[i].num += 1;
                    return;
                }
            }
            
        },
        
        cartDeduct:function(productid){
            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == productid) {
                    this.cartlist[i].num -= 1;
                    
                    if(this.cartlist[i].num == 0){
                        this.cartlist.splice(i);
                    }
                    
                    return;
                }
            }
        },
        
        addCart: function (p) {

            if(this.orderState != -1){
                this.orderState = -1;
            }
                
            this.editBtnShow = true;

            if(p.inventory <= 0){
                Toast.error("库存不足,请进货或者调货");
                return;
            }
            
            Toast.success("已添加购物车");

            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == p.id) {
                    this.cartlist[i].num += 1;
                    return;
                }
            }

            var cart = {};
            cart.productid = p.id;
            cart.num = 1;
            cart.price = p.normalprice / 100;
            cart.memberprice = p.memberprice/100;
            cart.normalprice = p.normalprice/100;
            cart.userget = p.userget;
            cart.productname = p.productname;
            cart.make = p.make;
            cart.typeid = p.typeid;
            this.cartlist.push(cart);
            
        },
        
        getCartPrice:function(){
            let sum = 0;
            
            //let card = this.findMemberCard();
            
            for(let cart of this.cartlist){
                sum += cart.price*cart.num;
            }
            return sum.toFixed(2);
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

        showPayMethod: function(){
            // if(this.cartlist.length <= 0){
            //     Toast.error("购物车为空");
            //     return;
            // }
            this.$refs.payPopup.showPopup();
        },

        hidePayMethod: function(){
            this.$refs.payPopup.closePopup();
        },

        createOrder:function(){
            
            if(this.cartlist.length <= 0){
                Toast.error("购物车为空");
                return;
            }

            var paytype = this.payModel.paytype;
            var url = UrlHelper.createUrl('order','createOrder');
            var params = Store.createParams();
            params.address = this.payModel.seat;
            params.phone = this.payModel.phone;
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
                                this.cartlist = [];
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
                                
                                this.orderState = 0;
                                this.hidePayMethod();
                                this.showQrcode();
                            }
                            
                            
                            
                        }
                        else{
                            Toast.error(res.msg);
                        }
                        });
            
        },
        
        queryOrderState:function(){
            
            if(this.orderState != 0){
                return;
            }
            
            var params = Store.createParams();
            params.orderid = this.orderid;
            var url = UrlHelper.createUrl("order","queryOrderState");
            axios.post(url,params,LoadingType.hideLoading())
                .then((res)=>{
                    res = res.data;
                    console.log(res);
                    if(res.state == 0){
                        if(res.obj >= 0){
                            Toast.success("订单已经支付");
                            this.cartlist = [];
                            this.closeQrcode();
                            this.orderState = -1;
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
            this.orderState = -1;
            this.cartlist = [];
            this.$refs.qrcodePopup.hide();
        }
    }
}); 
</script>

{/literal}
