<script type="text/x-template" id="order">
    {literal}
        <div class="order">
            <el-row :gutter="15">
                <el-col :span="7">
                    <div class="list-title">流水号（网络订单）<span>总额</span></div>
                    <div class="order-list">
                        <el-scrollbar style="height:100%">
                            <ul>
                                <li v-for="order of orderlist" :class="{'active': order.id == activeLi}" @click='selectOrder(order.id)'>
                                    <el-row @click='selectOrder(order.id)' class="order-list-item">
                                        <el-col :span="14" class="order-num">
                                            <p>{{order.id}}</p>
                                            <p>支付方式：{{Store.paytypeToStr(order.paytype)}}</p>
                                        </el-col>   
                                        <el-col :span="10" class="order-price">
                                            <p>{{order.orderprice/100}}</p>
                                            <p>{{DateUtil.parseTime(order.createtime,"MM-DD HH:mm")}}</p>
                                        </el-col>
                                    </el-row>
                                </li>
                            </ul>
                        </el-scrollbar>
                    </div>
                </el-col>
                <el-col :span="17" class="order-detail">
                    <el-table :data='productlist' height="calc(100% - 140px)" border>
                        <el-table-column prop="productid" label="商品id"></el-table-column>
                        <el-table-column prop="productname" label="商品名"></el-table-column>
                        <el-table-column prop="price" label="出售价(元)"></el-table-column>
                        <el-table-column prop="num" label="数量"></el-table-column>
                    </el-table>
                    <el-row>
                        <el-col :span="6">
                            <p>数量：{{ getOrderProductNum() }}</p>
                            <p>会员：{{ }}</p>
                            <p>地址：{{order.address }}</p>
                        </el-col>
                        <el-col :span="6">
                            <p>总金额：{{order.orderprice/100 || 0 }}元</p>
                            <p>订单状态：{{ Store.stateToStr(order.orderstate) }}</p>
                            <p>积分抵现：{{0 }}</p>
                        </el-col>
                        <el-col :span="6">
                            <p>订单来源：<el-tag size="small">{{Store.sourceToStr(order.ordersource)}}</el-tag></p>
                            <p>订单类型: {{ Store.orderTypeToStr(order.ordertype) }}</p>
                            <p>身份证号: {{ order.idcard }}</p>
                        </el-col>
                        <el-col :span="6">
                            <el-button type="primary" v-if="order.orderstate == 0" class="print-btn" @click="completeOrder()">确认订单</el-button>
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
            DateUtil:DateUtil,
            Store:Store,
            orderlist:[],
            order:{ },
            productlist:[],
            activeLi: 0
        };
    },
    methods:{
        open(){
            this.queryOrderList();
        },
        getOrderProductNum:function(){
            let cnt = 0;
            for(let item of this.productlist){
                cnt += item.num;
            }
            return cnt;
        },
        queryOrderList:function(){
            var url = UrlHelper.createUrl('order','cashierQueryOrder');
            
            var params = Store.createParams();
            axios.post(url,params)
                    .then((res)=>{
                        var res = res.data;
                        if(res.state == 0){
                            this.orderlist = res.obj;
                            
                            if(this.orderlist.length <= 0){
                                return ;
                            }
                            
                            this.activeLi = res.obj.length?res.obj[0].id:0;
                            console.log(res.obj);
                            this.order = this.orderlist[0];
                            this.productlist = [];
                            try {
                                if(this.order.orderdetail != null) {
                                    this.productlist = JSON.parse(this.order.orderdetail);
                                }
                            }
                            catch (Ex){

                            }
                        }
                        else{
                            //this.$message.error(res.msg);
                        }
                });
            
        },

        completeOrder:function(){

            if(this.order.orderstate == 1){

                return;
            }

            let url = UrlHelper.createUrl("order","completeOrder");

            let params = Store.createParams();
            params.orderid = this.order.id;

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){

                        this.order.orderstate = 1;

                        for(let item of this.orderlist){
                            if(item.id == orderid){
                                item.orderstate = 1;
                                break;
                            }
                        }

                        this.$message.success("确认成功");

                    }
                    else{
                        this.$message.error(res.msg);
                    }
                });

        },

        selectOrder:function(id){
            for(let item of this.orderlist){
                if(item.id == id){
                    this.order = item;
                    this.activeLi = id;
                    this.productlist = [];
                    try {
                        if(this.order.orderdetail != null) {
                            this.productlist = JSON.parse(this.order.orderdetail);
                        }
                    }
                    catch (ex){

                    }

                    break;
                }
            }
        }
    }
});
</script>