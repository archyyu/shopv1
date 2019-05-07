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

</script>

<script>
Vue.component('card-list', {
    name: 'CardList',
    template: '#cardList',
    data: function(){
        return {
        };
    },
    methods: {
        backToMain:function(){
            this.$root.toIndex();
        },
        open:function(){
        },
        info: function () {

        }
    }
});
</script>

{/literal}