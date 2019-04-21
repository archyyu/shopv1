<script type="text/x-template" id="order">
    {literal}
        <div class="order">
            <el-row :gutter="15">
                <el-col :span="7">
                    <div class="list-title">流水号（网络订单）<span>总额</span></div>
                    <div class="order-list">
                        <el-scrollbar style="height:100%">
                            <ul>
                                <li v-for="order of orderlist" @click='selectOrder(order.id)'>
                                    <el-row class="order-list-item">
                                        <el-col :span="14" class="order-num">
                                            <p>{{order.id}}</p>
                                            <p>编号：A001</p>
                                        </el-col>
                                        <el-col :span="10" class="order-price">
                                            <p>{{order.orderprice/100}}</p>
                                            <p>{{order.createtime}}</p>
                                        </el-col>
                                    </el-row>
                                </li>
                            </ul>
                        </el-scrollbar>
                    </div>
                </el-col>
                <el-col :span="17" class="order-detail">
                    <el-table height="calc(100% - 140px)" border>
                        <el-table-column label="商品名"></el-table-column>
                        <el-table-column label="原价"></el-table-column>
                        <el-table-column label="折扣"></el-table-column>
                        <el-table-column label="优惠金额"></el-table-column>
                        <el-table-column label="出售价"></el-table-column>
                        <el-table-column label="数量"></el-table-column>
                    </el-table>
                    <el-row>
                        <el-col :span="6">
                            <p>数量：{{ }}</p>
                            <p>会员：{{ }}</p>
                            <p>地址：{{order.address }}</p>
                        </el-col>
                        <el-col :span="6">
                            <p>总金额：{{order.orderprice/100 }}</p>
                            <p>订单状态：{{order.orderstate }}</p>
                            <p>积分抵现：{{0 }}</p>
                        </el-col>
                        <el-col :span="6">
                            <p>订单来源：<el-tag size="small">收银端</el-tag></p>
                        </el-col>
                        <el-col :span="6">
                            <el-button type="primary" class="print-btn">再次打印</el-button>
                        </el-col>
                    </el-row>
                </el-col>
            </el-row>
        </div>
    {/literal}
</script>

<script>
Vue.component('order', {
    name: 'order',
    template: '#order',
    data() {
        return {
            orderlist:[],
            order:{},
        };
    },
    mounted(){
        this.queryOrderList();
    },
    methods:{
        queryOrderList:function(){
            var url = UrlHelper.createUrl('order','cashierQueryOrder');
            
            var params = Store.createParams();
            axios.post(url,params)
                    .then((res)=>{
                        var res = res.data;
                        if(res.state == 0){
                            this.orderlist = res.obj;
                            console.log(res.obj);
                            this.order = this.orderlist[0];
                        }
                        else{
                            //this.$message.error(res.msg);
                        }
                });
            
        },
        selectOrder:function(id)){
            for(let item in this.orderlist){
                if(item.id == id){
                    this.order = item;
                    break;
                }
            }
        }
    }
});
</script>