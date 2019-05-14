<script type="text/x-template" id="memberDetail">
    {literal}
    <div class="member-detail">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>会员列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <cube-form :model="member">
                    <cube-form-item :field="memberForm[0]">
                    </cube-form-item>
                    <cube-form-item :field="memberForm[1]">
                    </cube-form-item>
                    <cube-form-item :field="memberForm[2]">
                    
                    </cube-form-item>
                    <cube-form-item :field="memberForm[3]"></cube-form-item>
                    <cube-form-item :field="memberForm[4]"></cube-form-item>
                    <cube-form-item :field="memberForm[5]" @click.native="updateMemberInfo"></cube-form-item>
                </cube-form>
            </cube-scroll>
        </div>
    </div>

</script>

<script>
Vue.component('member-detail', {
    name: 'MemberDetail',
    template: '#memberDetail',
    data: function(){
        return {
            member: {},
            memberForm: [
                {
                    type: 'input',
                    modelKey: 'nickname',
                    label: '昵称'
                },
                {
                    type: 'input',
                    modelKey: 'mobile',
                    label: '会员手机号'
                },
                {
                    type:'input',
                    modelKey: 'idcard',
                    label: '会员身份证'
                },
                {
                    type: 'input',
                    modelKey: 'credit1',
                    label: '会员余额',
                    readonly:true
                },
                {
                    type: 'input',
                    modelKey: 'credit2',
                    label: '会员积分',
                    readonly:true
                },
                {
                    type: 'submit',
                    label: '修改'
                }
            ],
        };
    },
    methods: {
        open:function(){
        },
        backToMain:function(){
            this.$root.toMember();
        },
        updateMemberInfo:function(){
            
            let url =UrlHelper.createUrl("member","updateMemberInfo");
            
            let params = Store.createParams();
            params.uid = this.member.uid;
            params.phone = this.member.mobile;
            params.idcard = this.member.idcard;
            
            axios.post(url,params)
                    .then((res)=>{
                        
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){
                            Toast.success("保存成功");
                        }
                        else{
                            Toast.success("保存失败");
                        }
                        
                    });
            
        },
        info: function () {
                
        }
    }
});
</script>

{/literal}