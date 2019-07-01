{literal}
<template id="broadcast">
    <div class="broadcast">
        <div class="search-wrap">
            <div class="add-broadcast">
                <el-button type="primary" size="small" @click="broadcastVisible = true">添加语音</el-button>
            </div>
        </div>
        <el-table :data="broadcastList" size="small" height="calc(100% - 68px)" border>
            <el-table-column prop="content" label="语音内容"></el-table-column>
            <el-table-column prop="time" label="播放时间"></el-table-column>
            <el-table-column label="是否启用">
                <template slot-scope="scope">
                    <el-tag size="small"></el-tag>
                </template>
            </el-table-column>
            <el-table-column label="播报">
                <template slot-scope="scope">
                    <el-button type="primary">播报</el-button>
                </template>
            </el-table-column>
            <el-table-column label="编辑">
                <template slot-scope="scope">
                    <el-button type="primary">编辑</el-button>
                </template>
            </el-table-column>
            <el-table-column label="删除">
                <template slot-scope="scope">
                    <el-button type="primary">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-dialog title="提示" :visible.sync="broadcastVisible" width="500px" :before-close="handleClose">
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
                        value-format="HH:mm"
                        size="small"
                        v-if="typeSelect == 2">
                    </el-time-picker>
                </el-form-item>
                <el-form-item label="播报内容">
                    <el-input type="textarea" v-model="broadcastForm.desc"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="broadcastVisible = false">取 消</el-button>
                <el-button type="primary" @click="addPlay">保 存</el-button>
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
          roleVal: 0,
          placeVal: '',
          broadcastList: [],
          broadcastForm: {
              type: '',
              time: '',
              desc: ''
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
            this.broadcastList = this.$root.data().broadcastList;
        },

        addPlay:function(){

            let url = UrlHelper.createUrl("product","addBroadCast");

            let params = Store.createParams();
            params.broadcasttype = this.broadcastForm.type;
            params.content = this.broadcastForm.desc;
            params.time = this.broadcastForm.time;

            axios.post(url,params)
                .then((res)=>{
                    res = res.data;
                    if(res.state == 0){
                        this.$root.queryBroadCastList();
                    }
                });

        },

        removePlay:function(){
            let url = UrlHelper.createUrl("product","removeBroadCast");
            
        }

    }
});
</script>