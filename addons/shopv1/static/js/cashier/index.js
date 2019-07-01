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
        notifyList:[],
        broadcastList:[],
        showPw: false,
        loading: false,
        isLogin: false,
    },
    created:function(){
        
        setInterval(()=>{
            
            this.queryPrintMsg();
            
        },5000);

        setInterval(()=>{

            this.checkBroadCastList();

        },1*60*1000);
        
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
                    
                    this.queryBroadCastList();
                    
                } else{
                    this.$message.error(data.msg);
                }
            })
            .catch(err => {
                this.$message.error('登录失败')
            });
        },

        queryBroadCastList:function(){

            let url = UrlHelper.createUrl("product","getBroadcastList");
            let params = Store.createParams();

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        this.broadcastList = res.obj;
                    }
                });

        },

        checkBroadCastList:function(){

            for(let item of this.broadcastList){
                if(item.broadcasttype == 0){
                    continue;
                }
                else if(item.broadcasttype == 1){
                    //ding点
                    if(item.time() == DateUtil.getHHMM()){
                        cashier.player(item.content);
                    }
                }
                else if(item.broadcasttype == 2){
                    //整点
                    if(DateUtil.getMM() == 0){
                        cashier.player(item.content);
                    }
                }
            }

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
                                this.notifyList.unshift(res.obj.notify);

                                if(this.notifyList.length > 10){
                                    this.notifyList.pop();
                                }

                                cashier.player(res.obj.notify);
                            }

                        }
                    });
        },

        clearNotifyList:function(){

            this.notifyList = [];
            this.$message.success("提醒已经清除");

        },
        
        tab(tab){
            console.log(tab);
            if(tab.$children[0].open){
                tab.$children[0].open();
            }
        }
    }
});
