{include file="./common/header.tpl"}

{literal}
<div id="app">
    <div class="page-wrap">
        <cube-tab-bar v-model="selectedLabel" show-slider>
            <cube-tab v-for="(item, index) in tabs" :icon="item.icon" :label="item.label" :key="item.label">
            </cube-tab>
        </cube-tab-bar>
        <cube-tab-panels v-model="selectedLabel">
            <cube-tab-panel label="shift">
                <shift></shift>
            </cube-tab-panel>
            <cube-tab-panel label="count">
                <count></count>
            </cube-tab-panel>
        </cube-tab-panels>
    </div>
    <div class="login"></div>
</div>

{/literal}

{include file="./components/shift.tpl"}
{include file="./components/count.tpl"}

<script src="{$StaticRoot}/js/common/urlUtil.js"></script>
{literal}
<script>
    var app = new Vue({
        el: "#app",
        data: function(){
            return {
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
    })
</script>
{/literal}

{include file="./common/footer.tpl"}