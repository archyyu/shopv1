<script type="text/x-template" id="stock">
    {literal}
    <div class="stock">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>进货</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div>
                    <span>仓库：</span>
                    <cube-select
                        v-model="selectWarehouse" @change="warehousechange"
                        :options="warehouseList">
                    </cube-select>
                </div>
                <div>
                    <span>分类：</span>
                    <cube-select
                        v-model="selectClass" @change="classchange"
                        :options="classList">
                    </cube-select>
                </div>
                <div class="count-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>分类</th>
                                <th>商品名称</th>
                                <th>进货单位</th>
                                <th>进货价</th>
                                <th>进货数量</th>
                                <th>小计</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="product in 10">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <cube-input></cube-input>
                                </td>
                                <td>
                                    <cube-input></cube-input>
                                </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <cube-button :primary="true" @click=''>进 货</cube-button>
            </cube-scroll>
        </div>
    </div>
    </div>

</script>

<script>
Vue.component('stock', {
    name: 'Stock',
    template: '#stock',
    data: function () {
        return {
            productInventory: [],
            warehouseList: [],
            selectWarehouse: 0,
            classList: [],
            selectClass: 0,
        };
    },
    created() {

    },
    mounted() {
        this.queryShopStoreList();
    },
    methods: {
        open: function () {},
        backToMain: function () {
            this.$root.toIndex();
        },

        queryShopStoreList: function () {
            let params = Store.createParams();
            let url = UrlHelper.createUrl("product", "queryShopStoreList");

            axios.post(url, params)
                .then((res) => {
                    res = res.data;
                    if (res.state == 0) {

                        let list = res.obj.list;

                        for (let i = 0; i < list.length; i++) {
                            let item = {};
                            item.value = list[i].id;
                            item.text = list[i].storename;
                            this.warehouseList.push(item);
                        }

                        this.selectWarehouse = res.obj.defaultstoreid;

                    } else {

                    }
                });

        },

        warehousechange: function (value, index, text) {
            this.selectWarehouse = value;
        },

        classchange: function (value, index, text) {
            this.selectClass = value;
        },

        info: function () {

        }
    }
});
</script>

{/literal}