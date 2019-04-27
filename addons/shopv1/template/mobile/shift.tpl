{include file="./common/header.tpl"}

<div id="app">
    <div class="header">
        <div class="title">
        <span>全部赛事</span>
        </div>
    </div>
    <div class="container">
        <div class="shift-info">
            <div class="shift-info-item">
                <label>开始时间：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>当前时间：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>吧员：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>微信收入：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>支付宝收入：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>现金收入：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>订单数量：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>提成收益：</label>
                <p class="tatic-text"></p>
            </div>
            <div class="shift-info-item">
                <label>备注：</label>
                <p class="tatic-text"></p>
            </div>
        </div>
        <div class="product-list">
            <h5>商品列表</h5>
            <div class="product-list-table">
                <table>
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
    </div>
</div>

<script>
    var app = new Vue({
        el: "#app",
        data: {},
        created() {},
        mounted() {},
        methods: {}
    })
</script>
{include file="./common/footer.tpl"}