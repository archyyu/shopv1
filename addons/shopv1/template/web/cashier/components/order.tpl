<script type="text/x-template" id="order">
    {literal}
    <div>
        <div>角色管理</div>
        <div class="order">
            <el-row :gutter="15">
                <el-col :span="6">
                    <div class="title"></div>
                    <div class="order-list">
                        <ul>
                            <li class="active">
                                <el-row>
                                    <el-col :span="14">123456</el-col>
                                    <el-col :span="10">04-04</el-col>
                                </el-row>
                            </li>
                            <li>
                                <el-row>
                                    <el-col :span="14">123456</el-col>
                                    <el-col :span="10">04-04</el-col>
                                </el-row>
                            </li>
                        </ul>
                    </div>
                </el-col>
                <el-col :span="18">
                    <el-table>
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
                            <p>地址：{{ }}</p>
                        </el-col>
                        <el-col :span="6">
                            <p>总金额：{{ }}</p>
                            <p>订单状态：{{ }}</p>
                            <p>积分抵现：{{ }}</p>
                        </el-col>
                        <el-col :span="6">
                            <p>订单来源</p>
                        </el-col>
                        <el-col :span="6">
                            <el-button type="primary">再次打印</el-button>
                        </el-col>
                    </el-row>
                </el-col>
            </el-row>
        </div>
    </div>
    {/literal}
</script>

<script>
Vue.component('order', {
    name: 'order',
    template: '#order',
    data() {
        return {}
    }
});
</script>