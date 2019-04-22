<script type="text/x-template" id="shift">
    {literal}
    <div class="shift">
        <el-button-group class="btn-nav-group">
            <el-radio-group v-model="firstPaneShow" size="small">
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
                    当前值班：{{ }}
                </el-col>
            </el-row>
            <el-row :gutter="15" class="shift-table">
                <el-col :span="12" :offset="6">
                    <el-table :data="dutyData" size="mini" border>
                        <el-table-column label="现金收入"></el-table-column>
                        <el-table-column label="微信收入"></el-table-column>
                        <el-table-column label="支付宝收入"></el-table-column>
                        <el-table-column label="总收入"></el-table-column>
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
                <el-button type="success" size="small">打印</el-button>
                <el-button type="default" size="small">取消</el-button>
                <el-button type="primary" size="small">交班</el-button>
            </div>
        </div>
        <div class="sub-pane shift-product" v-else>
            <el-table height="100%" size="mini" border>
                <el-table-column label="商品分类"></el-table-column>
                <el-table-column label="商品名称"></el-table-column>
                <el-table-column label="单价"></el-table-column>
                <el-table-column label="销量"></el-table-column>
                <el-table-column label="销售额"></el-table-column>
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
                starttime:0,
                endtime:0,
                productcash:0,
                productwechat:0,
                productalipay:0
            },
            dutyData:[{
                    productcash:0,
                    productwechat:0,
                    productalipay:0
                }]
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
        }
    }
});
</script>
