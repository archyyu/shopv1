/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){

    Order.loadUsers();

    

    Order.initTable();
    Order.refreshTable();
});

$('#shopSelect').change(function(){
    Order.flushUsers();
 });

var Order = {

    //吧员列表
    users:[],
    
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
        params.shopid = $("#shopSelect").val();
        params.timearea = $("#timearea").val();
        params.orderstate = $('input:radio[name="orderstate"]:checked').val();
        params.userid = $("#usersList").val();
        
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },

    loadUsers:function(){

        var url = UrlUtil.createWebUrl('order',"loadUsers");
        
        var params = {};
        
        $.post(url,params,function(data){
            if(data.state == 0){
                if (data.obj.length > 0) {
                    Order.users = data.obj;
                    // for(var i = 0; i < data.obj.length; i++){
                    //     var item = {};
                    //     item.id = data.obj[i].id;
                    //     item.account = data.obj[i].account;
                    //     item.shopid = data.obj[i].shopid;

                    //     this.users.push(item);
                    // }  

                    Order.flushUsers();
                };
            }
            else{
                Tips.failTips(data.msg);
            }
        });
    },

    flushUsers:function(){
        var shopid = $("#shopSelect").val();
        $("#usersList").html("");
        $("#usersList").prepend("<option value='0'>请选择</option>");
        if (this.users.length > 0) {
            for (var i = 0; i < this.users.length; i++) {
                if (this.users[i].shopid == shopid) {
                    $("#usersList").append("<option value='" + this.users[i].id + "'>" + this.users[i].account + "</option>");
                };
            };
        };
        $('#usersList').selectpicker('refresh');
    }
    
    
};