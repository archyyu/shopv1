{literal}
<script type="text/x-template" id="charge">
    <div class="user-charge">
        <header class="header">
            <span class="cubeic-back" @click="back"></span>
            <div class="title">
                <span>余额充值</span>
            </div>
        </header>
        <div class="container">
        <cube-form :model="model" class="cube-form_groups">
            <cube-form-group legend="充值">
                <cube-form-item :field="fields[1]">
                    <cube-input v-model="model.chargefee" @blur="resize"></cube-input>
                </cube-form-item>
                <cube-form-item :field="fields[2]"></cube-form-item>
                <cube-form-item :field="fields[3]">{{(this.model.chargefee*1 + this.model.awardfee*1)}}</cube-form-item>
            </cube-form-group>
            <cube-form-group legend="充赠">
                <table class="table">
                    <thead>
                        <tr>
                            <th>充值金额</th>
                            <th>赠送金额</th>
                            <th>卡券</th>
                            <th>积分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item of chargeCompaignList">
                            <td>{{item.chargefee}}</td>
                            <td>{{item.awardfee}}</td>
                        </tr>
                    </tbody>
                </table>
            </cube-form-group>
            <cube-form-group legend="支付方式">
                <cube-form-item>
                <cube-radio-group>
                  <cube-radio
                    v-for="(opt, idx) in payWays"
                    :key="idx"
                    :option="opt"
                    v-model="model.paytype">
                    <div class="pay-item">
                        <div class="pay-icon" :class="opt.label">
                            <iconfont :iconclass="'icon-'+opt.icon"></iconfont>
                        </div>
                        <div class="pay-name">
                            <h4>{{opt.title}}</h4>
                        </div>
                    </div>
                </cube-radio>
                </cube-radio-group>
                </cube-form-item>
                <cube-button @click="charge">充 &nbsp;&nbsp; 值</cube-button>
            </cube-form-group>
        </cube-form>
        </div>
    </div>
</script>


<script>
Vue.component('charge', {
    name: 'Charge',
    template: '#charge',
    data(){
        return {
            memberInfo: {},
            model: {
                chargefee: '',
                awardfee:0,
                paytype: ''
            },
            payinfo:{},
            chargeCompaignList:[],
            fields: [
                {
                    label: '余额',
                },
                {
                    type: 'input',
                    modelKey: 'chargefee',
                    label: '支付金额',
                    props: {
                        placeholder: '请输入金额'
                    },
                },
                {
                    type: 'input',
                    modelKey: 'awardfee',
                    label: '赠送金额',
                    props: {
                        readonly: true
                    },
                },
                {
                    label: '合计金额',
                }
            ],
            payWays: [
                {
                    icon: 'weipay',
                    label: 'weiPay',
                    title: '微信支付',
                    value: 2,
                }
            ]
        }
    },
    watch:{

        'model.chargefee':{
            handler:function(val,oldval){


                this.model.awardfee = 0;
                for(let item of this.chargeCompaignList){

                    if(val*1 >= item.chargefee*1){
                        this.model.awardfee = item.awardfee;
                        return;
                    }
                }

            },
            deep:true
        }

    },
    methods:{
        open:function(){

            let url = UrlHelper.createShortUrl("getChargeCompaignList");
            let params = {};

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        this.chargeCompaignList = res.obj;

                        this.chargeCompaignList.sort(function(a,b){
                            if(a.chargefee < b.chargefee){
                                return 1;
                            }
                            else if(a.chargefee > b.chargefee){
                                return -1;
                            }
                            return 0;
                        });

                    }
                });

            this.model.chargefee = '';
            this.model.paytype = 2;
        },

        resize: function(){
            this.$root.resizePage();
        },

        getAwardFee:function(){



        },

        charge:function(){

            let url = UrlHelper.createShortUrl("charge");
            let params = {};
            params.chargefee = this.model.chargefee;
            params.awardfee = this.model.awardfee;

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){

                        this.payinfo = res.obj;

                        this.callpay();

                    }
                });

        },

        callpay:function() {
            if (typeof WeixinJSBridge == "undefined") {
                if (document.addEventListener) {
                    document.addEventListener('WeixinJSBridgeReady', this.jsApiCall, false);
                } else if (document.attachEvent) {
                    document.attachEvent('WeixinJSBridgeReady', this.jsApiCall);
                    document.attachEvent('onWeixinJSBridgeReady', this.jsApiCall);
                }
            } else {
                this.jsApiCall();
            }
        },

        jsApiCall:function () {
            WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId": this.payinfo.appId,
                    "timeStamp": this.payinfo.timeStamp,
                    "nonceStr": this.payinfo.nonceStr,
                    "package": this.payinfo.package,
                    "signType": this.payinfo.signType,
                    "paySign": this.payinfo.paySign
                },
                function(res) {
                    WeixinJSBridge.log(res.err_msg);
                }
            );
        },

        back:function(){
            this.$root.toMine();
        },

        info: function(){

        }
        
    }
});
</script>
{/literal}