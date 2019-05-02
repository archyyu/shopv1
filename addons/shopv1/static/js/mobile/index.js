var app = new Vue({
    el: "#app",
    data: function(){
        return {
            isLogin: true,
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
            selectedLabel: 'waterbar',
            tabs: [
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
                }
            ]
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
                            this.selectedLabel = "waterbar";
                        }
                        else{
                            Toast.error(res.msg);
                        }
                    });
            
        },
        info:function(){
            
        }
    }
});