{include file="./common/header.tpl"}

<div id="app">
    {literal}
    <div class="water_content">
        <div class="class">
            <div class="logo"></div>
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
                        <div class="pro_img" @click="addCart(o.id,o.productname,o.memberprice,o.inventory)"> <img :src="getImgUrl(o)"> </div>
                        <div class="pro_title">
                            <p title="西瓜汁">{{o.productname}}<span><em> ￥{{o.memberprice/100}} </em></span></p>
                        </div>
                    </div>
                </el-scrollbar>
            </div>
        </div>
        <div class="checkout">
            <div class="water_info">
                <div id="memberInfo" v-popover:popover1>
                    <div class="water_avatar"><img id="headImgUrl" src="http://placehold.it/60x60"></div>
                    <div class="balance">
                        <p>
                           
                        </p>
                    </div>
                </div>
                <el-popover
                ref="popover1"
                placement="left-start"
                :title="popoverTitle"
                width="200"
                trigger="hover">
                <div class="user_detail">
                    <div class="user_class">
                        <p></p>
                        <p></p>
                    </div>
                    <p>积分：0</p>
                    <div class="user_coupon">
                        <p>兑换券：0张</p>
                        <el-button type="info" size="mini" plain>查看兑换</el-button>
                    </div>
                </div>
              </el-popover>
            </div>
            <div class="checkout_content">
                <el-scrollbar>
                    <div class="cart-item" v-for="item in cartlist">
                        <div class="checkout_text">
                            <div class="checkout_name">
                                <p>{{item.productname}}</p>
                                <div class="product_num">
                                    <p>
                                        <el-button type="text" @click="{{item.num>0?item.num--:0}}">&lt;</el-button>
                                        <span>{{item.num}}</span>
                                        <el-button type="text" @click="{{item.num++}}">&gt;</el-button>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </el-scrollbar>
            </div>
            <div class="submit">
                <p>总价：<span id="totalPrice">{{getCartPrice()}}</span>元</p>
                <el-button type="primary" size="mini" round>下一步</el-button>
            </div>
        </div>
    </div>
    {/literal}
</div>

<script src="{$StaticRoot}/js/cashier/urlHelper.js"></script>
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
            activeNav: 1,
            typelist: [],
            productlist: [],
            cartlist: [],
            defaulttypeid:0
        };
    },
    computed: {
        popoverTitle: function(){
            return `亲爱的会员${this.memberName}`;
        }
    },
    created: function () {
        this.queryTypeList();
    },
    methods: {
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
        
        addCart: function (productid, productname, price,inventory) {

            if(this.orderState != -1){
                this.orderState = -1;
            }
                
            this.editBtnShow = true;

            if(inventory <= 0){
                this.$message.error("库存不足,请进货或者调货");
                return;
            }
            
            this.$message.success("已添加购物车");

            for (var i = 0; i < this.cartlist.length; i++) {
                if (this.cartlist[i].productid == productid) {
                    this.cartlist[i].num += 1;
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
                sum += cart.price*cart.num;
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