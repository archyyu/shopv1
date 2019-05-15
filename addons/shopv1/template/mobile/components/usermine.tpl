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
                    <div class="avatar"><img src="" alt=""></div>
                    <div class="mine-name">
                        <p class="name">姓名:{{memberInfo.nickname}}</p>
                        <p class="cellphone">手机号:{{memberInfo.mobile}}</p>
                        <cube-button :inline="true" @click="$refs.addPopup.show();">编辑信息</cube-button>
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
                            <div class="weui-cell__ft">{{memberInfo.credit2}}</div>
                        </div>
                        <div class="weui-cell weui-cell_access" @click="toCard">
                            <div class="weui-cell__bd">
                                <p>卡券</p>
                            </div>
                            <div class="weui-cell__ft">0 张</div>
                        </div>
                    </div>
                </div>
            </cube-scroll>  
            
            <cube-popup type="add-popup" position="bottom" :mask-closable="true" ref="addPopup">
                <div class="my-popup-wrap">
                    <div class="my-popup-header">
                        <h5>新建会员</h5>
                        <cube-button  :inline="true" :outline="true" @click="closeSendCard">取消</cube-button>
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
                                    <cube-input v-modal="memberModel.verification"></cube-input>
                                    <cube-button>发送</cube-button>
                                </div>
                            </cube-form-item>
                        </cube-form>
                        <cube-button class="add-btn">新建会员</cube-button>
                    </div>
                </div>
            </cube-popup>
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
                verification: ''
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
                    modelKey: 'verification',
                    label: '验证码',
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
        toCard:function(){
            this.$root.selectedLabel = 'card';
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
                    }
                });
        },
        info: function () {

        }
    }
});
</script>

{/literal}