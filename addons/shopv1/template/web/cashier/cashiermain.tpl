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
        },
        methods: {
            
            createUrl:function(f){
                return "index.php?__uniacid=1&shopid=1&f=" + f;
            },
            
            addCart:function(productid,productname,price){
                
                for(var i=0;i<this.waterbar.cartlist.length;i++){
                    if(this.waterbar.cartlist[i].productid == productid){
                        this.waterbar.cartlist[i].num += 1;
                        this.waterbar.cartlist[i].price += price/100;
                        return;
                    }
                }
                
                var cart = {};
                cart.productid = productid;
                cart.num = 1;
                cart.price = price/100;
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
            
            queryProductList:function(type){
                var params = {};
                params.typeid = type;
                axios.post(this.createUrl('loadProduct'),params)
                        .then((res)=>{
                            res = res.data;
                            console.log(res);
                            if(res.state == 0){
                                this.waterbar.productlist = res.obj;
                            }
                        });
            },
            createOrder:function(){
                
                var url = this.createUrl('createOrder');
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
                
            }
            
        }
    });
</script>
{include file="./common/footer.tpl"}