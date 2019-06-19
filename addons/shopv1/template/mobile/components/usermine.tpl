<script type="text/x-template" id="mine">
    {literal}
    <div class="user-mine">
        <header class="header">
            <div class="title">
                <span>我的</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="mine-base">
                    <div class="avatar"><img :src="memberInfo.avatar" alt=""></div>
                    <div class="mine-name">
                        <p class="name">姓名:{{memberInfo.nickname}}</p>
                        <p class="cellphone">手机号:{{memberInfo.mobile}}</p>
                        <cube-button v-if="memberInfo.mobile == ''" :inline="true" @click="$refs.addPopup.showPopup();">编辑信息</cube-button>
                    </div>
                </div>
                <div class="mine-info">
                    <div class="weui-cells">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>身份证</p>
                            </div>
                            <div class="weui-cell__ft">{{memberInfo.idcard}}</div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>积分</p>
                            </div>
                            <div class="weui-cell__ft">{{memberInfo.credit1}}</div>
                        </div>
                        <div class="weui-cell weui-cell_access" @click="toCharge">
                            <div class="weui-cell__bd">
                                <p>钱包余额</p>
                            </div>
                            <div class="weui-cell__ft">{{memberInfo.credit2}}</div>
                        </div>
                        <div class="weui-cell weui-cell_access" @click="toCard">
                            <div class="weui-cell__bd">
                                <p>卡券</p>
                            </div>
                            <div class="weui-cell__ft">{{memberInfo.cardsize}}张</div>
                        </div>
                        <div class="weui-cell weui-cell_access" @click="toPassword">
                            <div class="weui-cell__bd">
                                <p>重置密码</p>
                            </div>
                            <div class="weui-cell__ft"></div>
                        </div>
                    </div>
                </div>
            </cube-scroll>

            <bottom-popup label="editMember" title="编辑会员" height="auto" ref="addPopup">
                <template v-slot:content>
                    <cube-form
                            :model="memberModel"
                            ref="addForm"
                            @submit="">
                            <cube-form-item :field="fields[0]"></cube-form-item>
                            <cube-form-item :field="fields[1]"></cube-form-item>

                            <cube-form-item :field="fields[2]">
                                <div class="captcha-input">
                                    <cube-input v-model="memberModel.verification"></cube-input>
                                    <cube-button :primary="true" :inline="true" @click="getCode">获取验证码</cube-button>
                                </div>
                            </cube-form-item>
                            <cube-form-item :field="fields[3]"></cube-form-item>
                        </cube-form>
                </template>
                <template v-slot:footer>
                    <cube-button class="add-btn" @click="updateMemberInfo">保存</cube-button>
                </template>
            </bottom-popup>  
            
            <!-- <cube-popup type="add-popup" position="bottom" :mask-closable="true" height="initial" ref="addPopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>编辑会员</h5>
                        <cube-button  :inline="true" :outline="true" @click="$refs.addPopup.hide();">取消</cube-button>
                    </div>
                    <div class="my-popup-content">
                        <cube-form
                            :model="memberModel"
                            ref="addForm"
                            @submit="">
                            <cube-form-item :field="fields[0]"></cube-form-item>
                            <cube-form-item :field="fields[1]"></cube-form-item>

                            <cube-form-item :field="fields[2]">
                                <div class="captcha-input">
                                    <cube-input v-model="memberModel.verification"></cube-input>
                                    <cube-button :primary="true" :inline="true" @click="getCode">获取验证码</cube-button>
                                </div>
                            </cube-form-item>
                            <cube-form-item :field="fields[3]"></cube-form-item>
                        </cube-form>
                        <cube-button class="add-btn" @click="updateMemberInfo">保存</cube-button>
                    </div>
                </div>
            </cube-popup> -->
        </div>
    </div>

</script>

<script>
Vue.component('mine', {
    name: 'Mine',
    template: '#mine',
    data: function(){
        return {
            memberModel: {
                idCard: '',
                phone: '',
                verification: '',
                password:''
            },
            memberInfo:{},
            fields: [
                {
                    type: 'input',
                    modelKey: 'idCard',
                    label: '身份证',
                    props: {
                        placeholder: '请填写身份证号'
                    }
                },
                {
                    type: 'input',
                    modelKey: 'phone',
                    label: '手机号',
                    props: {
                        placeholder: '请填写手机号'
                    }
                },
                {
                    type:'input',
                    modelKey: 'verification',
                    label: '验证码',
                    props:{
                        placeholder: '请填写验证码'
                    }
                },
                {
                    type:'input',
                    modelKey:'password',
                    label:'余额支付密码',
                    props:{
                        placeholder:'请填写余额支付密码',
                        type: 'password'
                    }
                }
            ]
        };
    },
    mounted() {
        this.queryMemberInfo();
    },
    methods: {
        open:function(){
            this.queryMemberInfo();
        },
        toCharge:function(){
            this.$root.selectedLabel = 'charge';
        },
        toCard:function(){
            this.$root.selectedLabel = 'cardList';
        },
        toPassword:function(){
            this.$root.selectedLabel = 'password';
        },
        queryMemberInfo:function(){
            let params = {};
            let url = UrlHelper.createShortUrl("getMemberInfo");
            
            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        console.log(res.obj);
                        this.memberInfo = res.obj;
                        
                        if(this.memberInfo.mobile == ""){
                            this.$refs.addPopup.showPopup();
                        }
                        
                    }
                });
        },
        getCode:function(){
            let params = {};
            
            if(this.memberModel.phone == ""){
                Toast.error("手机号不能为空");
                return ;
            }
            
            params.phone = this.memberModel.phone;
            let url = UrlHelper.createShortUrl("getCode");
            
            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        Toast.success("发送验证码成功");
                    }
                    else{
                        Toast.error(res.msg);
                    }
                });
            
        },
        updateMemberInfo:function(){
            let params = {};
            let url = UrlHelper.createShortUrl("updateMemberInfo");
            
            params.phone = this.memberModel.phone;
            params.idcard = this.memberModel.idCard;
            params.code = this.memberModel.verification;
            params.pay_password = this.memberModel.password;
            
            axios.post(url,params).then((res)=>{
                res = res.data;
                if(res.state == 0){
                    Toast.success("保存成功");
                    this.memberInfo = res.obj;
                    this.$refs.addPopup.closePopup();
                }
                else{
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