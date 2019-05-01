<script type="text/x-template" id="waterbar">
    {literal}
    <div class="waterbar">
        <header class="header">
            <i class="cubeic-back"></i>
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
                <cube-scroll 
                    ref="scroll"
                    :data="productlist"
                    :options="pullOptions"
                    @pulling-down="refresh"
                    @pulling-up="loadMore">
                    <ul class="foods-wrapper">
                        <li class="food-item" v-for="o in productlist">
                            <div class="icon"><img src="http://placehold.it/57x57">
                            </div>
                            <div class="food-content">
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
            <cube-toolbar :actions="cartItem"></cube-toolbar>
            <cube-popup type="my-popup" position="bottom" :mask-closable="true" ref="cartPopup"><div>123<span>456</span></div></cube-popup>
        </div>
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
        }
    }
}); 
</script>

{/literal}