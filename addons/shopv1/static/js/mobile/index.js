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
    mounted() {
        var account = Cookies.get('account');
        var password = Cookies.get('pw');
        console.log(account, password)
        if(account && password){
            this.loginMsg.account = account;
            this.loginMsg.password = password;
            this.login();
        }
    },
    methods: {
        login:function(){
            
            var url = UrlHelper.createUrl('user','login');
            axios.post(url,this.loginMsg)
            .then((res)=>{
                res = res.data;
                if(res.state == 0){
                    Toast.success("登录成功");
                    console.log(res)
                    Store.initLoginInfo(res.obj);
                    Cookies.set('account', res.obj.user.account, { expires: 5 });
                    Cookies.set('pw', this.loginMsg.password, { expires: 5 });
                    this.isLogin = true;
                    this.selectedLabel = "index";
                }
                else{
                    Toast.error(res.msg);
                }
            });
            
        },
        logout: function(){
            Cookies.remove('account');
            Cookies.remove('pw');
            this.loginMsg.account = '';
            this.loginMsg.password = '';
            this.isLogin = false;
            this.$createToast({
                type: 'success',
                time: 1000,
                txt: '退出成功'
            }).show()
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
        toMemberDetail:function(){
            this.selectedLabel = "memberDetail";
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