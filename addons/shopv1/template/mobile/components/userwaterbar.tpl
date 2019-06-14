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
                <cube-scroll-nav-bar
                    direction="vertical"
                    :current="defaulttypeid"
                    :labels="navListId"
                    :txts="navListStr"
                    @change="changeHandler">
                    <!-- <i slot-scope="props">{{props.txt.typename}}</i> -->
                </cube-scroll-nav-bar>
            </div>
            <div class="product-container">
                <cube-scroll ref="scroll" :data="productlist" :options="pullOptions" @pulling-down="refresh"
                    @pulling-up="loadMore">
                    <ul class="foods-wrapper">
                        <li class="food-item" v-for="o in productlist">
                            <div class="icon"><img v-lazy="getImgUrl(o)">
                            </div>
                            <div class="food-content" @click="productclick(o)">
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
                                        <cube-button  :inline="true" :outline="true" @click="cartDeduct(item.productid)">-</cube-button>
                                        <span>{{item.num}}</span>
                                        <cube-button  :inline="true" :outline="true" @click="cartAdd(item.productid)">+</cube-button>
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
                        <qrcode value="www.baidu.com"></qrcode>
                    </div>
                </div>
            </cube-popup>

            <bottom-popup label="payMethod" title="支付选项" height="auto" cubeclass="pay-popup" ref="payPopup">
                <template v-slot:content>
                    <cube-form :model="payModel">
                        <cube-form-item :field="payFields[0]">
                            <cube-input v-model="payModel.seat" @blur="resize"></cube-input>
                        </cube-form-item>
                        <cube-form-item :field="payFields[1]"></cube-form-item>
                        <cube-form-item :field="payFields[2]"></cube-form-item>
                    </cube-form>
                </template>
                <template v-slot:footer>
                    <cube-button :inline="true" @click="createOrderEx()">确认下单</cube-button>
                </template>
            </bottom-popup>

            <bottom-popup label="combo" title="套餐详情" height="auto" cubeclass="combo-popup"  ref="comboPopup">
                <template v-slot:content>
                    <h4>套餐名称：{{selectProduct.productname}}</h4>
                    <p>套餐详情：</p>
                    <ul>
                        <li v-for="item of selectProduct.productlink">{{item.materialname}}<span> ({{item.num}} 份)</span></li>
                    </ul>
                </template>
                <template v-slot:footer>
                    <cube-button :inline="true" @click="addCart(selectProduct)">加入购物车</cube-button>
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
            defaulttypeid: 0,
            navList: [],
            productlist:[],
            selectProduct:{ },
            cartlist:[],
            orderState:-1,
            cardList: [],
            orderpaytype:"微信",
            payinfo:{ },
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
                card: '',
                payWays: 2,
            },
            payFields: [
                {
                    type: 'input',
                    modelKey: 'seat',
                    label: '座位号',
                },
                {
                    type: 'select',
                    modelKey: 'card',
                    label: '卡券',
                    props: {
                        options: this.cardList,
                        title: '请选择卡券'
                    }
                },
                {
                    type: 'select',
                    modelKey: 'payWays',
                    label: '支付方式',
                    props: {
                        options: [
                            {
                                text: '微信支付',
                                value: 1
                            },
                            {
                                text: '钱包支付',
                                value: 5
                            }
                        ],
                        title: '请选择卡券'
                    }
                }
            ]
        };
    },
    watch: {
        cardList: function(newV){
            console.log(newV);
            this.payFields[1].props.options = newV;
        }
    },
    computed: {
        navListId: function(){
            let navId = [];
            let list = this.navList;
            for(let i=0;i<list.length;i++){
                navId.push(list[i].id);
            }
            return navId;
        },
        navListStr: function(){
            let navStr = [];
            let list = this.navList;
            for(let i=0;i<list.length;i++){
                navStr.push(list[i].typename);
            }
            return navStr;
        }
    },
    created:function(){
        this.queryShopList();
        this.queryTypeList();
        this.queryMemberCardList();
    },
    mounted() {
        //this.$refs.shopSelect.showPicker()

    },
    methods: {

        open: function(){
        },

        resize: function(){
            this.$root.resizePage();
        },

        queryShopList:function(){
            let params = { };

            axios.post(UrlHelper.createShortUrl("loadShopList"),params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){

                        let list = res.obj;
                        for(let shop of list){
                            let item  = { };
                            item.value = shop.id;
                            item.text = shop.shopname;

                            this.shopList.push(item);
                        }

                        this.$refs.shopSelect.showPicker();

                    }
                });

        },

        queryMemberCardList:function(){

            let params = { };

            axios.post(UrlHelper.createShortUrl("getCardList"),params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        //this.cardList = res.obj;

                        for(let card of res.obj){
                            //let item = { };
                            //item.value = card.id;
                            //item.text = card.cardname;
                            card.value = card.id;
                            card.text = card.cardname;
                            this.cardList.push(card);
                        }

                    }
                });

        },

        changeHandler:function(cur){
            this.defaulttypeid = cur;
            this.queryProductList(this.defaulttypeid);
        },

        shopSelect:function(){
            this.queryProductList(this.defaulttypeid);
        },
        
        getImgUrl:function(p){
            return UrlHelper.getAppBaseUrl() + p.productimg;
        },
        
        queryTypeList: function () {
            let params = { };
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
        productclick:function(p){
            if(p.producttype == 3){
                this.selectProduct = p;
                
                if(Array.isArray(this.selectProduct.productlink)){
                }
                else{
                    this.selectProduct.productlink = JSON.parse(this.selectProduct.productlink);
                }
                
                this.showCombo();
            }
            else{
                this.addCart(p);
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

            var cart = { };
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

            let card = this.findMemberCard(this.payModel.card);

            for(let cart of this.cartlist){

                let discount = 100;
                if(card){
                    //discount = card.discount;
                    if(card.typeid && card.typeid == cart.typeid){
                        discount = card.discount;
                    }
                    if(card.productid && card.productid == cart.productid){
                        discount = card.discount;
                    }
                }

                sum += cart.price*cart.num*(discount/100);

            }

            if(card){
                sum -= card.exchange/100;
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
            let params = { };
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
                Toast.error("购物车为空");
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
                    this.cardList.splice(i,1);
                    return;
                }
            }

        },

        createOrderEx:function(){

            if(this.payModel.payWays == 1){
                this.createOrder();
            }
            else if(this.payModel.payWays == 5){
                this.showPassword();
            }

        },

        createOrder:function(password = ''){
            if(this.cartlist.length <= 0){
                Toast.error("购物车为空");
                return;
            }


                
            var url = UrlHelper.createShortUrl("createOrder");
            // var params = Store.createParams();
            let params = { };

            params.shopid = this.selectShop;
            params.address = this.payModel.seat;
            params.remark = this.remark;
            params.membercardid = this.payModel.card;

            params.password = password;
            params.paytype = this.payModel.payWays;

            //this.userMemberCard(this.payModel.card);
            //this.payModel.card = null;

            params.productlist = JSON.stringify(this.cartlist);
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            console.log("create order ok");
                            //

                            this.userMemberCard(this.payModel.card);
                            this.payModel.card = null;

                            this.payinfo = res.obj;
                            this.hidePayMethod();

                            
                            this.cartlist = [];

                            this.payModel.card = null;

                            if(this.payModel.payWays == 1) {
                                this.callpay();
                            }
                            else{
                                Toast.success("下单成功");
                            }

                        }
                        else{
                            Toast.error(res.msg);
                        }
                    });
            
        },

        showPassword: function () {
            this.passowrdPopup = this.$createDialog({
                type: 'prompt',
                title: '请输入密码',
                prompt: {
                    value: '',
                    type: 'password',
                    placeholder: '请输入密码'
                },
                onConfirm: (e, value)=>{
                    this.createOrder(value);
                }

            }).show();
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
            this.$refs.comboPopup.showPopup();
        }
    }
}); 
</script>


