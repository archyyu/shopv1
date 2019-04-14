<el-tab-pane name="waterbar" class="waterbar">
    <span slot="label"><i class="el-icon-date"></i> 水吧</span>
    <div class="waterbar-content">
        <el-button-group class="btn-nav-group">
            <el-radio-group v-model="waterbar.firstPaneShow" size="small">
                <el-radio-button label="sale">商品销售</el-radio-button>
                <el-radio-button label="material">原料管理</el-radio-button>
            </el-radio-group>
        </el-button-group>
        <div class="sale" v-if="waterbar.firstPaneShow == 'sale'">
            <el-row :gutter="15">
                <el-col :span="4" class="sale-list">
                    <div class="list-title">商品分类</div>
                    <div class="list-wrap">
                        <ul>
                            
                            <li>默认分类</li>
                            <li>啤酒</li>
                            <li>饮料</li>
                            <li>矿泉水</li>
                        </ul>
                    </div>
                </el-col>
                <el-col :span="14" class="seal-product">
                    <div class="product-title">商品列表
                        <el-button type="primary" size="mini" plain>打开钱箱</el-button>
                    </div>
                    <el-row class="product-wrap">
                        <el-col :sm="8" :md="6" class="product-item less-item">
                            <div>
                                <h5>商品名称</h5>
                                <p class="lack-pro"></p>
                                <p class="pro-price">
                                    <span class="pro_lesspro">
                                        <span class="icon iconfont">&#xe63f;</span>无库存 
                                    </span>
                                    <!-- <span class="origin">￥100</span>
                                    <br> -->
                                    ￥80 
                                </p>
                            </div>
                        </el-col>
                    </el-row>
                </el-col>
                <el-col :span="6" class="sale-cart">
                    <div class="cart-title">购物车
                        <el-button type="success" size="mini" plain>编辑</el-button>
                        <el-button type="success" size="mini" plain>优惠方案</el-button>
                        <el-button type="danger" size="mini" plain>关闭</el-button>
                        <el-button type="danger" size="mini" plain>清除</el-button>
                    </div>
                    <div class="checkout-title">
                        <div class=""><a href="#"><span class="icon iconfont back">&#xe61c;</span></a></div>
                        <div class="">结账</div>
                    </div>
                    <div class="cart-wrap">
                        <div class="pay-ways">
                            <el-row>
                                <el-col :span="24">
                                    <el-form>
                                        <el-form-item label="座位/牌号:">888</el-form-item>
                                    </el-form>
                                </el-col>
                            </el-row>
                            <el-row>
                                <el-col :span="24">合计：80 元</el-col>
                            </el-row>
                            <el-row>
                                <el-col :span="8">现金支付</el-col>
                                <el-col :span="8">微信支付</el-col>
                                <el-col :span="8">支付宝支付</el-col>
                            </el-row>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>
        <div class="material" v-else>
            <div class="material-title">吧台库</div>
            <div class="material-table">
                <el-table >
                    <el-table-column label="编号"></el-table-column>
                    <el-table-column label="类型"></el-table-column>
                </el-table>
            </div>
        </div>
    </div>
</el-tab-pane>