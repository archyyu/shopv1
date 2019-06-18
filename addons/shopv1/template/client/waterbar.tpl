{include file="./common/header.tpl"}
<div id="app" oncontextmenu="self.event.returnValue=false">
    {literal}
    <div class="water_content">
        <div class="class">
            <div class="logo">LOGO</div>
            <div class="class_nav">
                <el-scrollbar>
                    <ul class="nav">
                        <li v-for="item of typelist" :class="{active: item.id == activeNav}"
                            @click="queryProductList(item.id)">{{item.typename}}</li>
                    </ul>
                </el-scrollbar>
            </div>
        </div>
        <div class="content">
            <div class="banner">
                {/literal}
                <img src="{$StaticRoot}/img/client/water_banner.png">
                {literal}
            </div>
            <div class="product">
                <el-scrollbar>
                    <div class="product-item" v-for="o in productlist">
                        <div class="pro_img" @click="addCart(o)"> <img v-lazy="getImgUrl(o)"> </div>
                        <div class="pro_title">
                            <p title="西瓜汁">{{o.productname}}
                                <span><em> 售价:￥{{o.normalprice/100}} </em></span>
                                <span><em> 会员价:￥{{o.memberprice/100}} </em></span>
                            </p>
                        </div>
                    </div>
                </el-scrollbar>
            </div>
        </div>
        <div class="checkout">
            <div class="water_info">
                <div id="memberInfo">
                    <div class="water_avatar"><img id="headImgUrl" src="http://placehold.it/60x60"></div>
                    <div class="balance">
                        <p></p>
                    </div>
                </div>

            </div>
            <div class="checkout_content">
                <el-scrollbar>
                    <div class="cart-item" v-for="item in cartlist">
                        <div class="checkout_text">
                            <div class="checkout_name">
                                <p>{{item.productname}}</p>
                                <div class="product_num">
                                    <p>
                                        <el-button type="text" @click="cartDeduct(item.productid)">&lt;</el-button>
                                        <span>{{item.num}}</span>
                                        <el-button type="text" @click="cartAdd(item.productid)">&gt;</el-button>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="delete_list">
                            <el-button type="text" @click="cartClear(item.productid)"><span class="el-icon-close"></span></el-button>
                        </div>
                    </div>
                </el-scrollbar>
            </div>
            <div class="submit">
                <p>正常价：<span id="totalPrice">{{getCartPrice()}}</span>元</p>
                <el-button type="warning" size="mini" round @click="confirmOrderShow = true">下一步</el-button>
            </div>
        </div>
    </div>
    <el-dialog
        title="确认订单"
        :visible.sync="confirmOrderShow"
        width="530px"
        custom-class="confirm-order"
        :close-on-click-modal="false"
        center>
        <div class="pro_list">
            <div class="order_number">
                <p>应支付：￥{{getCartPrice()}}</p>
            </div>
            <div class="order_list">
                <el-scrollbar>
                    <div class="order_item" v-for="item in 20">
                        <img src="http://placehold.it/80x80">
                        <p>￥8</p>
                        <div class="pro_number cartNum">1</div>
                    </div>
                </el-scrollbar>
            </div>
        </div>
        <div class="remark">
            <span>选择卡券：</span>
            <el-select v-model="cardId" placeholder="">
              <el-option v-for="item in cardlist"
                :label="item.cardname"
                :value="item.id"></el-option>
            </el-select>
        </div>
        <div class="remark">
            <span>填写备注：</span>
            <el-input v-model="remark" label="填写备注："></el-input>
        </div>
        <!-- <div class="socer">
            <p>积分抵现</p>
            <div>
                <el-checkbox v-model="useSocer">￥0.00</el-checkbox>
            </div>
        </div> -->
        <div class="real_pay">
            <p>扫码支付</p>
            <p class="real_money">￥{{getCartPrice()}}</p>
        </div>
        <div class="real_pay">
            <p>会员支付</p>
            <p class="real_money">￥{{getCartMemberPrice()}}</p>
        </div>
        <span slot="footer" class="dialog-footer">

            <el-button class="btn weipay" @click="showPassword"><span class="iconfont">&#xe66d;</span>会员支付</el-button>
            <el-button class="btn weipay" @click="createOrder(1)"><span class="iconfont">&#xe66d;</span>微信支付</el-button>
            <el-button class="btn alipay" @click="createOrder(2)"><span class="iconfont">&#xe938;</span>支付宝支付</el-button>
            <el-button class="btn weipay" @click="showPassword"><span class="iconfont">&#xe648;</span>余额支付</el-button>
            <el-button class="btn weipay" @click="createOrder(1)"><span class="iconfont">&#xe669;</span>微信支付</el-button>
            <el-button class="btn alipay" @click="createOrder(2)"><span class="iconfont">&#xe666;</span>支付宝支付</el-button>

        </span>
         <el-dialog
            width="260px"
            :title="title"
            custom-class="qrcode-dialog"
            :visible.sync="showQrcode"
            append-to-body
            center>
            <qrcode :value="qrcodeurl" :options="{ width: 150 }"></qrcode>
            <p>点单号：{{orderId}}</p>
            </el-dialog>
        </el-dialog
    </el-dialog>
    {/literal}
</div>


<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>
<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>
<script src="{$StaticRoot}/js/client/clientStore.js"></script>

