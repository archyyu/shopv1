<script type="text/x-template" id="shift">
    {literal}
    <div class="shift">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>交班</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
            <div class="shift-info">
                <div class="shift-info-item">
                    <span class="info-title">开始时间：</span>
                    <p class="static-text">{{DateUtil.parseTimeInYmdHms(duty.starttime)}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">当前时间：</span>
                    <p class="static-text">{{DateUtil.parseTimeInYmdHms(duty.endtime)}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">吧员：</span>
                    <p class="static-text">{{Store.user.account}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">微信收入：</span>
                    <p class="static-text">{{duty.productwechat}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">支付宝收入：</span>
                    <p class="static-text">{{duty.productalipay}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">现金收入：</span>
                    <p class="static-text">{{duty.productcash}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">订单数量：</span>
                    <p class="static-text">{{duty.ordersize}}</p>
                </div>
                <div class="shift-info-item">
                    <span class="info-title">提成收益：</span>
                    <p class="static-text">暂无</p>
                </div> 
            </div>
            <div class="product-list">
                <h5>销售商品列表</h5>
                <div class="product-list-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>商品名称</th>
                                <th>数量</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="product in productData">
                                <td>{{product.productname}}</td>
                                <td>{{product.num}}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <cube-button :primary="true" @click="submitDuty" >交 班</cube-button>
            </cube-scroll>
        </div>
    </div>

</script>

<script>
Vue.component('shift', {
    name: 'Shift',
    template: '#shift',
    data: function(){
        return {
            Store:Store,
            DateUtil:DateUtil,
            duty:{},
            productData:[]
            };
    },
    mounted(){
        this.queryDutyInfo();
        this.queryProductList();
    },
    methods: {
        
        backToMain:function(){
            this.$root.toIndex();
        },
        
        queryDutyInfo:function(){
            var url = UrlHelper.createUrl('duty','queryDuty');
            var params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                res = res.data;
                if(res.state == 0){
                    this.duty = res.obj;
                }
                else{
                    
                }
                        });
            
        },

        queryProductList:function(){
            var url = UrlHelper.createUrl("order","queryDutyProductList");
            var params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                         res = res.data;
                         if(res.state == 0){
                                this.productData = res.obj;
                             }
                             else{
                                Toast.error(res.msg);
                             }
                        });
        },
        
        submitDuty:function(){
            var url = UrlHelper.createUrl("duty","submitDuty");
            var params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            Toast.success("交班成功");
                            this.queryDutyInfo();
                        }
                        else{
                            Toast.error(res.msg);
                        }
                                    });
            
        },
        check: function(){
        },
        
        info:function(){
        }
        
    }
});
</script>

{/literal}