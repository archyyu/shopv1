{include file="./common/header.tpl"}


<div id="app">
    <div class="backside"></div>
        <div class="backside-content">
            <el-carousel trigger="click" height="150px" arrow="never">
                <el-carousel-item v-for="item in imgList" :key="item">
                    <img :src="item" />
                </el-carousel-item>
            </el-carousel>
        </div>
        <div class="backside-slider"></div>
    </div>
</div>


<script >
var app = new Vue({
    el: '#app',
    data:function(){
        return {
            imgList:[]
        };
    },
    created() {
        
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
            
        },
        
        hideQrcode:function(title,qrcodeurl){
            
        },

        info:function(){
            
        }
        
    }
});
</script>



{include file="./common/footer.tpl"}