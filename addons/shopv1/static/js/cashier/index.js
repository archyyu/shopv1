var app = new Vue({
    el: '#app',
    data: {
        shift: {
            firstPaneShow: 'shiftData'
        }
    },
    methods: {
        tab(tab){
            console.log(tab);
            if(tab.$children[0].open){
                tab.$children[0].open();
            }
        }
    }
});
