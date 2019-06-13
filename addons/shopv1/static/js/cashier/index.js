var app = new Vue({
    el: '#app',
    data:{
        shift: {
            firstPaneShow: 'shiftData'
        },
        loginMsg: {
            account: '',
            password: ''
        },
        showPw: false,
        loading: false,
        isLogin: false,
    },
    created:function(){
        
        setInterval(()=>{
            
            this.queryPrintMsg();
            
        },5000);
        
    },
    methods: {
        login() {
            
            axios.post(UrlHelper.createUrl("user","login"), this.loginMsg)
            .then(res => {
                console.log(res);
                var data = res.data;
                if (data.state === 0) {
                    Store.initLoginMsg(data.obj);
                    this.isLogin = true;
                    
                    
                    
                } else{
                    this.$message.error(data.msg);
                }
            })
            .catch(err => {
                this.$message.error('登录失败')
            });
        },
        
        queryPrintMsg:function(){
            
            let url = UrlHelper.createUrl("order","queryPrintMsg");
            
            let params = Store.createParams();
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        console.log(res);
                        if(res.state == 0){

                            if(res.obj.print) {
                                cashier.printOrder(res.obj.print);
                            }

                            if(res.obj.notify){
                                cashier.player(res.obj.notify);
                            }

                        }
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
