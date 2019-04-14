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
                typelist:[]
            },
            shift: {
                firstPaneShow: 'shiftData'
            }
        },
        created:{
            this.queryTypeList():
        },
        methods: {
            
            queryTypeList:function(){
                console.log("queryTypelist");
            }
            
        }
    });
</script>
{include file="./common/footer.tpl"}