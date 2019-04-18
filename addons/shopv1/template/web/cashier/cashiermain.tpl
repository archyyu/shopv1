{include file="./common/header.tpl"}


<div id="app">
    <el-tabs value="waterbar" type="card" @tab-click="handleClick">
    {include file="./panels/waterbar.tpl"}
    {include file="./panels/broadcast.tpl"}
    {include file="./panels/shift.tpl"}
    {include file="./panels/order.tpl"}
  </el-tabs>
</div>


<script>
    var app = new Vue({
        el: '#app',
        data: {
            waterbar: {
                firstPaneShow: 'sale',
                cartMain: true,
                editBtnShow: true,
                typelist:[],
                productlist:[],
                cartlist:[]
            },
            shift: {
                firstPaneShow: 'shiftData'
            }
        },
        created: function(){
            this.queryTypeList();
            this.queryProductList();
            // axios.get("http://api.douban.com/v2/movie/coming_soon")
            // .then(function(res) {
            //     console.log(res)
            // })
            // .catch(function(err) {
            //     console.log(err)
            // }); 
        },
        methods: {
            
            createUrl:function(f){
                return "index.php?__uniacid=1&shopid=1&f=" + f;
            },
            
            addCart:function(productid,productname){
                
                for(var i=0;i<this.waterbar.cartlist.length;i++){
                    if(this.waterbar.cartlist[i].productid == productid){
                        this.waterbar.cartlist[i].num += 1;
                        return;
                    }
                }
                
                var cart = {};
                cart.productid = productid;
                cart.num = 1;
                cart.productname = productname;
                this.waterbar.cartlist.push(cart);
            },
            
            queryTypeList:function(){
                var params = {};
                params.shopid=1;
                axios.post(this.createUrl('loadProductTypeList'),params)
                        .then((res)=>{
                            console.log(res);
                            res = res.data;
                            if(res.state == 0){
                                this.waterbar.typelist = res.obj;
                            }
                        });
            },
            
            queryProductList:function(){
                var params = {};
                params.typeid = 1;
                axios.post(this.createUrl('loadProduct'),params)
                        .then((res)=>{
                            res = res.data;
                            console.log(res);
                            if(res.state == 0){
                                this.waterbar.productlist = res.obj;
                            }
                        });
            }
            
        }
    });
</script>
{include file="./common/footer.tpl"}