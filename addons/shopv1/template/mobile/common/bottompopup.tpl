{literal}
<script type="text/x-template" id="bottomPopup">
<cube-popup position="bottom" :mask-closable="true" :type="cubeclass" :ref="label">
    <div class="my-popup-wrap">
        <div class="my-popup-header">
            <h5>{{title}}</h5>
            <cube-button :inline="true" :outline="true" @click="closePopup" v-if="showclose">关闭</cube-button>
        </div>
        <div class="my-popup-content" :style="{height:heightStyle}">
            <slot name="content"></slot>
        </div>
        <div class="my-popup-footer" v-if="showfooter">
            <slot name="footer"></slot>
        </div>
    </div>
</cube-popup>

</script>


<script>
Vue.component('bottom-popup', {
    name: 'BottomPopup',
    template: '#bottomPopup',
    props: {
        label: {
            type: String,
            default: 'bottomPopup'
        },
        title: {
            type: String,
            default: ' '
        },
        cubeclass: {
            type: String,
            default: ''
        },
        showclose: {
            type: Boolean,
            default: true
        },
        height: {
            type: [Number,String]
        }

    },
    data: function(){
        return {
        };
    },
    computed: {
        heightStyle: function () {
            var height = this.height;
            if(height){
                return typeof height === 'number'?height+'px':height
            }
        },
        showfooter: function(){
            return Boolean(this.$slots.footer)
        }
    },
    methods:{
        showPopup: function(){
            this.$refs[this.label].show();
        },
        closePopup: function(){
            this.$refs[this.label].hide();
        }
    }
});
</script>
{/literal}