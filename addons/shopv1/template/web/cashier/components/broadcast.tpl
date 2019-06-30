{literal}
<template id="broadcast">
    <div class="broadcast">
        <div class="search-wrap">
            <div class="call-select">
                请
                <el-select v-model="roleVal" placeholder="请选择" size="small">
                    <el-option v-for="(item,idx) in roleList" :key="item.value" :label="item.label" :value="item.value">
                    </el-option>
                </el-select>
                到
                <el-autocomplete v-model="placeVal" :fetch-suggestions="getPlaceList" placeholder="请输入内容" size="small">
                </el-autocomplete>
                号机器
                <el-button type="primary" size="small">播 报</el-button>
            </div>
            <div class="add-broadcast">
                <el-button type="primary" size="small">添加语音</el-button>
            </div>
        </div>
        <el-table :data="broadcastList" size="small" height="calc(100% - 68px)" border>
            <el-table-column label="语音内容"></el-table-column>
            <el-table-column label="播放时间"></el-table-column>
            <el-table-column label="生效时间"></el-table-column>
            <el-table-column label="是否启用"></el-table-column>
            <el-table-column label="播报"></el-table-column>
            <el-table-column label="编辑"></el-table-column>
            <el-table-column label="删除"></el-table-column>
        </el-table>
        <el-dialog title="提示" :visible.sync="dialogVisible" width="30%" :before-close="handleClose">
            <el-form :model="broadcastForm" label-width="80px">
                <el-form-item label="播报类型">
                    <el-input v-model="broadcastForm.name"></el-input>
                </el-form-item>
                <el-form-item label="播报时间">
                    <el-input v-model="broadcastForm.name"></el-input>
                </el-form-item>
                <el-form-item label="播报内容">
                    <el-input type="textarea" v-model="broadcastForm.desc"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="dialogVisible = false">保 存</el-button>
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
        }
    },
    methods: {
        getPlaceList(queryString, func){
            return func(this.placeList);
        }
    }
});
</script>