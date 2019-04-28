{include file="./common/header.tpl"}

<div id="app">
    <div class="page-wrap count">
        <header class="header">
            <i class="cubeic-back"></i>
            <div class="title">
                <span>盘点</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="count-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>商品名称</th>
                                <th>系统库存</th>
                                <th>货架库存</th>
                                <th>损益</th>
                                <th>数量</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="o in 50">
                                <td>111</td>
                                <td>12</td>
                                <td>
                                    <cube-input></cube-input>
                                </td>
                                <td>12</td>
                                <td>12</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <cube-button :primary="true">确 定</cube-button>
            </cube-scroll>
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