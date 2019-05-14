/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){
    
    Duty.initDutyTable();
    Duty.refreshDutyTable();
    
});

var Duty = {
    
    initDutyTable:function(){
        $("#dutyListTable").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[{
                field:'id',
                title:'交班流水'
            },{
                field:'shopname',
                title:'门店'
            },{
                field:'username',
                title:'交班人'
            },{
                field:'productcash',
                title:'商品现金收入'
            },{
                field:'productwechat',
                title:'商品微信收入'
            },{
                field:'productalipay',
                title:'商品支付宝收入'
            },{
                field:'cardnum',
                title:'发券数量'
            },{
                field:'deleteflag',
                title:'商品售卖详情',
                events:{
                    'click .detail-event':function(value,row,index){
                        
                    }
                },
                formatter:function(value,row,index){
                    return  '<button class="btn btn-xs btn-success detail-event">商品售卖详情</button> ';
                }
            }]
        });
    },
    
    refreshDutyTable:function(){
        $("#dutyListTable").bootstrapTable("refreshOptions",{ajax:Duty.queryDutys});
    },
    
    queryDutys:function(obj){
        var url = UrlUtil.createWebUrl("duty","loadDutys");
        
        var params = obj.data;
        
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    info:function(){
        
    }
    
};