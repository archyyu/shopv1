{include file="./common/header.tpl"}
{literal}

<div id="app">
    <div class="backside">
        <div class="backside-content">
            <el-carousel trigger="click" height="150px" arrow="never">
                <el-carousel-item v-for="item in imgList" :key="item">
                    <img :src="item" />
                </el-carousel-item>
            </el-carousel>
        </div>
        <transition name="el-zoom-in-left">
            <div class="backside-slider" v-show="showSlider">
                <qrcode :value="qrcode" :options="{ width: 160 }"></qrcode>
                <p>{{title}}</p>
            </div>
        </transition>
        
    </div>
</div>


<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>
<script >
Vue.component(VueQrcode.name, VueQrcode)

var app = new Vue({
    el: '#app',
    data:function(){
        return {
            imgList:[],
            showSlider: false,
            qrcode: 'www.baidu.com',
            title:""
        };
    },
    created() {
        //this.queryBannerList(1);
    },
    methods: {
        
        
        queryBannerList:function(shopid){
            let url = UrlHelper.createUrl("product","loadbanner");
            
            let params = {};
            params.shopid = shopid;
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            console.log(res.obj);
                            
                            for(let item of res.obj){
                                this.imgList.push(UrlHelper.getWebBaseUrl() + item.imgurl);
                            }
                            
                        }
                        else{
                            
                        }
                });
            
        },

        showQrcode:function(title,qrcodeurl){
            this.showSlider = true;
            this.title = title;
            this.qrcode = qrcodeurl;
        },
        
        hideQrcode:function(){
            this.showSlider = false;
            
        },

        info:function(){
            
        }
        
    }
});
</script>

{/literal}

{include file="./common/footer.tpl"}