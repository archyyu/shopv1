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
            this.$root.toIndex();
        },
        open:function(){
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