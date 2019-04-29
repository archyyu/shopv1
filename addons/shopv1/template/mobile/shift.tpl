{include file="./common/header.tpl"}

<div id="app">
    <div class="page-wrap shift">
        <header class="header">
            <i class="cubeic-back"></i>
            <div class="title">
                <span>交班</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
            <div class="shift-info">
                <div class="shift-info-item">
                    <span class="info-title">开始时间：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">当前时间：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">吧员：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">微信收入：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">支付宝收入：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">现金收入：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">订单数量：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">提成收益：</span>
                    <p class="static-text"></p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">备注：</span>
                    <p class="static-text"></p>
                </div>
            </div>
            <div class="product-list">
                <h5>商品列表</h5>
                <div class="product-list-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>商品名称</th>
                                <th>数量</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>111</td>
                                <td>12</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <cube-button :primary="true" @click='check'>确 定</cube-button>
            </cube-scroll>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: "#app",
        data: {
            
            duty:{},
            productlist:[]
            
        },
        created() {
        },
        mounted() {
        },
        methods: {
            
            queryDutyInfo:function(){
                
            },
    
            queryProductList:function(){
                
            },
            info:function(){
            }
            
        }
    });
</script>
{include file="./common/footer.tpl"}