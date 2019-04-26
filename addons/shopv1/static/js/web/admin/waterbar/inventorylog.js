/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){
    
    InventoryLog.logTableInit();
    InventoryLog.refreshTable();
});

var InventoryLog = {
    
    logTableInit:function(){
        $("#logListTable").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[{
                field:"id",
                title:"流水"
            },{
                field:'productid',
                title:'商品'
            },{
                field:'storeid',
                title:'库房'
            },{
                field:'logtype',
                title:'变动类型',
                formatter:function(value, row,index){
                    if(value == 0){
                        
                    }
                    else if(value == 1){
                        return "订单扣除";
                    }
                    else if(value == 2){
                        return "订单取消增加";
                    }
                    else if(value == 3){
                        return "进货";
                    }
                    else if(value == 4){
                        return "";
                    }
                    else if(value == 5){
                        return "盘点";
                    }
                    else if(value == 6){
                        return "报损";
                    }
                    else if(value == 7){
                        return "报溢";
                    }
                    else if(value == 8){
                        return "调货出";
                    }
                    else if(value == 9){
                        return "调货入";
                    }
                    return "未知";
                }
            },{
                field:'num',
                title:'变动数量'
            },{
                field:'createtime',
                title:'时间',
                formatter:function(value,row,index){
                    return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
                }
            },{
                field:'userid',
                title:'操作员'
            },{
                field:'detail',
                title:'备注'
            }]
        });
    },
    
    
    
    loadLogs:function(obj){
        var url = UrlUtil.createWebUrl('product','loadlogs');
        
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
    
    refreshTable:function(){
        $("#logListTable").bootstrapTable("refreshOptions",{"ajax":InventoryLog.loadLogs});
    }
    
};

