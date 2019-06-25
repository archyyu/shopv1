<template id="stock">
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
                    <cube-select v-model="selectWarehouse" @change="warehousechange" :options="warehouseList">
                    </cube-select>
                </div>
                <div>
                    <span>分类：</span>
                    <cube-select v-model="selectClass" @change="classchange" :options="classList">
                    </cube-select>
                </div>
                <div class="count-table">
                    <!-- <table class="table">
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
                    </table> -->
                    <div class="stock-item" v-for="item in 10">
                        <div>
                            <div class="stock-area">进货单号：</div>
                            <div class="stock-area">进货商：</div>
                        </div>
                        <div>
                            <div>名称：</div>
                            <div>分类：</div>
                            <div>单位：</div>
                        </div>
                        <div>
                            <div>单价：</div>
                            <div>数量：</div>
                            <div>合计：</div>
                        </div>
                    </div>

                    <div class="add-item">+</div>
                </div>
                <cube-button :primary="true" @click=''>进 货</cube-button>
            </cube-scroll>
            <cube-popup 
                type="product-list" 
                position="center"
                :mask-closable="true" 
                ref="choosePro">
                <div class="choose-search">
                    <span>分类：</span>
                    <cube-select v-model="chooseProClass" @change="chooseChange" :options="chooseClassList">
                    </cube-select>
                </div>
                <div class="product-wrap">
                    <cube-scroll nest-mode="native">
                        <div class="weui-cells">
                            <div class="weui-cell" v-for="item in 12" @click="addPro">
                                <div class="weui-cell__bd">
                                    <p>商品{{item}}</p>
                                </div>
                                <div class="weui-cell__ft">分类</div>
                            </div>
                        </div>
                    </cube-scroll>
                </div>
            </cube-popup>
            <cube-popup 
                type="product-edit" 
                position="center"
                :mask-closable="true" 
                ref="chooseEdit">
                <cube-scroll>
                    <cube-form
                        :model="editModel">
                        <cube-form-item :field="editFields[0]"></cube-form-item>
                        <cube-form-item :field="editFields[1]"></cube-form-item>
                        <cube-form-item :field="editFields[2]"></cube-form-item>
                        <cube-form-item :field="editFields[3]"></cube-form-item>
                        <cube-form-item :field="editFields[4]"></cube-form-item>
                        <cube-form-item :field="editFields[5]"></cube-form-item>
                        <cube-form-item :field="editFields[6]"></cube-form-item>
                        <cube-form-item :field="editFields[7]"></cube-form-item>
                    </cube-form>
                    <div class="bottom-btns">
                        <cube-button>删除</cube-button>
                        <cube-button :primary="true">添加</cube-button>
                    </div>
                </cube-scroll>
            </cube-popup>
        </div>
    </div>

</template>

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
            chooseClassList: [
                {
                    value:0,
                    text:'egg'
                },
                {
                    value:1,
                    text:'apple'
                }
            ],
            chooseProClass: 0,
            editModel: {
                orderId: '',
                supplier: '',
                class: '',
                name: '',
                unit: '',
                price: '',
                num: '',
                sum: ''
            },
            editFields: [
                {
                    type: 'input',
                    modelKey: 'orderId',
                    label: '进货单号'
                },
                {
                    type: 'input',
                    modelKey: 'supplier',
                    label: '供货商'
                },
                {
                    type: 'input',
                    modelKey: 'class',
                    label: '分类'
                },
                {
                    type: 'input',
                    modelKey: 'name',
                    label: '商品名'
                },
                {
                    type: 'input',
                    modelKey: 'unit',
                    label: '单位'
                },
                {
                    type: 'input',
                    modelKey: 'price',
                    label: '进货价'
                },
                {
                    type: 'input',
                    modelKey: 'num',
                    label: '进货数量'
                },
                {
                    type: 'input',
                    modelKey: 'sum',
                    label: '合计'
                }
            ]
        };
    },
    created() {
        
    },
    mounted() {
        this.queryShopStoreList();
    },
    methods: {
        open: function () {
            console.log(this.$refs)
            console.log(this.$refs.choosePro)
            this.$refs.choosePro.show()
        },
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

        chooseChange: function(value, index, text) {
            this.chooseProClass = value;
        },

        addPro: function(){
            this.$refs.choosePro.hide();
            this.$refs.chooseEdit.show();
        },

        info: function () {

        }
    }
});
</script>

{/literal}