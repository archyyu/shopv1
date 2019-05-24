<script type="text/x-template" id="waterbar">
    {literal}
    <div class="waterbar">
        <header class="header">
            <div class="title">
                <cube-select
                    v-model="selectShop"
                    :auto-pop="false"
                    :options="shopList"
                    @change="shopSelect"
                    ref="shopSelect">
                </cube-select>
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
                    <cube-button :primary="true" @click="showPayMethod()">支付</cube-button>
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
                                        <cube-button  :inline="true" :outline="true" @click="cartdeduct(item.productid)">-</cube-button>
                                        <span>{{item.num}}</span>
                                        <cube-button  :inline="true" :outline="true" @click="cartadd(item.productid)">+</cube-button>
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
                        <h5>请扫描下面二维码</h5>
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
                </cube-form>
                </template>
                <template v-slot:footer>
                    <cube-button :inline="true" @click="createOrder()">确认下单</cube-button>
                </template>
            </bottom-popup>

            <bottom-popup label="combo" title="套餐详情" cubeclass="combo-popup"  ref="comboPopup">
                <template v-slot:content>
                    <h4>套餐名称：</h4>
                    <p>套餐详情：</p>
                    <ul>
                        <li>米饭<span>(1 份)</span></li>
                    </ul>
                </template>
                <template v-slot:footer>
                    <cube-button :inline="true">加入购物车</cube-button>
                </template>
            </bottom-popup>
        </div>
    </div>
    {/literal}
</script>

<script>
Vue.component('waterbar', {
    name: 'Waterbar',
    template: '#waterbar',
    data: function () {
        return {
            selectShop: 0,
            shopList: [

            ],
            currentNav: {},
            navList: [],
            productlist:[],
            cartlist:[],
            orderState:-1,
            cardList: [],
            orderpaytype:"微信",
            payinfo:{},
            shopid:0,
            remark:"",
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
                card: ''
            },
            payFields: [
                {
                    type: 'input',
                    modelKey: 'shopid',
                    label: '座位号',
                },
                {
                    type: 'select',
                    modelKey: 'shopid',
                    label: '卡券',
                    props: {
                        options: this.cardList,
                        title: '请选择卡券'
                    }
                }
            ]
        };
    },
    computed: {
    },
    created:function(){
    },
    mounted() {
        this.queryShopList();
        this.queryTypeList();
        this.queryMemberCardList();
        this.$refs.shopSelect.showPicker()
    },
    methods: {

        queryShopList:function(){
            let params = {};

            axios.post(UrlHelper.createShortUrl("loadShopList"),params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){

                        let list = res.obj;
                        for(let shop of list){
                            let item  = {};
                            item.value = shop.id;
                            item.text = shop.shopname;

                            this.shopList.push(item);
                        }

                    }
                });

        },

        queryMemberCardList:function(){

            let params = {};

            axios.post(UrlHelper.createShortUrl("getCardList"),params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        //this.cardList = res.obj;

                        for(let card of res.obj){
                            let item = {};
                            item.value = card.id;
                            item.label = card.cardname;
                            this.cardList.push(item);
                        }

                    }
                });

        },

        changeHandler:function(cur){
            this.defaulttypeid = cur.id;
            this.queryProductList(this.defaulttypeid);
        },

        shopSelect:function(){
            this.queryProductList(this.defaulttypeid);
        },
        
        getImgUrl:function(p){
            return UrlHelper.getAppBaseUrl() + p.productimg;
        },
        
        queryTypeList: function () {
            let params = {};
            //params.shopid = typeid;
            axios.post(UrlHelper.createShortUrl('loadProductTypeList'), params)
                .then((res) => {
                    res = res.data;
                    if (res.state == 0) {
                        //this.navList = res.obj;
                        
                        for(var i = 0;i<res.obj.length;i++){
                            this.navList.push(res.obj[i]);
                        }
                        
                        console.log(this.navList);
                        this.defaulttypeid = res.obj[0].id;
                        //this.queryProductList(this.defaulttypeid);
                    }
                });
        },
        
        addCart: function (p) {
            this.showCombo
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
            cart.productname = p.productname;
            cart.make = p.make;
            cart.typeid = p.typeid;
            this.cartlist.push(cart);
            
        },
        
        getCartPrice:function(){
            let sum = 0;
            for(let cart of this.cartlist){
                sum += cart.price*cart.num;
            }
            return sum.toFixed(2);
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
        
        clearCart:function(){
            this.cartlist = [];
            Toast.success("购物车已经清空");
            this.closeCart();
        },
        
        queryProductList: function (type) {
            let params = {};
            params.type = type;
            if(type){
                this.activeNav = type;
            }
            
            params.typeid = type;
            params.shopid = this.selectShop;
            
            axios.post(UrlHelper.createShortUrl('loadProduct'), params)
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
            if(this.cartlist.length <= 0){
                this.$message.error("购物车为空");
                return;
            }
            this.$refs.payPopup.showPopup();
        },

        hidePayMethod: function(){
            this.$refs.payPopup.closePopup();
        },

        findMemberCard:function(id){

            for(let item of this.cardList){
                if(item.id == id){
                    return item;
                }
            }

        },

        userMemberCard:function(id){

            for(let i = 0;i<this.cardList.length;i++){
                if(this.cardList[i].id == id){
                    this.cardList.splice(i);
                    return;
                }
            }

        },

        createOrder:function(){
            
            if(this.cartlist.length <= 0){
                this.$message.error("购物车为空");
                return;
            }
                
            var url = UrlHelper.createShortUrl("createOrder");
            // var params = Store.createParams();
            let params = {};

            params.shopid = this.shopid;
            params.address = this.payModel.seat;
            params.remark = this.remark;
            params.membercardid = this.cardId;
            params.productlist = JSON.stringify(this.cartlist);
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            console.log("create order ok");
                            //Toast.success("下单成功");

                            this.userMemberCard(this.cardId);

                            this.payinfo = res.obj;
                            this.hidePayMethod();
                            this.callpay();
                            
                            this.cartlist = [];

                            this.cardId = null;

                        }
                        else{
                            Toast.error(res.msg);
                        }
                    });
            
        },
         
        callpay:function() {
            if (typeof WeixinJSBridge == "undefined") {
                if (document.addEventListener) {
                    document.addEventListener('WeixinJSBridgeReady', this.jsApiCall, false);
                } else if (document.attachEvent) {
                    document.attachEvent('WeixinJSBridgeReady', this.jsApiCall);
                    document.attachEvent('onWeixinJSBridgeReady', this.jsApiCall);
                }
            } else {
                this.jsApiCall();
            }
        },
         
        jsApiCall:function () {
            WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId": this.payinfo.appId,
                    "timeStamp": this.payinfo.timeStamp,
                    "nonceStr": this.payinfo.nonceStr,
                    "package": this.payinfo.package,
                    "signType": this.payinfo.signType,
                    "paySign": this.payinfo.paySign
                },
                function(res) {
                    WeixinJSBridge.log(res.err_msg);
                }
            );
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
            this.$refs.qrcodePopup.hide();
        },
        showCombo:function(){
            this.$refs.comboPopup.show();
        }
    }
}); 
</script>


