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
            <cube-scroll direction="horizontal" class="horizontal-scroll-list-wrap" :options="scrollOptions">
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
                                <td>
                                    <cube-button :inline="true" >详情</cube-button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </cube-scroll>
            <bottom-popup label="onlineDetail" title="" height="auto" ref="detailPopup">
                <template v-slot:content>
                    <cube-form :model="detailModel">
                        <cube-form-item :field="detailForm[0]">
                            {{ store.memberOnlineState(memberInfo) }}
                        </cube-form-item>
                        <cube-form-item :field="detailForm[1]">
                            {{memberInfo.netbarOnline.onlinefee/100}} 元
                        </cube-form-item>
                        <cube-form-item :field="detailForm[2]">
                            {{DateUtil.parseTimeInYmdHms(memberInfo.netbarOnline.onlinestarttime)}}
                        </cube-form-item>
                        <cube-form-item :field="detailForm[3]">
                            {{DateUtil.timeSpanFrom(memberInfo.netbarOnline.onlinestarttime)}}
                        </cube-form-item>
                        <cube-form-item :field="detailForm[4]"></cube-form-item>
                    </cube-form>
                </template>
            </bottom-popup>
        </div>
    </div>

</script>

<script>
Vue.component('member', {
    name: 'Member',
    template: '#member',
    data: function(){
        return {
            scrollOptions:{
                freeScroll: true,
                eventPassthrough:'vertical'
            },
            memberList: []
        };
    },
    created() {},
    mounted() {
        
    },
    methods: {
        open:function(){
            this.queryMemberList();
        },
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