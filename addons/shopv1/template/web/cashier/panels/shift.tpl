<el-tab-pane name="shift" lazy>
    <span slot="label"><i class="el-icon-date"></i> 交班</span>
    <div class="shift">
        <el-button-group class="btn-nav-group">
            <el-radio-group v-model="shift.firstPaneShow" size="small">
                <el-radio-button label="shiftData">交班数据</el-radio-button>
                <el-radio-button label="product">商品核对</el-radio-button>
            </el-radio-group>
        </el-button-group>
        <div class="sub-pane shift-data" v-if="shift.firstPaneShow == 'shiftData'">
            <el-row :gutter="15">
                <el-col :span="12">
                    接班时间：{{ }}
                </el-col>
                <el-col :span="12">
                    现在时间{{ }}
                </el-col>
            </el-row>
            <el-row :gutter="15">
                <el-col :span="12">
                    当前值班{{ }}
                </el-col>
            </el-row>
            <el-row :gutter="15">
                <el-col :span="12">
                    <el-table>
                        <el-table-column label=""></el-table-column>
                        <el-table-column label="现金收入"></el-table-column>
                        <el-table-column label="线上收入"></el-table-column>
                        <el-table-column label="钱包收入"></el-table-column>
                        <el-table-column label="总收入"></el-table-column>
                    </el-table>
                </el-col>
                <el-col :span="12">
                    <el-form label-width="80px">
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
                </el-col>
            </el-row>
            <div class="shift-data-footer">
                <el-button type="success">打印</el-button>
                <el-button type="default">取消</el-button>
                <el-button type="primary">交班</el-button>
            </div>
        </div>
        <div class="sub-pane shift-product" v-else>
            <el-table>
                <el-table-column label="商品分类"></el-table-column>
                <el-table-column label="商品名称"></el-table-column>
                <el-table-column label="单价"></el-table-column>
                <el-table-column label="销量"></el-table-column>
                <el-table-column label="销售额"></el-table-column>
            </el-table>
        </div>
    </div>
</el-tab-pane>