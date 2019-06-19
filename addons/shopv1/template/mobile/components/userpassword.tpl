{literal}
<script type="text/x-template" id="password">
    <div class="user-password">
        <header class="header">
            <span class="cubeic-back" @click="back"></span>
            <div class="title">
                <span>余额充值</span>
            </div>
        </header>
        <div class="container">
            <div class="confirm-phone" v-if="firstStep">
                <cube-form :model="phoneModel">
                    <cube-form-item :field="phonefields[0]">
                        <cube-input
                            v-model="phoneModel.phone"
                            placeholder="请输入手机号码"
                            @blur="resize"></cube-input>
                    </cube-form-item>
                    <cube-form-item :field="phonefields[1]" class="verify-item">
                        <cube-input
                            v-model="phoneModel.verification"
                            placeholder="请输入验证码"
                            @blur="resize"></cube-input>
                            <cube-button
                                :disabled="waiting"
                                :inline="true"
                                @click="countdown">
                                <span v-if="!waiting">{{ verificationStr }}</span>
                                <span v-else>{{ totalTime }}s</span>
                            </cube-button>
                    </cube-form-item>
                </cube-form>
                <cube-button class="bottom-btn" @click="firstStep = false">下一步</cube-button>
            </div>
            <div class="reset-pw" v-else>
                <cube-form :model="passwordModel">
                    <cube-form-item :field="passwordFields[0]">
                        <cube-input
                            v-model="phoneModel.password"
                            placeholder="请输入密码"
                            @blur="resize"></cube-input>
                    </cube-form-item>
                    <cube-form-item :field="passwordFields[1]">
                        <cube-input
                            v-model="phoneModel.confirmPw"
                            placeholder="请确认密码"
                            @blur="resize"></cube-input>
                    </cube-form-item>
                </cube-form>
                <cube-button class="bottom-btn">确定</cube-button>
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
            firstStep: true,
            waiting: false,
            totalTime: 60,
            verificationStr: '发送验证码',
            phoneModel: {
                phone: '',
                verification: ''
            },
            phonefields: [
                {
                    type: 'input',
                    modelKey: 'phone',
                    label: '手机号码'
                },
                {
                    type: 'input',
                    modelKey: 'verification',
                    label: '短信验证'
                }
            ],
            passwordModel: {
                password: '',
                confirmPw: ''
            },
            passwordFields: [
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

        info: function(){

        }
        
    }
});
</script>
{/literal}