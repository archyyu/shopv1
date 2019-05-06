Vue.component(VueQrcode.name, VueQrcode);

var app = new Vue({
    el: "#app",
    data: function(){
        return {
            selectedLabel: 'waterbar',
            tabs: [
                {
                    label: 'waterbar'
                },
                {
                    label: 'shift'
                },
                {
                    label: 'count'
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
    },
    mounted() {},
    methods: {}
});