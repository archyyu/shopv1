<script type="text/x-template" id="member">
    {literal}
        <div class="member">
            <div class="search-member">
                <el-form :inline="true">
                    <el-form-item label="手机号/身份证：">
                        <el-input v-model="searchText" placeholder="请输入电话或身份证号"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="queryMember">搜 索</el-button>
                    </el-form-item>
                </el-form>
            </div>
            <div class="member-detail">
                <div class="member-info">
                    <div class="avatar">
                        <img :src="memberInfo.avatar">
                    </div>
                    <div>
                        <p class="member-name">昵称：{{memberInfo.nickname}}</p>
                        <p class="member-num">真实姓名：{{memberInfo.realname}}</p>
                    </div>
                </div>
                <div class="cellphone">
                    <label>手机号：</label>
                    <p>{{memberInfo.mobile}}</p>
                </div>
                <div class="card">
                    <label>身份证：</label>
                    <p>{{memberInfo.idcard}}</p>
                </div>
                <div class="label">
                    <label>标签：</label>
                    <div class="label-wrap">
                        <el-tag
                            v-for="tag in tagList"
                            :disable-transitions="false"
                            :key="tag"
                            closable
                            @close="deleteLabel(tag)">
                            {{tag}}
                        </el-tag>
                        <el-input
                            class="input-new-tag"
                            v-if="inputVisible"
                            v-model="inputValue"
                            ref="saveTagInput"
                            size="small"
                            @keyup.enter.native="addLabel"
                            @blur="addLabel">
                        </el-input>
                        <el-button
                            v-else
                            class="button-new-tag"
                            size="small"
                            @click="showInput">
                            + New Tag
                        </el-button>
                    </div>
                </div>
            </div>
        </div>
    {/literal}
</script>

<script>
Vue.component('member', {
    name: 'Member',
    template: '#member',
    data() {
        return {
            searchText: '',
            memberInfo:{},
            tagList: [],
            inputVisible: false,
            inputValue: ''
        };
    },
    methods:{
        open(){
            
        },
        queryMember(){
            let url = UrlHelper.createUrl("member","queryMember");
            let params = Store.createParams();
            params.query = this.searchText;
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                            this.memberInfo = res.obj;
                            this.tagList = this.memberInfo.tags.split(",");
                        }
                        else{
                            this.$message.error(res.msg);
                        }
                        });
        },
        
        updateMember:function(){
            let url = UrlHelper.createUrl("member","updateMemberInfo");
            
            let params = Store.createParams();
            params.uid = this.memberInfo.uid;
            params.phone = "";
            params.idcard = "";
            
            axios.post(url,params)
                    .then((res)=>{
                        res = res.data;
                        if(res.state == 0){
                                this.$message.success("保存成功");
                                this.memberInfo.mobile = params.phone;
                                this.memberInfo.idcard = params.idcard;
                            }
                            else{
                                this.$message.error(res.msg);
                            }
                            });
            
            
            
        },
        
        saveMemberTags(){
            let url = UrlHelper.createUrl("member","saveMemberTags");
            
            let params = {};
            params.uid = this.memberInfo.uid;
            params.tags = this.tagList.toString();
            
            axios.post(url,params)
                    .then((res)=>{
                res = res.data;
                console.log(res);
                if(res.state == 0){
                    
                }
                });
            
            
        },
        
        deleteLabel(tag) {
            this.tagList.splice(this.tagList.indexOf(tag), 1);
            this.saveMemberTags();
        },

        showInput() {
            this.inputVisible = true;
            this.$nextTick(_ => {
                this.$refs.saveTagInput.$refs.input.focus();
            });
        },

        addLabel() {
            let inputValue = this.inputValue;
            if (inputValue) {
                this.tagList.push(inputValue);
            }
            this.inputVisible = false;
            this.inputValue = '';
            this.saveMemberTags();
        }
        
    }
});
</script>