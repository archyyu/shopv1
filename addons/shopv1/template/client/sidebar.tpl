{include file="./common/header.tpl"}

<div id="app">
    <div class="sidebar">
        <h4>默认001</h4>
        <div v-if="!lock">
            <div class="line1">
                <div class="info">
                    <div class="avatar"><img src="http://placehold.it/90x90"></div>
                    <div class="name">
                        <div>
                            <p>尊敬的 </p>
                            <p>姓名：</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="line2">
                <div class="onlineInfo">
                        <p><span>8888</span>积分</p>
                        <p><span>00:00</span>上机时间</p>
                        <p><span>888 元</span>钱包余额</p>
                </div>
            </div>
        </div>
        <div v-if="lock">
            <div class="lock1">
                <div class="lock_bg"></div>
                <div class="scancode">
                </div>
                <p>扫码登录获得积分</p>
            </div>
        </div>
        <div class="line3a">
            <a class="buy_btn">
                <span class="iconfont">&#xe640;</span>
                <p>购买饮品</p>
            </a>
        </div>
        {*<div v-if="!lock">
            <div class="line3">
                <div class="scancode">
                </div>
            </div>
        </div>*}
        {*<div v-if="lock">
            <div class="lock2">
                <img src="{$StaticRoot}/img/client/lock_text.png">
            </div>
        </div>*}
        <div class="line4">
            <div>
                <a><span class="iconfont" @click="callService">&#xe63b;</span> 呼叫网管</a>
                <a><span class="iconfont" @click="leaveMsg">&#xe63c;</span> 留言</a>
                <a><span class="iconfont" @click="lock">&#xe661;</span> 挂机</a>
            </div>
        </div>
    </div>
</div>

<script>
var app = new Vue({
    el: '#app',
    data:{
        lock: false;
        memberInfo:{},
    },
    methods: {
        callService:function(){
            
            let url = UrlHelper.createUrl("product","call");
            
            
            
        },
        leaveMsg:function(){
            this.$message.success("leaveMsg");
        },
        lock:function(){
            this.$message.success("lock");
        },
        info:function(){
        }
    }
});
</script>

{include file="./common/footer.tpl"}