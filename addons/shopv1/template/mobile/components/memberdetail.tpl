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
                    {{member.idcard}}
                    </cube-form-item>
                    <cube-form-item :field="memberForm[3]"></cube-form-item>
                    <cube-form-item :field="memberForm[4]"></cube-form-item>
                    <cube-form-item :field="memberForm[5]"></cube-form-item>
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
                    modelKey: 'idcard',
                    label: '会员身份证'
                },
                {
                    type: 'input',
                    modelKey: 'balance',
                    label: '会员余额'
                },
                {
                    type: 'input',
                    modelKey: 'socer',
                    label: '会员积分'
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
            this.$root.toIndex();
        },
        info: function () {

        }
    }
});
</script>

{/literal}