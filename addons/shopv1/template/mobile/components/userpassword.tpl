{literal}
<script type="text/x-template" id="password">
    <div class="user-password">
        <header class="header">
            <span class="cubeic-back" @click="back"></span>
            <div class="title">
                <span>重置密码</span>
            </div>
        </header>
        <div class="container">
            <div class="confirm-phone">
                <cube-form :model="passwordModel">
                    <cube-form-item :field="passwordFields[0]">
                        <cube-input v-model="passwordModel.phone" placeholder="请输入手机号码" :clearable="true"
                            @blur="resize"></cube-input>
                    </cube-form-item>
                    <cube-form-item :field="passwordFields[1]" class="verify-item">
                        <cube-input v-model="passwordModel.verification" placeholder="请输入验证码" :clearable="true"
                            @blur="resize"></cube-input>
                        <cube-button :disabled="waiting" :inline="true" @click="countdown">
                            <span v-if="!waiting">{{ verificationStr }}</span>
                            <span v-else>{{ totalTime }}s</span>
                        </cube-button>
                    </cube-form-item>
                    <cube-form-item :field="passwordFields[2]">
                        <cube-input v-model="passwordModel.password" placeholder="请输入密码" type="password"
                            :clearable="true" :eye="{open:true,reverse:true}" @blur="resize"></cube-input>
                    </cube-form-item>
                    <cube-form-item :field="passwordFields[3]">
                        <cube-input v-model="passwordModel.confirmPw" placeholder="请确认密码" type="password"
                            :clearable="true" :eye="{open:true,reverse:true}" @blur="resize"></cube-input>
                    </cube-form-item>
                </cube-form>
                <cube-button class="bottom-btn" @click="resetPwd">确 &nbsp;&nbsp; 认</cube-button>
            </div>
        </div>
    </div>
</script>


<script>
Vue.component('password', {
    name: 'Password',
    template: '#password',
    data(){
        return {
            waiting: false,
            totalTime: 60,
            verificationStr: '发送验证码',
            passwordModel: {
                password: '',
                confirmPw: '',
                phone: '',
                verification: ''
            },
            passwordFields: [
                {
                    type: 'input',
                    modelKey: 'phone',
                    label: '手机号码'
                },
                {
                    type: 'input',
                    modelKey: 'verification',
                    label: '短信验证'
                },
                {
                    type: 'input',
                    modelKey: 'password',
                    label: '登录密码'
                },
                {
                    type: 'input',
                    modelKey: 'confirmPw',
                    label: '确认密码'
                }
            ]
        }
    },
    methods:{
        open:function(){
            this.firstStep = true;
            //this.passwordModel.phone = this.$refs.mine.memberInfo.phone;
        },

        resize: function(){
            this.$root.resizePage();
        },

        back:function(){
            if(this.firstStep){
                this.$root.toMine();
            }else{
                this.firstStep = true;
                this.passwordModel.password = '';
                this.passwordModel.confirmPw = '';
            }
        },
        
        countdown(){

            if(this.passwordModel.phone == ""){

                Toast.error("手机号不能是空");
                return ;
            }

            this.getCode();
            this.waiting = true;
            let time = setInterval(()=>{
                if(this.totalTime>1){
                    this.totalTime--;
                }else{
                    clearInterval(time);
                    this.verificationStr = '重新发送验证码'
                    this.totalTime = 60;
                    this.waiting = false;
                }
            }, 1000)
        },

        getCode:function(){

            let url = UrlUtil.createShortUrl("getCode");

            let params = {};
            params.phone = this.passwordModel.phone;

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){

                    }
                    else{

                    }
                });

        },

        resetPwd:function(){


            if(this.passwordModel.password != this.passwordModel.confirmPw){
                Toast.error("密码不一致");
                return;
            }

            let url = UrlUtil.createShortUrl("resetPayPwd");

            let params = {};
            params.phone = this.passwordModel.phone;
            params.code = this.passwordModel.verification;
            params.pay_password = this.passwordModel.password;

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        Toast.success("修改成功");
                    }
                    else {
                        Toast.error("失败");
                    }
                });

        },

        info: function(){

        }
        
    }
});
</script>
{/literal}