Vue.component(VueQrcode.name, VueQrcode);

var app = new Vue({
    el: "#app",
    data: function(){
        return {
            tabbarShow: true,
            selectedLabel: 'waterbar',
            tabs: [
                {
                    label: '点餐',
                    value: 'waterbar'
                },
                {
                    label: '订单',
                    value: 'order'
                },
                {
                    label: '我的',
                    value: 'mine'
                }
            ]
        };
    },
    watch: {
        selectedLabel: [
            function(newV, oldV){
                this.tabsChange(newV,oldV);
            },
            function(newV){
                for(var i=0;i<this.tabs.length;i++){
                    if(this.tabs[i].value == newV){
                        this.tabbarShow = true;
                        return ;
                    }
                }
                this.tabbarShow = false;
            }
        ]
    },
    created() {
    },
    mounted() {},
    methods: {
        tabsChange: function (newV,oldV) {
            console.log(newV, oldV);
        },
        toIndex: function () {
            this.selectedLabel = 'waterbar';
        },
        toMine: function () {
            this.selectedLabel = 'mine';
        }
    }
});