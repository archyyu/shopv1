{include file="./common/header.tpl"}


<div id="app">
    <div class="backside"></div>
        <header class="backside-header">
            <h1 class="title"><span class="adlogo"><img src="/clientImages/backside/adlogo.png"></span>欢迎来到{{$shop->name}}</h1>
        </header>
        <div class="backside-content">
            <el-carousel trigger="click" height="150px" arrow="never">
                <el-carousel-item v-for="item in 4" :key="item">
                  <h3>{{ item }}</h3>
                </el-carousel-item>
            </el-carousel>
        </div>
        <div class="backside-slider"></div>
    </div>
</div>


<script >
var app = new Vue({
    el: '#app',
    data:{},
    methods: {
        
        queryBannerList:function(shopid){
        
        },

        showQrcode:function(){
            
        },
        
        hideQrcode:function(){
            
        },

        info:function(){
            
        }
        
    }
});
</script>



{include file="./common/footer.tpl"}