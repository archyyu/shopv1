{include file="./common/header.tpl"}


<div id="app">
    <div class="backside">
        <header class="backside-header">
            <h1 class="title"><span class="logo"><img src="http://placehold.it/1920x1080"></span>欢迎来到{{$shop->name}}</h1>
        </header>
        <div class="backside-content">
            <el-carousel trigger="click" height="100%" arrow="never">
                <el-carousel-item v-for="item in 4" :key="item">
                    <img src="http://placehold.it/1920x1080">
                </el-carousel-item>
            </el-carousel>
        </div>
        <transition name="el-zoom-in-left">
            <div class="backside-slider" v-show="showSlider">
                <qrcode :value="qrcode" :options="{ width: 160 }"></qrcode>
                <p>请扫描上方二维码</p>
            </div>
        </transition>
        
    </div>
</div>


<script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>

<script src="{$StaticRoot}/js/backside/index.js"></script>



{include file="./common/footer.tpl"}