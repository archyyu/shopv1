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
                                <li v-for="item of typelist" :class="{active: item.id == activeNav}" @click="queryProductList(item.id)">{{item.typename}}</li>
                            </ul>
                        </el-scrollbar>
                    </div>
                </el-col>
                <el-col :span="14" class="sale-product">
                    <div class="product-title">商品列表
                        <el-button type="primary" size="mini" plain>打开钱箱</el-button>
                    </div>
                    <el-row class="product-wrap">
                        <el-col :sm="8" :md="6" class="product-item less-item" v-for="product in productlist">
                            <div v-on:click='addCart(product.id,product.productname,product.memberprice)'>
                                <h5>{{product.productname}}</h5>
                                <p class="lack-pro"></p>
                                <p class="pro-price">
                                    <!--<span class="pro_lesspro">
                                        <span class="icon iconfont">&#xe63f;</span>无库存
                                    </span> -->
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
                        <el-button type="success" size="mini" plain v-if="editBtnShow">编辑</el-button>
                        <el-button type="success" size="mini" plain v-if="editBtnShow">优惠方案</el-button>
                        <el-button type="danger" size="mini" plain v-if="!editBtnShow">关闭</el-button>
                        <el-button type="danger" size="mini" plain v-if="!editBtnShow">清除</el-button>
                    </div>
                    <div class="checkout-title" v-if="!cartMain">
                        <div class=""><a href="#"><span class="icon iconfont back">&#xe61c;</span></a></div>
                        <div class="">结账</div>
                    </div>
                    <div class="cart-wrap">
                        <div class="cart-list">
                            <div class="cart-item" v-for="cart in cartlist">
                                <div class="cart-item-title">{{cart.productname}}
                                </div>
                                <el-row class="cart-item-num">
                                    <el-col :span="8">￥{{cart.price}}</el-col>
                                    <el-col :span="10" class="num-cal">
                                        <span class="num-operate minus">-</span>
                                        {{cart.num}}
                                        <span class="num-operate add">+</span>
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
                                <el-col :span="24">合计：80 元</el-col>
                            </el-row>
                            <el-row class="pay-ways">
                                <el-col :span="8" class="cashpay" @click='createOrder(0)'><iconfont>&#xe6d1;</iconfont> 现金</el-col>
                                <el-col :span="8" class="weipay"><iconfont>&#xe669;</iconfont> 微信</el-col>
                                <el-col :span="8" class="alipay"><iconfont>&#xe666;</iconfont> 支付宝</el-col>
                            </el-row>
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
            cartMain: true,
            editBtnShow: true,
            activeNav: 0,
            typelist: [],
            productlist: [],
            cartlist: [],
            defaulttypeid:0,
            attribute: '1' ,
            address:''
        };
    },
    created: function () {
        this.queryTypeList();
        //this.queryProductList(this.defaulttypeid);
    },
    methods: {
        
        createOrder:function(){
            
            var url = UrlHelper.createUrl('product','createOrder');
            var params = {};
            
            axois.post(url,params)
                    .then((res)=>{
                        res = res.data;
                console.log(res);
                if(res.state == 0){
                    
                }
                else{
                }
        });
            
        },
        addCart: function (productid, productname, price) {

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

        queryTypeList: function (typeid) {
            var params = {};
            params.shopid = typeid;
            axios.post(UrlHelper.createUrl('product','loadProductTypeList'), params)
                .then((res) => {
                    console.log(res);
                    res = res.data;
                    if (res.state == 0) {
                        this.typelist = res.obj;
                        this.defaulttypeid = this.typelist[0].id;
                        this.activeNav = res.obj[0].id 
                    }
                });
        },

        queryProductList: function (type) {
            let params = {};
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
        
        createOrder:function(paytype){
            var url = UrlHelper.createUrl('order','createOrder');
            
            var params = Store.createParams();
            params.paytype = paytype;
            
            
            
        },
        
        info:function(){
        }
    }
});
</script>