<script type="text/x-template" id="member">
    {literal}
        <div class="member">
            <div class="search-member">
                <el-form :inline="true">
                    <el-form-item label="手机号/身份证：">
                        <el-input v-model="searchText" placeholder="请输入电话或身份证号"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="">搜 索</el-button>
                    </el-form-item>
                </el-form>
            </div>
            <div class="member-detail">
                <div class="member-info">
                    <div class="avatar">
                        <img src="http://placehold.it/80x80">
                    </div>
                    <div>
                        <p class="member-name">姓名：张三李四</p>
                        <p class="member-num">账号：987654</p>
                    </div>
                </div>
                <div class="cellphone">
                    <label>手机号：</label>
                    <p>123456</p>
                </div>
                <div class="card">
                    <label>身份证：</label>
                    <p>654321</p>
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
            tagList: [],
            inputVisible: false,
            inputValue: ''
        };
    },
    methods:{
        open(){
        },
        deleteLabel(tag) {
            this.tagList.splice(this.tagList.indexOf(tag), 1);
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
        }
        
    }
});
</script>