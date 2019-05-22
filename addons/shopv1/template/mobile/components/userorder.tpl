<script type="text/x-template" id="order">
    {literal}
    <div class="order">
        <header class="header">
            <div class="title">
                <span>订单列表</span>
            </div>
            <span class="right-icon" :class="{active: filtered}" @click="showFilter"><iconfont>&#xe68a;</iconfont></span>
        </header>
        <div class="container">
            <cube-scroll direction="horizontal" class="horizontal-scroll-list-wrap" :options="scrollOptions">
                <div class="list-wrapper">
                    <table class="table list-item">
                        <thead>
                            <tr>
                                <th>订单Id</th>
                                <th>价格</th>
                                <th>支付方式</th>
                                <th>订单来源</th>
                                <th>时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="order in orderList">
                                <td class="orderIdTd">{{order.id}}</td>
                                <td>{{order.orderprice/100}}元</td>
                                <td>{{paytypeStr(order.paytype)}}</td>
                                <td>{{ordersourceStr(order.ordersource)}}</td>
                                <td class="orderTimeTd">{{DateUtil.parseTimeInYmdHms(order.paytime)}}</td>
                                <td>
                                    <cube-button :inline="true" @click="lookOrderDetail(order.orderdetail)">商品详情
                                    </cube-button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>

            <bottom-popup label="orderSearch" title="搜索订单" height="auto" cubeclass="filter-popup" ref="filterPopup">
                <template v-slot:content>
                    <cube-form :model="searchModel">
                    <cube-form-item :field="searchFields[0]">
                            <cube-button :inline="true" class="date-btn" @click="chooseDate">{{searchStartDate?searchStartDate+" 至 "+searchEndDate:' 选 择 时 间 段 '}}</cube-button>
                    </cube-form-item>
                    <cube-form-item :field="searchFields[1]"></cube-form-item>
                    <cube-form-item :field="searchFields[2]"></cube-form-item>
                </cube-form>
                </template>
                <template v-slot:footer>
                    <cube-button :inline="true" @click="resetFilter">重 置</cube-button>
                    <cube-button :inline="true" @click="confirmFilter">搜 索</cube-button>
                </template>
            </bottom-popup>

            <cube-popup position="bottom" :mask-closable="true" ref="proDetailPopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>商品详情</h5>
                        <cube-button :inline="true" :outline="true" @click="closepopup">关闭</cube-button>
                    </div>
                    <div class="my-popup-content">
                        <cube-scroll :options="{scrollbar:true}">
                            <ul>
                                <li>
                                    <div class="pro-title">商品名称</div>
                                    <div class="pro-price">总价</div>
                                    <div class="pro-num">数量</div>
                                </li>
                                <li v-for="item in orderproductlist">
                                    <div class="pro-title">{{item.productname}}</div>
                                    <div class="pro-price">￥{{item.price}}</div>
                                    <div class="pro-num">{{item.num}}</div>
                                </li>
                            </ul>
                        </cube-scroll>

                    </div>
                </div>
            </cube-popup>

        </div>
    </div>

</script>

<script>
const dateSegmentData = [{
        is: 'cube-date-picker',
        title: '开始时间',
        min: new Date(2010, 0, 1),
        max: new Date(),
        value: new Date(moment().subtract(1, 'days')),
        columnCount: 5
    },
    {
        is: 'cube-date-picker',
        title: '结束时间',
        min: new Date(2010, 0, 1),
        max: new Date(),
        columnCount: 5
    }
];
Vue.component('order', {
    name: 'Order',
    template: '#order',
    data: function(){
        return {
            scrollOptions:{
                freeScroll: true,
                eventPassthrough:'vertical'
            },
            offset:0,
            limit:20,
            shopList: [],
            userList: [],
            DateUtil:DateUtil,
            orderList: [],
            orderproductlist:[],
            searchStartDate: '',
            searchEndDate: '',
            searchModel: {
                userid: '',
                shopid: '',
            },
            searchFields: [
                {
                    label: '时间'
                },
                {
                    type: 'select',
                    modelKey: 'shopid',
                    label: '门店',
                    props: {
                        options: this.shopList,
                    }
                },
                {
                    type: 'select',
                    modelKey: 'userid',
                    label: '吧员',
                    props: {
                        options: this.userList,
                    }
                }
            ]
        };
    },
    computed: {
        filtered: function(){
            return Boolean(this.searchStartDate) || Boolean(this.searchModel.userid) || Boolean(this.searchModel.shopid);
        }
    },
    created() {},
    mounted() {
       this.queryMemberOrder();
    },
    methods: {
        open:function(){
            //this.queryMemberOrder();
        },
        closepopup:function(){ 
            this.$refs.proDetailPopup.hide(); 
        },
        showFilter: function(){
            this.$refs.filterPopup.showPopup();
        },
        hideFilter: function(){
            this.$refs.filterPopup.closePopup();
        },
        chooseDate: function () {
            let that = this;
            if (!this.orderDate) {
                this.orderDate = this.$createSegmentPicker({
                    data: dateSegmentData,
                    onSelect: (selectedDates, selectedVals, selectedTexts) => {
                        that.searchStartDate = `${moment(selectedDates[0]).format('YYYY-MM-DD HH:mm')}`;
                        that.searchEndDate = `${moment(selectedDates[1]).format('YYYY-MM-DD HH:mm')}`;
                    },
                    onNext: (i, selectedDate, selectedValue, selectedText) => {
                        dateSegmentData[1].min = selectedDate
                        if (i === 0) {
                            this.orderDate.$updateProps({
                                data: dateSegmentData
                            })
                        }
                    }
                })
            }
            this.orderDate.show()
        },
        resetFilter: function(){
            this.searchStartDate = '';
            this.searchEndDate = '';
            this.searchModel.userid = '';
            this.searchModel.shopid = '';
        },
        confirmFilter: function(){
            this.hideFilter();
        },
        lookOrderDetail:function(orderProductList){
            console.log(orderProductList);
            this.orderproductlist = JSON.parse(orderProductList);
            this.$refs.proDetailPopup.show();
        },
        paytypeStr:function(type){
            if(type == 0){
                return "现金";
            }
            else if(type==1){
                return "微信";
            }
            else if(type == 2){
                return "支付宝";
            }
        },
    
        ordersourceStr:function(source){
            if(source == 0){
                return "收银端";
            }
            else if(source == 1){
                return "手机端";
            }
            else if(source == 2){
                return "客户端";
            }
        },
        queryMemberOrder:function(){
            
            let params = {};
            params.offset = this.offset;
            params.limit = this.limit;
            
            let url = UrlHelper.createShortUrl("getOrderList");
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            for(var i = 0;i<res.obj.length;i++){
                                this.orderList.push(res.obj[i]);
                            }
                        }
                        else{

                        }
                    });
            
        },
        info: function () {

        }
    }
});
</script>

{/literal}