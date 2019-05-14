{literal}
<script type="text/x-template" id="iconfont">
    <svg v-if="issymbol" class="icon" :class="defaultclass" aria-hidden="true">
        <use :xlink:href="iconName"/>
    </svg>
    <span v-else class="iconfont" :class="[iconclass,defaultclass]"><slot/></span>
</script>

<script>
Vue.component('iconfont', {
    name: 'iconfont',
    template: '#iconfont',
    props: {
        iconclass: {
            type: String,
        },
        defaultclass: {
            type: String,
            default: ''
        },
        issymbol: {
            type: Boolean,
            default: false
        }
    },
    computed: {
        iconName() {
            return `#${this.iconclass}`
        }
    }
});
</script>
{/literal}