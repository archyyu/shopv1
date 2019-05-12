{include file="./common/header.tpl"}

<div id="app">
    <div class="sidebar">
        <h4>{{address}}</h4>
        <div v-if="!lock">
            <div class="line1">
                <div class="info">
                    <div class="avatar"><img src="http://placehold.it/90x90"></div>
                    <div class="name">
                        <div>
                            <p>尊敬的{{memberInfo.membertype}}</p>
                            <p>姓名：{{memberInfo.membername}}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="line2">
                <div class="onlineInfo">
                        <p><span>{{memberInfo.credit2}}</span>积分</p>
                        <p><span>00:00</span>上机时间</p>
                        <p><span>{{memberInfo.credit1}} 元</span>钱包余额</p>
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
        <div v-if="!lock">
            <div class="line3">
                <div class="scancode">
                </div>
            </div>
        </div>
        <div v-if="lock">
            <div class="lock2">
                <img src="{$StaticRoot}/img/client/lock_text.png">
            </div>
        </div>
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
        lock: true,
        memberInfo:{},
        address:"",
        tag:"",
        shopid:0
    },
    created:{
        
        this.address = UrlHelper.getQueryString("address");
        this.shopid = UrlHelper.getQueryString("shopid");
        this.tag = this.address + this.shopid;
        
        setInterval(()=>{
            this.queryMemberInfo();
        },5000);
        
        
    },
    methods: {
        
        queryMemberInfo:function(){
            
            if(this.lock == false){
                return false;
            }
            
            let url = UrlHelper.createUrl("member","queryMemberInfoBytag");
            
            let params = {};
            params.shopid = this.shopid;
            params.address = this.address;
            params.tag = this.tag;
            
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            this.memberInfo = res.obj;
                            this.lock = false;
                        }
                    });
            
        },
        
        openWaterbar:function(){
            let url = UrlHelper.createShortUrl("ckientsidebar");
            
            url += "&shopid=" + this.shopid;
            url += "&address=" + this.address;
            url += "&memberid=" + this.memberInfo.uid;
            
            mainForm.openContent(url);
            
        },
        
        leaveMsg:function(){
            
            let params = {};
            params.shopid = this.shopid;
            params.address = this.address;
            params.memberid = this.memberInfo.uid;
            
            let url = UrlHelper.createUrl("member","leaveMsg");
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                if(res.state == 0){
                    this.$message.success("留言成功");
                }
                else{
                    this.$message.error(res.msg);
                }
            });
            
        },
        
        callService:function(){
            
            let params = {};
            params.shopid = this.shopid;
            params.address = this.address;
            params.memberid = this.memberInfo.uid;
            
            let url = UrlHelper.createUrl("member","callService");
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                if(res.state == 0){
                    this.$message.success("留言成功");
                }
                else{
                    
                }
            });
            
        },
                
        lock:function(){
            mainForm.lockScreen(""):
        },
        info:function(){
        }
    }
});
</script>

{include file="./common/footer.tpl"}