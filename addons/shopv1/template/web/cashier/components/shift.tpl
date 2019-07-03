<script type="text/x-template" id="shift">
    {literal}
    <div class="shift">
        <el-button-group class="btn-nav-group">
            <el-radio-group v-model="firstPaneShow" @change="selectProduct" size="small">
                <el-radio-button label="shiftData">交班数据</el-radio-button>
                <el-radio-button label="product">商品核对</el-radio-button>
            </el-radio-group>
        </el-button-group>
        <div class="sub-pane shift-data" v-if="firstPaneShow == 'shiftData'">
            <el-row :gutter="15" class="shift-info">
                <el-col :span="12">
                    接班时间：{{ DateUtil.parseTimeInYmdHms(duty.starttime) }}
                </el-col>
                <el-col :span="12">
                    现在时间：{{ DateUtil.parseTimeInYmdHms(duty.endtime)}}
                </el-col>
            </el-row>
            <el-row :gutter="15" class="shift-info">
                <el-col :span="12">
                    当前值班：{{ Store.userInfo.account }}
                </el-col>
            </el-row>
            <el-row :gutter="15" class="shift-table">
                <el-col :span="12" :offset="6">
                    <el-table :data="dutyData" size="mini" border>
                        <el-table-column prop="productcash" label="现金收入"></el-table-column>
                        <el-table-column prop="productwechat" label="微信收入"></el-table-column>
                        <el-table-column prop="productalipay" label="支付宝收入"></el-table-column>
                        <el-table-column prop="productsum" label="总收入"></el-table-column>
						<el-table-column prop="netcardsum" label="网费兑换总计"></el-table-column>
                    </el-table>
                </el-col>
                <!-- <el-col :span="12">
                    <el-form label-width="80px">
                        <el-form-item label="临卡押金"></el-form-item>
                        <el-form-item label="水吧卡扣"></el-form-item>
                        <el-form-item label="网费兑换券数量" label-width="120px"></el-form-item>
                        <el-form-item label="赠送总金额" label-width="92px"></el-form-item>
                        <el-form-item label="接班对象">
                            <el-radio-group>
                                <el-radio :label="3">备选项</el-radio>
                                <el-radio :label="6">备选项</el-radio>
                                <el-radio :label="9">备选项</el-radio>
                            </el-radio-group>
                        </el-form-item>
                        <el-form-item label="备注">
                            <el-input></el-input>
                        </el-form-item>
                    </el-form>
                </el-col> -->
            </el-row>
            <div class="shift-data-footer">
                <el-button type="primary" @click="submitDuty()" size="small">交班</el-button>
                <el-button type="primary" @click="printDuty()" size="small">打印</el-button>
            </div>
        </div>
        <div class="sub-pane shift-product"  v-else>
            <el-table height="100%" :data='productData' size="mini" border>
                <el-table-column prop='producttype' label="商品分类"></el-table-column>
                <el-table-column prop='productname' label="商品名称"></el-table-column>
                <el-table-column prop='price' label="单价"></el-table-column>
                <el-table-column prop='num' label="销量"></el-table-column>
                <el-table-column prop='sum' label="销售额"></el-table-column>
            </el-table>
        </div>
    </div>
    {/literal}
</script>

<script>
Vue.component('shift', {
    name: 'shift',
    template: '#shift',
    data() {
        return {
            firstPaneShow: 'shiftData',
            Store:Store,
            DateUtil:DateUtil,
            duty:{
                shopname:"",
                username:"",
                startdate:"",
                enddate:"",
                starttime:0,
                endtime:0,
                productcash:0,
                productwechat:0,
                productalipay:0,
				netcardsum:0
            },
            dutyData:[{
                    productcash:0,
                    productwechat:0,
                    productalipay:0,
                    productsum:0,
					netcardsum:0
                }],
            productData:[]
        };
    },
    methods:{
        open(){
            //todo
            this.queryCurrentDuty();
        },
        queryCurrentDuty:function(){
            var url = UrlHelper.createUrl('duty','queryDuty');
            var params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        this.duty = res.obj;
                        this.dutyData[0] = this.duty;
                    }
                    else{
                        this.$message.success(res.msg);
                    }
                });
        },

        printDuty:function(){

            this.duty.startdate = DateUtil.parseTimeInYmdHms(this.duty.starttime);
            this.duty.enddate = DateUtil.parseTimeInYmdHms(this.duty.endtime);
            this.duty.shopname = Store.shopInfo.shopname;
            this.duty.username = Store.userInfo.account;


            cashier.printDuty(JSON.stringify(this.duty));

        },
        
        submitDuty:function(){
            
            var url = UrlHelper.createUrl("duty","submitDuty");
            var params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                
                        res = res.data;
                        if(res.state == 0){
                            this.$message.success("交班成功");
                            this.queryCurrentDuty();
                            window.location.reload();
                        }
                        else{
                            this.$message.error(res.msg);
                        }
        
                                        
                        });
            
        },
        
        selectProduct:function(){
            if(this.firstPaneShow == "product"){
                this.queryCurrentProductList();
            }
        },
        
        queryCurrentProductList:function(){
            var url = UrlHelper.createUrl("order","queryDutyProductList");
            var params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                         res = res.data;
                         if(res.state == 0){
                                this.productData = res.obj;
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
