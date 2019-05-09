{include file="./common/header.tpl"}

<div id="app">
        {literal}
    <div class="water_content">
        <div class="class">
            <div class="logo"><img src="http://placehold.it/100x66"></div>
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
                    <div class="product-item" v-for="product in 10">
                        <div class="pro_img"> <img src="http://placehold.it/116x116"> </div>
                        <div class="pro_title">
                            <p title="西瓜汁">西瓜汁<span><em> ￥0.01 </em></span></p>
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
                    <div class="cart-item" v-for="cart in 10">
                        <div class="checkout_img">
                            <img src="http://placehold.it/65x65">
                        </div>
                        <div class="checkout_text">
                            <div class="checkout_name">
                                <p>精品双人餐</p>
                                <div class="product_num">
                                    <p> <button class="btn btn-sm btn-link btn-text"
                                            onclick="Product.removeProductFromCartByOne(9607,'精品双人餐')">&lt;</button>
                                        <em>1</em> <button class="btn btn-sm btn-link btn-text"
                                            onclick="Product.addProductToCartByOne(9607,'精品双人餐')">&gt;</button> </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </el-scrollbar>
                <!-- <div class="meal_tips" id="mealTips" style="display:none;">
                    <p>您有1个订单正在路上...</p>
                    <button class="btn btn-xs btn-link btn-text">查看订单</button>
                </div> -->
            </div>
            <div class="submit">
                <p>总价：<span id="totalPrice">0</span>元</p>
                <el-button type="primary" size="mini" round>下一步</el-button>
            </div>
        </div>
    </div>
    {/literal}
</div>

<script src="{$StaticRoot}/js/cashier/urlHelper.js"></script>
<script src="{$StaticRoot}/js/cashier/dateUtil.js"></script>
<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>

{literal}
<script>
Vue.component(VueQrcode.name, VueQrcode);
var app = new Vue({
    el: '#app',
    data: function(){
        return {
            memberName: 'name',
            activeNav: 1,
            typelist: [{
                    "id": "1",
                    "typename": "测试分类2",
                    "uniacid": "1",
                    "pos": "0",
                    "deleteflag": "0",
                    "visible": "0"
                }, {
                    "id": "2",
                    "typename": "测试分类4",
                    "uniacid": "1",
                    "pos": "3",
                    "deleteflag": "0",
                    "visible": "0"
                }, {
                    "id": "3",
                    "typename": "测试4",
                    "uniacid": "1",
                    "pos": "0",
                    "deleteflag": "0",
                    "visible": "0"
                }, {
                    "id": "4",
                    "typename": "坚果类1",
                    "uniacid": "1",
                    "pos": "0",
                    "deleteflag": "0",
                    "visible": "0"
                }],
            productlist: [],
            cartlist: [],
            defaulttypeid:0,
        }
    },
    computed: {
        popoverTitle: function(){
            return `亲爱的会员${this.memberName}`
        }
    },
    created: function () {
        this.queryTypeList();
    },
    methods: {
        queryTypeList: function () {
            // var params = Store.createParams();
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
            // let params = Store.createParams();
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
    }
});
</script>
{/literal}
{include file="./common/footer.tpl"}