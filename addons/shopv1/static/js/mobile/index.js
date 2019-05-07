var app = new Vue({
    el: "#app",
    data: function(){
        return {
            isLogin: false,
            loginMsg: {
                account: '',
                password: ''
            },
            fields: [
                {
                  type: 'input',
                  modelKey: 'account',
                  label: '账号',
                  props: {
                    placeholder: '请输入账号'
                  }
                },
                {
                  type: 'input',
                  modelKey: 'password',
                  label: '密码',
                  props: {
                    placeholder: '请输入账号',
                    type: 'password',
                    eye: {
                        open: true,
                        reverse: true
                    }
                  }
                }
            ],
            selectedLabel: 'index',
            tabs: [
                {
                    label: 'index',
                    icon: 'cubeic-like'
                },
                {
                    label: 'shift',
                    icon: 'cubeic-like'
                },
                {
                    label: 'count',
                    icon: 'cubeic-star'
                },
                {
                    label: 'waterbar',
                    icon: 'cubeic-star'
                },
                {
                    label: 'order',
                    icon: 'cubeic-star'
                },
                {
                    label: 'card',
                    icon: 'cubeic-star'
                },
                {
                    label: 'member',
                    icon: 'cubeic-star'
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