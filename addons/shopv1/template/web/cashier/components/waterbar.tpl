<script type="text/x-template" id="waterbar">
{literal}
    <div class="waterbar-content">
        <el-button-group class="btn-nav-group">
            <el-radio-group v-model="firstPaneShow" size="small">
                <el-radio-button label="sale">商品销售</el-radio-button>
                <el-radio-button label="material">原料管理</el-radio-button>
            </el-radio-group>
        </el-button-group>
        <div class="sub-pane sale" v-if="firstPaneShow == 'sale'">
            <el-row :gutter="15">
                <el-col :span="4" class="sale-list">
                    <div class="list-title">商品分类</div>
                    <div class="list-wrap">
                        <el-scrollbar>
                            <ul>
                                <li v-for="item of typelist" :class="{active: item.id == activeNav}"
                                    @click="queryProductList(item.id)">{{item.typename}}</li>
                            </ul>
                        </el-scrollbar>
                    </div>
                </el-col>
                <el-col :span="14" class="sale-product">
                    <div class="product-title">商品列表
                        <el-button type="primary" size="mini" @click="openCash" plain>打开钱箱</el-button>
                    </div>
                    <el-row class="product-wrap">
                        <el-col :sm="8" :md="6" class="product-item" v-for="product in productlist" :class="{'less-item':product.inventory <= 0}">
                            <div v-on:click='addCart(product.id,product.productname,product.memberprice,product.inventory,product.make,product.typeid)'>
                                <h5>{{product.productname}}</h5>
                                <p class="lack-pro"></p>
                                <p class="pro-price">
                                    <span v-if="product.inventory < 0" class="pro_lesspro">
                                        <span class="icon iconfont">&#xe63f;</span>无库存
                                    </span>
                                    <!-- <span class="origin">￥100</span>
                                    <br> -->
                                    ￥{{product.memberprice/100}}
                                </p>
                            </div>
                        </el-col>
                    </el-row>
                </el-col>
                <el-col :span="6" class="sale-cart">
                    <div class="cart-title" v-if="cartMain">购物车
                        <el-button type="success" size="mini" plain v-if="editBtnShow" @click="editBtnShow = false">编辑</el-button>
                        <el-button type="success" size="mini" plain v-if="editBtnShow">优惠方案</el-button>
                        <el-button type="danger" size="mini" plain v-if="!editBtnShow" @click="editBtnShow = true">关闭</el-button>
                        <el-button type="danger" size="mini" plain v-if="!editBtnShow" @click="clearCart">清除</el-button>
                    </div>
                    <div class="checkout-title" v-if="!cartMain">
                        <el-button size="mini" class="checkout-back"><span class="icon iconfont back">&#xe603;</span>
                        </el-button>
                        <div class="checkout-title">结账</div>
                    </div>
                    <div class="cart-wrap">
                        <div class="cart-main" v-if="orderState == -1">
                            <div class="cart-list">
                                <div class="cart-item" v-for="cart in cartlist">
                                    <div class="cart-item-title">{{cart.productname}}
                                    </div>
                                    <el-row class="cart-item-num">
                                        <el-col :span="8">￥{{cart.price}}</el-col>
                                        <el-col :span="10" :offset="6" class="num-cal">
                                            <span @click="cartDeduct(cart.productid)" class="num-operate minus">-</span>
                                            {{cart.num}}
                                            <span @click='cartAdd(cart.productid)' class="num-operate add">+</span>
                                        </el-col>
                                    </el-row>
                                </div>
                            </div>
                            <div class="pay-info">
                                <el-row class="pay-num">
                                    <el-col :span="24">
                                        <el-form>
                                            <el-form-item label="座位/牌号:" label-width="80px">
                                                <el-input size="mini" v-model='address'></el-input>
                                            </el-form-item>
                                        </el-form>
                                    </el-col>
                                </el-row>
                                <el-row class="pay-sum">
                                    <el-col :span="24">合计：{{getCartSum()}} 元</el-col>
                                </el-row>
                                <el-row class="pay-ways">
                                    <el-col @click.native="createOrder(0)" :span="6" class="cashpay">
                                        <iconfont>&#xe6d1;</iconfont> 现金
                                    </el-col>
                                    <el-col @click.native="createOrder(1)" :span="6" class="weipay">
                                        <iconfont>&#xe669;</iconfont> 微信
                                    </el-col>
                                    <el-col @click.native="createOrder(2)" :span="6" class="alipay">
                                        <iconfont>&#xe666;</iconfont> 支付宝
                                    </el-col>
                                    <el-col @click.native="waitScan()" :span="6" class="alipay">
                                        <iconfont>&#xe666;</iconfont> 扫码
                                    </el-col>
                                </el-row>
                            </div>
                        </div>
                        <div class="cart-qrcode" v-if="orderState == 0">
                            <p class="order-id">{{orderid}}</p>
                            <qrcode :value="qrcodeurl"></qrcode>
                            <p class="tips">若扫码未自动跳转，请确认付款后，点击确认支付！</p>
                            <el-button type="primary" @click="confirmOrder" plain class="confirm-btn">确认支付</el-button>
                        </div>
                        <div class="cart-checkout" v-if="orderState == 1">
                            <div class="check-icon">
                                <span class="el-icon-success"></span>
                            </div>
                            <p class="checkout-text">订单支付成功！</p>
                            <div class="checkout-money">订单金额：<span>￥{{orderPrice}}</span></div>
                            <el-button type="primary" plain @click="orderState = -1" class="confirm-btn">返回购物车</el-button>
                        </div>
                        <div class="cart-qrcode" v-if="orderState == 5">
                            <p class="order-id">{{orderid}}</p>
                            <p class="tips">等待扫码！</p>
                            <el-button type="primary" @click="confirmOrder" plain class="confirm-btn">确认支付</el-button>
                        </div>
                    </div>
                </el-col>
            </el-row>

            <el-dialog title="商品属性" visible width="30%" class="attribute-modal" v-if='false' center>
                <el-form label-width="90px">
                    <el-form-item label="商品名称："></el-form-item>
                    <el-form-item label="价格："></el-form-item>
                    <el-form-item label="商品属性：">
                        <el-radio-group v-model="attribute" size="small">
                            <el-radio label="1" border>备选项1</el-radio>
                            <el-radio label="2" border>备选项2</el-radio>
                            <el-radio label="1" border>备选项1</el-radio>
                            <el-radio label="2" border>备选项2</el-radio>
                        </el-radio-group>
                    </el-form-item>
                </el-form>
            </el-dialog>
        </div>
        <div class="sub-pane material" v-else>
            <div class="material-title">吧台库</div>
            <div class="material-table">
                <el-table height="100%" border>
                    <el-table-column label="编号"></el-table-column>
                    <el-table-column label="类型"></el-table-column>
                </el-table>
            </div>
        </div>
    </div>
{/literal}
</script>