{literal}
<script>
Vue.component(VueQrcode.name, VueQrcode);
var app = new Vue({
    el: '#app',
    data: function(){
        return {
            memberName: 'name',
            memberid:0,
            activeNav: 1,
            address:'',
            typelist: [],
            productlist: [],
            cardlist:[],
            cartlist: [],
            defaulttypeid:0,
            orderState:-1,
            orderId:'',
            qrcodeurl:"",
            title:"请使用微信扫码",
            confirmOrderShow: false,
            showQrcode: false,
            remark: '',
            useSocer: '',
            cardId: ''
        };
    },
    computed: {
        popoverTitle: function(){
            return `亲爱的会员${this.memberName}`;
        }
    },
    created: function () {
        
        this.memberid = UrlHelper.getQueryString("memberid");
        this.address = UrlHelper.getQueryString("address");
        this.queryMemberCardList();
        this.queryTypeList();
        setInterval(()=>{
                this.queryOrderState();
                },2000);
    },
    methods: {
        
        queryMemberCardList:function(){
            
            let params = ClientStore.createParams();
            
            if(this.memberid == 0){
                return ;
            }
            
            params.memberid = this.memberid;
            let url = UrlHelper.createUrl("member","getMemberCardList");
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            this.cardlist = res.obj;
                        }
                        else{
                            console.log("no card at all");
                        }
                    });
            
        },
        
        queryTypeList: function () {
            var params = ClientStore.createParams();
            axios.post(UrlHelper.createUrl('product','loadProductTypeList'), params)
                .then((res) => {
                    console.log(res);
                    res = res.data;
                    if (res.state == 0) {
                        this.typelist = res.obj;
                        this.defaulttypeid = this.typelist[0].id;
                        this.activeNav = res.obj[0].id;
                        this.queryProductList(this.defaulttypeid);
                    }
                });
        },
        
       getImgUrl:function(p){
            return UrlHelper.getWebBaseUrl() + p.productimg;
        },
        queryOrderState:function(){
            
            if(this.orderState != 0){
                return;
            }
            
            if(this.showQrcode == false){
                return;
            }
            
            var params = ClientStore.createParams();
            params.orderid = this.orderId;
            var url = UrlHelper.createUrl("order","queryOrderState");
            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    console.log(res);
                    if(res.state == 0){
                        if(res.obj >= 0){
                            this.showQrcode = false;
                            this.$message.success("订单已经支付");
                            this.orderState = 1;
                        }
                    }
                });
        },
        createOrder:function(paytype, password = ''){
            if(this.cartlist.length <= 0){
                Toast.error("购物车为空");
                return ;
            }
            
            this.orderPrice = this.getCartPrice();
            
            var url = UrlHelper.createUrl('order','createOrder');
            var params = ClientStore.createParams();
            params.address = this.address;
            params.paytype = paytype;
            params.memberid = this.memberid;
            params.address = this.address;
            params.remark = this.remark;

            if(paytype == 5){

                for (var i = 0; i < this.cartlist.length; i++) {
                     this.cartlist[i].price = this.cardlist[i].memberprice;
                }

            }

            params.productlist = JSON.stringify(this.cartlist);
            params.membercardid = this.cardId;
            params.from = 1;
            params.password = password;
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            console.log("create order ok");

                            this.userMemberCard(this.cardId);
                            this.cardId = null;
                            this.cartlist = [];
                            this.confirmOrderShow = false;

                            this.$message.success("下单成功");

                            if (paytype == 5) {
                                return ;
                            };

                            this.orderState = 0;

                            this.orderId = res.obj.orderid;
                            this.qrcodeurl = res.obj.payurl;

                            if(paytype == 2){
                                this.title = "请使用支付宝扫码";
                            }
                            
                            this.showQrcode = true;
                            
                        }
                        else{
                            this.$message.error(res.msg);
                        }
                    });
            
        },

        showPassword: function(){
            this.$prompt('请输入密码', '确认密码', {
                inputType: 'password'
            }).then(({ value }) => {
                // 确认按钮代码
                this.createOrder(5, value);
            }).catch(() => {
                // 取消按钮代码
                
            });
        },
        
        queryProductList: function (type) {
            let params = ClientStore.createParams();
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
                        this.cartlist.splice(i,1);
                    }
                    return;
                }
            }
        },

        cartClear:function(productid){

            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == productid) {
                    this.cartlist.splice(i,1);
                    break;
                }
            }

        },

        addCart: function (p) {

            if(this.orderState != -1){
                this.orderState = -1;
            }
                
            this.editBtnShow = true;

            if(p.inventory <= 0){
                this.$message.error("库存不足,请进货或者调货");
                return;
            }
            
            this.$message.success("已添加购物车");

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
        
        findMemberCard:function(id){
            
            for(let item of this.cardlist){
                if(item.id == id){
                    return item;
                }
            }
            
        },

        userMemberCard:function(id){

            for(let i = 0;i<this.cardlist.length;i++){
                if(this.cardlist[i].id == id){
                    this.cardlist.splice(i,1);
                    return;
                }
            }

        },
        
        getCartPrice:function(){
            let sum = 0;
            let card = this.findMemberCard(this.cardId);
            
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

        getCartMemberPrice:function(){
            let sum = 0;
            let card = this.findMemberCard(this.cardId);

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

                sum += cart.memberprice*cart.num*(discount/100);
            }
            if(card){
                sum -= card.exchange/100;
            }
            return sum.toFixed(2);
        },

        info:function(){
            
        }
    }
});
</script>
{/literal}
{include file="./common/footer.tpl"}