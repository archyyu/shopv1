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
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="member in memberList">
                                <td>{{member.nickname}}</td>
                                <td>{{member.mobile}}</td>
                                <td>{{member.idcard}}</td>
                                <td>{{member.credit1}}</td>
                                <td>{{member.credit2}}</td>
                                <td><cube-button :inline="true" >详情
                                    </cube-button>
                                </td>
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
        this.queryMemberList();
    },
    methods: {
        backToMain:function(){
            this.$root.toIndex();
        },
        queryMemberList:function(){
            
            let params = Store.createParams();
            let url = UrlHelper.createUrl("member","queryMemberList");
            
            axios.post(url,params)
                    .then((res)=>{
                       console.log(res);
                       res = res.data;

                       if(res.state == 0){
                           this.memberList = res.obj;
                       }
                       else{
                           
                       }
                    });
            
        }, 
        info: function () {

        }
    }
});
</script>

{/literal}