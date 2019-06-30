{include file="./common/header.tpl"}
{literal}
<div id="app" oncontextmenu="self.event.returnValue=false">
    <div class="sidebar">
        <h4>{{address}}</h4>
        <div v-if="!lock">
            <div class="line1">
                <div class="info">
                    <div class="avatar"><img :src="memberInfo.avatar"></div>
                    <div class="name">
                        <div>
                            <el-tooltip :disabled="!Boolean(memberInfo.realname)" :content="memberInfo.realname">
                                <p>姓名:{{ hideName(memberInfo.realname) }}</p>
                            </el-tooltip>
                            <el-tooltip :disabled="!Boolean(memberInfo.mobile)" :content="memberInfo.mobile">
                                <p>手机号：{{ hideNum(memberInfo.mobile) }}</p>
                            </el-tooltip>
                            <el-tooltip :disabled="!Boolean(memberInfo.idcard)" :content="memberInfo.idcard">
                                <p>身份证号：{{ hideNum(memberInfo.idcard) }}</p>
                            </el-tooltip>
                        </div>
                    </div>
                </div>
            </div>
            <div class="line2">
                <div class="onlineInfo">
                        <p><span>{{memberInfo.credit1}}</span>积分</p>
                        <p v-popover:cardpopover @click="queryMemberCardList"><span>{{memberInfo.cardsize}}</span>卡券数量</p>
                        <p><span>{{memberInfo.credit2}} 元</span>钱包余额</p>
                </div>
                <el-popover
                ref="cardpopover"
                width="300"
                popper-class="card-popover">
                    <!-- <el-table :data="cardList" size="mini" height="260px">
                        <el-table-column property="cardname" label="卡券名称"></el-table-column>
                        <el-table-column label="操作">
                            <template slot-scope="scope">
                                <a @click="useNetCard(scope.row)">使用</a>
                            </template>
                        </el-table-column>
                    </el-table> -->
                    <div class="card-list-wrap">
                        <el-scrollbar>
                            <div class="card-list-item netfee" v-for="card in cardList">
                                <div class="card-list-content">
                                    <div class="card-name">{{card.cardname}}</div>
                                    <div class="card-discount">
                                        <span v-if="card.ctype!=2">{{card.discount}} <i class="coupon-unit">折</i></span>
                                        <span v-else>{{card.exchange/100}}<i class="coupon-unit">元</i></span>
                                    </div>
                                </div>
                                <div class="card-list-footer">
                                    <div class="validity">有效时间：{{DateUtil.parseTimeInYmdHms(card.expiretime)}}</div>
                                    <div class="use" @click="useNetCard(card)"><span>使用</span></div>
                                </div>
                            </div>
                        </el-scrollbar>
                    </div>
                </el-popover>
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
                <qrcode :value="qrcodeurl" :options="{ width: 92 }"></qrcode>
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
            width="280px">
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
            width="280px">
            <div class="lock-content">
                <el-form ref="form" :model="lockinfo" label-width="80px">
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
        cardList:[
            {
                date: 11,
                name: 22
            }
        ],
        msgDialog: false,
        lockDialog: false,
        msgText: '',
        DateUtil:DateUtil,
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
                            this.queryMemberCardList();
                        }
                    });
            
        },

        hideName: function(name){
            return name?name.slice(0,1)+'*'+name.slice(-1):'';
        },

        hideNum: function(num){
            return num?num.slice(0,3)+'*'+num.slice(-3):'';
        },

        queryMemberInfoByLocal:function(){

            if(this.lock == false){
                return false;
            }

            let url = "http://" + this.host + ":18000";

            let params = {};
            params.address = this.address;
            params.shopid = this.shopid;
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

        queryMemberCardList:function(){

            if(this.memberInfo.uid == undefined){
                return ;
            }

            let params = {};
            params.memberid = this.memberInfo.uid;

            let url = UrlHelper.createUrl("member","getMemberCardList");

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        this.cardList = res.obj;
                        this.memberInfo.cardsize = this.cardList.length;
                    }

                    console.log(this.cardList);

                });

        },

        useNetCard:function(obj){

            if (obj.ctype == 0) {
                this.$message.error("非兑换卷不能使用");
                return false;
            };

            let params = {};
            params.membercardid = obj.id;
            params.memberid = obj.memberid;
            params.source = 2;
            params.shopid = this.shopid;
            params.address = this.address;

            
            let url = UrlHelper.createUrl("order","createNetCardOrder");
            
            axios.post(url,params)
            .then((res)=>{
                res = res.data;
                if(res.state == 0){
                    this.queryMemberCardList();
                    this.$message.success("卡券兑换申请成功");
                }
                else{
                    this.$message.error(res.msg);
                }
            });
        },

        leaveMsg:function(){
            
            let params = {};
            params.shopid = this.shopid;
            params.address = this.address;
            params.content = this.msgText;
            params.uid = this.memberInfo.uid;
            
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