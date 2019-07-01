{literal}
<template id="broadcast">
    <div class="broadcast">
        <div class="search-wrap">
            <div class="add-broadcast">
                <el-button type="primary" size="small" @click="showBroadcastDialog()">添加语音</el-button>
            </div>
        </div>
        <el-table :data="broadcastList" size="small" height="calc(100% - 68px)" border>
            <el-table-column label="语音内容" prop="content"></el-table-column>
            <el-table-column label="播放时间">
                <template slot-scope="scope">
                    <span v-if="scope.row.broadcasttype==2">整点</span>
                    <span v-else>{{ scope.row.time }}</span>
                </template>
            </el-table-column>
            <el-table-column label="生效时间">
                <template slot-scope="scope">
                    <span v-if="scope.row.broadcasttype==2">{{ scope.row.time }}</span>
                    <span v-else>全天</span>
                </template>
            </el-table-column>
            <el-table-column label="是否启用"></el-table-column>
                <template slot-scope="scope">
                    <el-tag type="success" size="small" v-if="scope.row.enable==0">启用</el-tag>
                    <el-tag type="danger" size="small" v-else>未启用</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button type="text" size="mini">播报</el-button>
                    <el-button type="text" size="mini">编辑</el-button>
                    <el-button type="text" size="mini">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-dialog title="提示" :visible.sync="broadcastVisible" width="500px">
            <el-form :model="broadcastForm" label-width="80px">
                <el-form-item label="播报类型">
                    <el-select v-model="typeSelect" placeholder="请选择" size="small">
                        <el-option 
                            v-for="(item,idx) in typeList" 
                            :key="item.value" 
                            :label="item.label" 
                            :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="播报时间" v-if="typeSelect !== 0">
                    <el-time-picker
                        v-model="broadcastForm.time"
                        :picker-options="{
                            selectableRange: '00:00:00 - 23:59:00',
                            format: 'HH:mm'
                        }"
                        value-format="HH:mm"
                        placeholder="任意时间点"
                        size="small"
                        v-if="typeSelect == 1">
                    </el-time-picker>
                    <el-time-picker
                        is-range
                        v-model="broadcastForm.time"
                        range-separator="至"
                        start-placeholder="开始时间"
                        end-placeholder="结束时间"
                        placeholder="选择时间范围"
                        :picker-options="{
                            selectableRange: '00:00:00 - 23:59:00',
                            format: 'HH:mm'
                        }"
                        format="HH:mm"
                        value-format="HH:mm"
                        size="small"
                        v-if="typeSelect == 2">
                    </el-time-picker>
                </el-form-item>
                <el-form-item label="播报内容">
                    <el-input type="textarea" v-model="broadcastForm.content"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="broadcastVisible = false">取 消</el-button>
                <el-button type="primary" @click="addBroadcast">保 存</el-button>
            </span>
        </el-dialog>
    </div>
</template>
{/literal}

<script>
Vue.component('broadcast', {
    name: 'broadcast',
    template: '#broadcast',
    data() {
        return {
            roleList: [
                {
                    label: '服务员',
                    value: 0
                },
                {
                    label: '网管',
                    value: 1
                },
                {
                    label: '保洁员',
                    value: 2
                }
            ],
            placeList: [
                {
                    value: '前台'
                },
                {
                    value: '卫生间'
                }
            ],
            roleVal: 0,
            placeVal: '',
            broadcastList: '',
            broadcastForm: {
                broadcasttype: '',
                time: '',
                content: ''
            },
            broadcastVisible: false,
            typeSelect: 0,
            typeList: [
                {
                    label: '手动播报',
                    value: 0
                },
                {
                    label: '定点播报',
                    value: 1
                },
                {
                    label: '整点播报',
                    value: 2
                },
            ]
        }
    },
    methods: {
        open(){
            this.getBroadcastList();
        },
        getPlaceList(queryString, func) {
            return func(this.placeList);
        },

        getBroadcastList() {
            let url = UrlHelper.createUrl('product', 'loadBroadCastList');
            let params = Store.createParams();

            axios.post(url, params)
            .then(res => {
                res = res.data;
                if (res.state == 0) {
                    this.broadcastList = res.obj;
                }
            })
            .catch(err=>{
                console.log(err)
            })
        },

        showBroadcastDialog(id) {

            if (id) {

            } else {
                this.broadcastForm = {
                    broadcasttype: '',
                    time: '',
                    content: ''
                }
                this.broadcastVisible = true;
            }
        },

        addBroadcast() {
            let url = UrlHelper.createUrl('product', 'addBroadCast');
            let params = Store.createParams();
            params.broadcasttype = this.broadcastForm.broadcasttype;
            params.content = this.broadcastForm.content;
            params.time = this.broadcastForm.time;

            axios.post(url, params)
            .then(res=>{
                let data = res.data;
                if(data.state == 0){
                    this.$message.success(data.msg);
                    this.broadcastVisible = false;
                }else{
                    this.$message.error(data.msg);
                }
            })
            .catch(err=>{
                console.log(err)
            })
        },

        delBroadcast() {},
    }
});
</script>