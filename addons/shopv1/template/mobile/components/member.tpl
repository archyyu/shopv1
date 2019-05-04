<script type="text/x-template" id="member">
    {literal}
    <div class="member">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>会员列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="count-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>会员昵称</th>
                                <th>会员手机号</th>
                                <th>会员身份证</th>
                                <th>会员余额</th>
                                <th>会员积分</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="member in memberList">
                                <td>{{member.nickname}}</td>
                                <td>{{member.mobile}}</td>
                                <td>{{member.idcard}}</td>
                                <td>{{member.credit1}}</td>
                                <td>{{member.credit2}}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>
        </div>
    </div>
    </div>

</script>

<script>
Vue.component('member', {
    name: 'Member',
    template: '#member',
    data: function(){
        return {
            memberList: []
        };
    },
    created() {},
    mounted() {
        this.queryProductInventory();
    },
    methods: {
        backToMain:function(){
            this.$root.toIndex();
        },
        queryMemberList:function(){
            
        }, 
        info: function () {

        }
    }
});
</script>

{/literal}