<script type="text/x-template" id="cardList">
    {literal}
    <div class="card-list">
        <header class="header">
            <i class="cubeic-back" @click="backToMain"></i>
            <div class="title">
                <span>卡券列表</span>
            </div>
        </header>
        <div class="container">
            <cube-scroll>
                <div class="card-item" v-for="item in 20">
                    <div class="card-info">
                        <h4 class="card-name">10元网费抵现券</h4>
                        <div class="card-des">满100元使用</div>
                    </div>
                    <div class="card-price">￥50</div>
                </div>
            </cube-scroll>
        </div>
    </div>
    {/literal}
</script>

<script>
Vue.component('card-list', {
    name: 'CardList',
    template: '#cardList',
    data: function(){
        return {
            cardList:[]
        };
    },
    methods: {
        backToMain:function(){
            console.log(this.$root);
            this.$root.toMine();
        },
        open:function(){
            this.$root.tabbarShow = false;
        },
        getCardList:function(){
            let url = UrlHelper.createShortUrl("getCardList");
            
            let params = {};
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            this.cardList = res.obj;
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