<script>
Vue.component('waterbar', {
    name: 'waterbar',
    template: '#waterbar',
    data() {
        return {
            firstPaneShow: 'sale',
            editBtnShow: true,
            orderState : -1,
            orderPrice:0,
            activeNav: 0,
            typelist: [],
            productlist: [],
            cartlist: [],
            defaulttypeid:0,
            orderid:"12365",
            attribute: '1' ,
            address:'',
            qrcodeurl:'',
            cartMain: true,
        };
    },
    created: function () {
        this.queryTypeList();
        
        setInterval(()=>{
                this.queryOrderState();
                },2000);
        
        //this.queryProductList(this.defaulttypeid);
    },
    methods: {
        
        open:function(){
                
        },

        waitScan:function(){
            this.createOrder(3);
        },
        
        createOrder:function(paytype){
            
            if(this.cartlist.length <= 0){
                Toast.error("购物车为空");
                return ;
            }
            
            this.orderPrice = this.getCartSum();
            
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
                            this.$message.success("下单成功");
                            this.orderid = res.obj.orderid;
                            if(paytype == 0){
                                this.orderState = 1;
                                
                            }
                            else if(paytype == 1 || paytype == 2){
                                this.orderState = 0;
                                this.qrcodeurl = res.obj.payurl;
                                
                                
                                let title = "请使用微信扫码";
                                
                                if(paytype == 2){
                                    title = "请使用支付宝扫码";
                                }
                                
                                Store.showQrcode(title,this.qrcodeurl);
                                
                            }
                            else if(paytype == 3){
                                //等待扫码
                                //this.$message.success("请用户扫付款码");
                                this.orderState = 5;
                                Store.showQrcode("请会员出示付款二维码","");
                            }
                            
                            this.cartlist = [];
                            
                        }
                        else{
                            this.$message.error(res.msg);
                        }
                        });
            
        },
        
        confirmOrder:function(){
            this.orderState = -1;
            Store.hideQrcode();
            this.cartlist = [];
        },

        clearCart: function(){
            this.cartlist = [];
        },
        
        
        queryOrderState:function(){
            
            if(this.orderState != 0){
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
                            Store.hideQrcode();
                            this.$message.success("订单已经支付");
                            this.orderState = 1;
                        }
                    }
                });
        },
        
        
        cartAdd:function(productid){
            
            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == productid) {
                    this.cartlist[i].num += 1;
                    this.cartlist[i].price += this.cartlist[i].price;
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
        
        addCart: function (productid, productname, price,inventory,make,typeid) {

            if(this.orderState != -1){
                this.orderState = -1;
                Store.hideQrcode();
            }
                
            this.editBtnShow = true;

            if(inventory <= 0){
                this.$message.error("库存不足,请进货或者调货");
                return;
            }

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
            cart.make = make;
            cart.typeid = typeid;
            this.cartlist.push(cart);
        },
        
        getCartSum:function(){
            let sum = 0;
            for(let cart of this.cartlist){
                sum += cart.price;
            }
            return sum.toFixed(2);
        },

        queryTypeList: function () {
            var params = Store.createParams();
            //params.shopid = typeid;
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
                
        
        scanCode:function(code){
            
            if(this.orderState == 5){
                this.scanPay(code);
            }
            else{
                this.queryProductByCode(code);
            }
        },
        
        scanPay:function(code){
            
            let params = Store.createParams();
            params.code = code;
            params.orderid = this.orderid;
            
            axios.post(UrlHelper.createUrl('order','scanPay'),params)
                    .then((res)=>{
                        
                        res = res.data;
                        if(res.state == 0){
                            this.$message.success("支付成功");
                            this.orderState = -1;
                        }
                        else{
                            this.$message.error("支付失败");
                        
                        }}
                            );
            
        },
                
                
        queryProductByCode:function(productcode){
            
            
            if(this.orderState == 5){
                this.scanPay(productcode);
                return;
            }
            
            let params = Store.createParams();
            params.code = productcode;
            
            axios.post(UrlHelper.createUrl('product','queryProductByCode'),params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            let product = res.obj;
                            this.addCart(product.id,product.productname,product.memberprice,product.inventory,product.make,product.typeid);
                            
                        }
                        else{
                            this.$message.error("商品不存在");
                        }
                    });
            
        },
        
        openCash:function(){
            cashier.openCashBox();
        },
        
        info:function(){
        }
    }
});
</script>