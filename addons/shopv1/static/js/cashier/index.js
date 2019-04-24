var app = new Vue({
    el: '#app',
    data: {
        shift: {
            firstPaneShow: 'shiftData'
        },
        loginMsg: {
            account: 'ls001',
            password: '123456'
        },
        showPw: false,
        loading: false,
        isLogin: true
    },
    methods: {
        login() {
            axios.post("/user/login", this.loginMsg)
            .then(res => {
                console.log(res);
                var data = res.data;
                if (data.state === 0) {
                    Store.initLoginMsg(data.data);
                    this.isLogin = true

                } else(
                    this.$message.error(data.des)
                )
            })
            .catch(err => {
                this.$message.error('登录失败')
            });
        },

        tab(tab){
            console.log(tab);
            if(tab.$children[0].open){
                tab.$children[0].open();
            }
        }
    }
});
