<script type="text/x-template" id="waterbar">
    {literal}
    <div class="waterbar">
        <header class="header">
            <i class="cubeic-back"></i>
            <div class="title">
                <span>交班</span>
            </div>
        </header>
        <div class="container">
            <div class="side-container">
                <cube-scroll-nav-bar direction="vertical" :current="currentNav" :labels="navList"
                    @change="changeHandler">
                    <i slot-scope="props">{{props.txt}}</i>
                </cube-scroll-nav-bar>
            </div>
            <div class="product-container">
                <cube-scroll 
                    ref="scroll"
                    :options="options"
                    @pulling-down="refresh"
                    @pulling-up="loadMore">
                    <ul class="foods-wrapper">
                        <li class="food-item" v-for="o in 50">
                            <div class="icon"><img src="http://placehold.it/57x57">
                            </div>
                            <div class="food-content">
                                <h2 class="name">红枣山药糙米粥{{o}}</h2>
                                <p class="description"></p>
                                <div class="price">
                                    <span class="now">￥10</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </cube-scroll>
            </div>
        </div>
    </div>
    </div>

</script>

<script>
Vue.component('waterbar', {
    name: 'Waterbar',
    template: '#waterbar',
    data: function () {
        return {
            currentNav: "饮料",
            navList: ["饮料", "快餐", "冰柜"],
            pullDownRefresh: false,
            pullDownRefreshThreshold: 60,
            pullDownRefreshStop: 40,
            pullUpLoad: false,
            pullUpLoadThreshold: 0,
            customPullDown: false
        };
    },
    computed: {
        options() {
            return {
                pullDownRefresh: this.pullDownRefreshObj,
                pullUpLoad: this.pullUpLoadObj,
                scrollbar: true
            }
        },
        pullDownRefreshObj: function () {
            return this.pullDownRefresh ? {
                threshold: parseInt(this.pullDownRefreshThreshold),
                // Do not need to set stop value, but you can if you want
                // stop: parseInt(this.pullDownRefreshStop),
                txt: '刷新成功'
            } : false
        },
        pullUpLoadObj: function () {
            return this.pullUpLoad ? {
                threshold: parseInt(this.pullUpLoadThreshold),
                txt: {
                    more: '加载更多',
                    noMore: '没有数据了'
                }
            } : false
        }
    },
    mounted() {},
    methods: {
        refresh: function () {
            console.log('refresh')
        },
        loadMore: function () {
            console.log('load')
        }
    }
}); 
</script>

{/literal}