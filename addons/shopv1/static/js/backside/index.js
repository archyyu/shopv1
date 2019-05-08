Vue.component(VueQrcode.name, VueQrcode)

var app = new Vue({
    el: '#app',
    data:{
        showSlider: false,
        qrcode: 'www.baidu.com'
    },
    methods: {
        openSlider: function () {
            this.showSlider = true;
        },

        
        closeSlider: function () {
            this.showSlider = false;
        }
    }
});
