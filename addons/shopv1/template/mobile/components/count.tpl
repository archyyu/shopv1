<script type="text/x-template" id="count">
    {literal}
    <div class="count">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>盘点</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <span>仓库：</span>
                <cube-select
                    v-model="selectWarehouse"
                    :options="warehouseList">
                </cube-select>
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
                            <tr v-for="material in productInventory">
                                <td>{{material.productname}}</td>
                                <td>{{material.inventory}}</td>
                                <td>
                                    <cube-input v-model='material.actualinventory'></cube-input>
                                </td>
                                <td>{{material.actualinventory - material.inventory > 0 ?'报溢':'报损' }}</td>
                                <td>{{material.actualinventory - material.inventory}}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <cube-button :primary="true" @click='check'>确 定</cube-button>
            </cube-scroll>
        </div>
    </div>
    </div>

</script>

<script>
Vue.component('count', {
    name: 'Count',
    template: '#count',
    data: function(){
        return {
            productInventory: [],
            warehouseList: [2013, 2014, 2015, 2016, 2017, 2018],
            selectWarehouse: 2018
        };
    },
    created() {},
    mounted() {
        
    },
    methods: {
        open: function(){
            this.queryProductInventory();
        },
        backToMain:function(){
            this.$root.toIndex();
        },
        
        queryProductInventory: function () {
            let params = Store.createParams();
            let url = UrlHelper.createUrl("product", "loadProductInventory");

            axios.post(url, params)
                .then((res) => {
                    res = res.data;
                    if (res.state == 0) {
                        this.productInventory = res.obj;
                    } else {
                        this.$message.error(res.msg);
                    }
                });

        },
        check: function () {

            let params = Store.createParams();
            params.data = JSON.stringify(this.productInventory);
            console.log(params.data);
            let url = UrlHelper.createUrl("product", "inventorycheck");

            axios.post(url, params)
                .then((res) => {
                    res = res.data;
                    console.log(res);
                    if (res.state == 0) {
                        Toast.success("盘点成功");
                        //this.queryProductInventory();
                    } else {
                        Toast.error(res.msg);
                    }
                });

        },
        info: function () {

        }
    }
});
</script>

{/literal}