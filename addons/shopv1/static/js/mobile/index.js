var app = new Vue({
    el: "#app",
    data: function(){
        return {
            isLogin: false,
            loginMsg: {
                account: '',
                password: ''
            },
            fields: [
                {
                  type: 'input',
                  modelKey: 'account',
                  label: '账号',
                  props: {
                    placeholder: '请输入账号'
                  }
                },
                {
                  type: 'input',
                  modelKey: 'password',
                  label: '密码',
                  props: {
                    placeholder: '请输入账号',
                    type: 'password',
                    eye: {
                        open: true,
                        reverse: true
                    }
                  }
                }
            ],
            selectedLabel: 'shift',
            tabs: [
                {
                    label: 'shift',
                    icon: 'cubeic-like',
                },
                {
                    label: 'count',
                    icon: 'cubeic-star',
                },
                {
                    label: 'waterbar',
                    icon: 'cubeic-star',
                }
            ]
        }
    },
    created() {
        this.selectedLabel = UrlUtil.getQueryString("f").replace(/mobile/,"");
    },
    mounted() {},
    methods: {}
});