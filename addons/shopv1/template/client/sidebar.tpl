{include file="./common/header.tpl"}
{literal}
<div id="app">
    <div class="sidebar">
        <h4>{{address}}</h4>
        <div v-if="!lock">
            <div class="line1">
                <div class="info">
                    <div class="avatar"><img :src="memberInfo.avatar"></div>
                    <div class="name">
                        <div>
                            <p>姓名:{{memberInfo.realname}}</p>
                            <p>手机号：{{memberInfo.mobile}}</p>
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
                 <qrcode :value="qrcodeurl" :options="{ width: 100 }"></qrcode>
                </div>
                <p>扫码登录获得积分</p>
            </div>
        </div>
        <div class="line3a" @click='openWaterbar'>
            <a class="buy_btn" >
                <span class="iconfont">&#xe640;</span>
                <p>购买饮品</p>
            </a>
        </div>
        <div v-if="!lock">
            <div class="line3">
                <div class="scancode">
                <qrcode :value="qrcodeurl" :options="{ width: 100 }"></qrcode>
                </div>
            </div>
        </div>
        <div v-if="lock">
            <div class="lock2">
                {/literal}
                <img src="{$StaticRoot}/img/client/lock_text.png">
                {literal}
            </div>
        </div>
        <div class="line4">
            <div>
                <a><span class="iconfont" @click="callService">&#xe63b;</span> 呼叫网管</a>
                <a><span class="iconfont" @click="showMsg">&#xe63c;</span> 留言</a>
                <a><span class="iconfont" @click="showLock">&#xe661;</span> 挂机</a>
            </div>
        </div>
        <el-dialog
            title="留言"
            :visible.sync="msgDialog"
            width="280px"
            :before-close="handleClose">
            <div class="msg-content">
                <el-input type="textarea" :rows="3" v-model="msgText"></el-input>
            </div>
            <span slot="footer">
                <!-- <p>最多输入40字</p> -->
                <el-button type="default" round @click="msgDialog = false">关闭</el-button>
                <el-button type="primary" round @click="leaveMsg">提交</el-button>
            </span>
        </el-dialog>
        <el-dialog
            title="锁屏"
            :visible.sync="lockDialog"
            width="280px"
            :before-close="handleClose">
            <div class="lock-content">
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="锁屏密码">
                      <el-input v-model="lockinfo.password"></el-input>
                    </el-form-item>
                    <el-form-item label="确认密码">
                      <el-input v-model="lockinfo.confirmPassword"></el-input>
                    </el-form-item>
                </el-form>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="lockDialog = false">取 消</el-button>
                <el-button type="primary" @click="lockScreen">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</div>

<script>
var app = new Vue({
    el: '#app',
    data:{
        lock: true,
        memberInfo:{},
        address:"",
        host:"",
        idcard:"",
        tag:"",
        qrcodeurl:"",
        shopid:0,
        msgDialog: false,
        lockDialog: false,
        msgText: '',
        lockinfo: {
            password: '',
            confirmPassword: ''
        }
    },
    created: function(){
        
        this.address = UrlHelper.getQueryString("address");
        this.shopid = UrlHelper.getQueryString("shopid");
        this.host = UrlHelper.getQueryString("host");
        this.idcard = UrlHelper.getQueryString("idcard");
        this.tag = this.shopid + this.address;

        //this.queryMemberInfoByLocal();

        setInterval(()=>{
            this.queryMemberInfo();
        },10000);
        
        this.qrcodeurl = "http://pinshangy.com/app/index.php?i=2&m=shopv1&do=mobile&f=tag&c=entry&tag=" + this.tag;
        
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
            params.idcard = this.idcard;
            params.tag = this.tag;
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            let name = res.obj.realname;
                            let phone = res.obj.phone;
                            this.$message.success("登录成功");
                            this.memberInfo = res.obj;

                            //this.memberInfo.realname = name.slice(0,1)+'*'+name.slice(-1);
                            //this.memberInfo.phone = phone.slice(0,3)+'*'+phone.slice(-3);

                            this.lock = false;
                        }
                    });
            
        },

        queryMemberInfoByLocal:function(){

            if(this.lock == false){
                return false;
            }

            let url = "http://" + this.host + ":18000";

            let params = {};
            params.address = this.address;
            params.shopid = this.shopid;


            // $.get(url,params,function(data){
            //     if(data.state == 0){
            //         console.log(data);
            //     }
            // });

            // axios.post(url,params)
            //     .then((res)=>{
            //         res = res.data;
            //         console.log(res);
            //         let obj = JSON.parse(res);
            //
            //         if(obj.state == 0) {
            //             this.idcard = obj.data;
            //         }
            //     });

        },
        
        openWaterbar:function(){
            let url = UrlHelper.createShortUrl("clientwaterbar");
            
            url += "&shopid=" + this.shopid;
            url += "&address=" + this.address;
            url += "&memberid=" + this.memberInfo.uid;
            
            mainForm.openContent(url);
            
        },

        showMsg: function(){
            this.msgDialog = true;
        },
        
        leaveMsg:function(){
            
            let params = {};
            params.shopid = this.shopid;
            params.address = this.address;
            params.content = this.msgText;
            params.memberid = this.memberInfo.uid;
            
            let url = UrlHelper.createUrl("member","leaveMsg");
            
            axios.post(url,params)
            .then((res)=>{
                res = res.data;
                this.msgDialog = false;
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
                    this.$message.success("呼叫成功");
                }
                else{
                    
                }
            });
            
        },

        showLock:function(){
            this.lockDialog = true;
        },
                
        lockScreen:function(){
            mainForm.lockScreen(this.lockinfo.password);
            lockDialog = false;
        },
        info:function(){
        }
    }
});
</script>
{/literal}
{include file="./common/footer.tpl"}