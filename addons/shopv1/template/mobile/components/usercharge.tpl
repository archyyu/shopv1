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
                <cube-form-item :field="fields[0]"></cube-form-item>
                <cube-form-item :field="fields[1]"></cube-form-item>
                <cube-form-item :field="fields[2]"></cube-form-item>
                <cube-form-item :field="fields[3]">{{(this.model.chargefee*1 + this.model.awardfee)}}</cube-form-item>
            </cube-form-group>
            <cube-form-group legend="充赠">
                <table class="table">
                    <thead>
                        <tr>
                            <th>充值金额</th>
                            <th>赠送金额</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>2</td>
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
                <cube-button>充 &nbsp;&nbsp; 值</cube-button>
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
                },
                {
                    icon: 'alipay',
                    label: 'aliPay',
                    title: '支付宝支付',
                    value: 3,
                },
                {
                    icon: 'home',
                    label: 'cashPay',
                    title: '现金支付',
                    value: 1,
                }
            ]
        }
    },
    methods:{
        open:function(){
            this.model.chargefee = '';
            this.model.paytype = '';
        },
        back:function(){
            this.$root.toMine();
        },

        info: function(){}
        
    }
});
</script>
{/literal}