const router = new VueRouter({
    routes: [
        { path: '/', component: { template: '<div>foo</div>' } }
      ]
})

var app = new Vue({
    el: "#app",
    router,
    data: function(){
        return {
            selectedLabel: 'index',
            tabs: [
                {
                    label: 'index'
                },
                {
                    label: 'shift'
                },
                {
                    label: 'count'
                }
            ]
        };
    },
    watch: {
        selectedLabel: function(newV, oldV){
            this.tabsChange(newV,oldV);
        }
    },
    created() {
        // this.selectedLabel = UrlUtil.getQueryString("f").replace(/mobile/,"");
    },
    mounted() {},
    methods: {
        login:function(){
            
            var url = UrlHelper.createUrl('user','login');
            axios.post(url,this.loginMsg)
            .then((res)=>{
                res = res.data;
                if(res.state == 0){
                    Toast.success("登录成功");
                    Store.initLoginInfo(res.obj);
                    this.isLogin = true;
                    this.selectedLabel = "index";
                }
                else{
                    Toast.error(res.msg);
                }
            });
            
        },
        toIndex:function(){
            this.selectedLabel = "index";
        },
        toShift:function(){
            this.selectedLabel = "shift";
        },
        toCount:function(){
            this.selectedLabel = "count";
        },
        toOrder:function(){
            this.selectedLabel = "order";
        },
        toCard:function(){
            this.selectedLabel = "card";
        },
        toMember:function(){
            this.selectedLabel = "member";
        },
        toWaterbar:function(){
            this.selectedLabel = "waterbar";
        },
        tabsChange(newTab, oldTab){
            if(this.$refs[newTab]){
                this.$refs[newTab].open();
            }
        },
        info:function(){
            
        }
    }
});