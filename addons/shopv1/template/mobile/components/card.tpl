<script type="text/x-template" id="card">
    {literal}
    <div class="card">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>卡券列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="count-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>卡券名称</th>
                                <th>折扣</th>
                                <th>抵现</th>
                                <th>有效时间</th>
                                <th>有效金额</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="cardtype in cardTypeList">
                                <td>{{cardtype.cardname}}</td>
                                <td>{{cardtype.discount}}%</td>
                                <td>{{cardtype.exchange/100}}元</td>
                                <td>{{cardtype.effectiveday}}天</td>
                                <td>{{cardtype.effectiveprice/100}}元</td>
                                <td><cube-button @click="showQrcode">发放</cube-button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>
            <cube-popup type="card-popup" position="bottom" :mask-closable="true" ref="cardqrcodePopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>请 扫描下面二维码</h5>
                        <cube-button  :inline="true" :outline="true" @click="closeQrcode">取消</cube-button>
                    </div>
                    <div class="my-popup-content scan-code">
                        <qrcode :value="qrcodeurl"></qrcode>
                    </div>
                </div>
            </cube-popup>
        </div>
    </div>
    </div>

</script>

<script>
Vue.component('card', {
    name: 'Card',
    template: '#card',
    data: function(){
        return {
            Store:Store,
            DateUtil:DateUtil,
            cardTypeList: [],
            qrcodeurl: "www.baidu.com"
        };
    },
    created() {},
    mounted() {
        this.queryCardTypeList();
    },
    methods: {
        backToMain:function(){
            this.$root.toIndex();
        },
        queryCardTypeList:function(){
            let params = Store.createParams();
            let url = UrlHelper.createUrl("product", "queryCardTypeList");
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            this.cardTypeList = res.obj;
                        }
                        });
            
        }, 
        showQrcode:function(){
            console.log("show")
            console.log(this.$refs)
            this.$refs.cardqrcodePopup.show();
        },
        
        closeQrcode:function(){
            this.$refs.cardqrcodePopup.hide();
        },

        info: function () {

        }
    }
});
</script>

{/literal}