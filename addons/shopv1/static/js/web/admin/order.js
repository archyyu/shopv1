/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){
    Order.initTable();
    Order.refreshTable();
});

var Order = {
    
    initTable:function(){
        
        $("#OrderListTable").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[{
                field:'id',
                title:'订单号'
            },{
                field:'orderprice',
                title:'订单金额',
                formatter:function(value,row,index){
                    return value/100 + "元";
                }
            },{
                field:'createtime',
                title:'订单时间',
                formatter:function(value,row,index){
                    return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
                }
            },{
                field:'paytype',
                title:'支付类型',
                formatter:function(value,row,index){
                    if(value == 0){
                        return "现金支付";
                    }
                    else if(value == 1){
                        return "微信支付";
                    }
                    return "支付宝支付";
                }
            },{
                field:'ordersource',
                title:'订单来自',
                formatter:function(value,row,index){
                    if(value == 0){
                        return "收银端";
                    }
                    else if(value == 1){
                        return "手机端";
                    }
                    return "客户端";
                }
            },{
                field:'orderstate',
                title:'订单状态',
                formatter:function(value,row,index){
                    if(value == -1){
                        return "未支付";
                    }
                    else if(value == 0){
                        return "已支付";
                    }
                    else if(value == 1){
                        return "完成";
                    }
                    return "已取消";
                }
            },{
                field:'address',
                title:'地址'
            },{
                field:'orderdetail',
                title:'订单详情',
                formatter:function(value,row,index){
                    
                    try{
                    
                        var detail = JSON.parse(value);

                        var str = "";

                        for(let i=0;i<detail.length;i++){
                            str += detail[i]['productname'] + "*" + detail[i]['num'] + "  ";
                        }

                        return str;
                    }
                    catch (ex){
                        return "";
                    }
                
                }
            }]
        });
        
    },
    
    refreshTable:function(){
        $("#OrderListTable").bootstrapTable("refreshOptions",{ajax:Order.reloadOrders});
    },
    
    reloadOrders:function(obj){
        
        var url = UrlUtil.createWebUrl('order',"loadOrders");
        
        var params = obj.data;
        
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    }
    
};