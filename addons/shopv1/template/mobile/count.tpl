{include file="./common/header.tpl"}

<div id="app">
    {literal}
    <div class="page-wrap count">
        <header class="header">
            <i class="cubeic-back"></i>
            <div class="title">
                <span>盘点</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="count-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>商品名称</th>
                                <th>系统库存</th>
                                <th>货架库存</th>
                                <th>损益</th>
                                <th>数量</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="material in productInventory">
                                <td>{{material.productname}}</td>
                                <td>{{material.inventory}}</td>
                                <td>
                                    <cube-input v-model='material.actualinventory'></cube-input>
                                </td>
                                <td>{{material.actualinventory - material.inventory > 0 ?'报溢':'报损' }}</td>
                                <td>{{material.actualinventory - material.inventory}}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <cube-button :primary="true" @click='check'>确 定</cube-button>
            </cube-scroll>
        </div>
    </div>
    {/literal}
</div>
<script src="{$StaticRoot}/js/mobile/store.js"></script>
<script src="{$StaticRoot}/js/mobile/urlHelper.js"></script>

<script>
    var app = new Vue({
        el: "#app",
        data: {
            
            productInventory:[]
            
        },
        created() {},
        mounted() {
            this.queryProductInventory();
        },
        methods: {
            queryProductInventory:function(){
                let params = Store.createParams();
                let url = UrlHelper.createUrl("product","loadProductInventory");
                
                axios.post(url,params)
                        .then((res)=>{
                            res = res.data;
                            if(res.state == 0){
                                this.productInventory = res.obj;
                            }
                            else{
                                this.$message.error(res.msg);
                            }
                        });
                
            },
            check:function(){
                
                let params = Store.createParams();
                params.data = JSON.stringify(this.productInventory);
                console.log(params.data);
                let url = UrlHelper.createUrl("product","check");
                
                axios.post(url,params)
                        .then((res)=>{
                            res = res.data;
                            console.log(res);
                            if(res.state == 0){
                                this.$message.success("盘点成功");
                                this.queryProductInventory();
                            }
                            else{
                                this.$message.error(res.msg);
                            }
                        });
            
            },
            info:function(){
                
            }
        }
    });
</script>
{include file="./common/footer.tpl"}