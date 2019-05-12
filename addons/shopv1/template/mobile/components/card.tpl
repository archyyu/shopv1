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
                                <td><cube-button @click="sendCard(cardtype)">发放</cube-button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>

            <cube-popup type="card-popup" position="bottom" :mask-closable="true" ref="sendCardPopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>发送卡券</h5>
                        <cube-button  :inline="true" :outline="true" @click="closeSendCard">取消</cube-button>
                    </div>
                    <div class="my-popup-content">
                        <cube-form
                            
                            :model="cardModel"
                            :schema="cardForm"
                            @submit="sendMemberCard"></cube-form>
                    </div>
                </div>
            </cube-popup>

            <!-- <cube-popup type="card-popup" position="bottom" :mask-closable="true" ref="cardqrcodePopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>请 扫描下面二维码</h5>
                        <cube-button  :inline="true" :outline="true" @click="closeQrcode">取消</cube-button>
                    </div>
                    <div class="my-popup-content scan-code">
                        <qrcode :value="qrcodeurl"></qrcode>
                    </div>
                </div>
            </cube-popup> -->
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
            qrcodeurl: "www.baidu.com",
            cardtype:{},
            cardModel: {
                phone: "",
                num: 1,
            },
            cardForm: {
                fields: [
                    {
                        type: 'input',
                        modelKey: 'phone',
                        label: '手机号',
                        props: {
                            placeholder: '请填写手机号'
                        }
                    },
                    {
                        type: 'input',
                        modelKey: 'num',
                        label: '数量',
                        props: {
                            placeholder: '请填写卡券数量'
                        }
                    },
                    {
                        type: 'submit',
                        label: '发送卡券'
                    }
                ]
            }
        };
    },
    created() {},
    mounted() {
        
    },
    methods: {
        open:function(){
            this.queryCardTypeList();
        },
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
        sendCard:function(cardtype){
            this.cardtype = cardtype;
            this.$refs.sendCardPopup.show();
        },
        
        sendMemberCard:function(){
            
            let url = UrlUtil.createUrl("product","sendMemberCard");
            let params = Store.createParams();
            params.phone = this.cardModel.phone;
            params.num = this.cardModel.num;
            params.cardtypeid = this.cardtype.id;
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            Toast.success("发送成功");
                        }
                        else{
                            Toast.error(res.msg);
                        }
                    });
            
        },
        
        closeSendCard:function(){
            this.$refs.sendCardPopup.hide();
        },

        showQrcode:function(){
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