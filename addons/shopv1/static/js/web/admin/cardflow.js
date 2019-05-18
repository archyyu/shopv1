/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){

    //Cardflow.loadUsers();

    Cardflow.initTable();
    Cardflow.refreshTable();
});

var Cardflow = {

    //吧员列表
    users:[],
    
    initTable:function(){
        
        $("#cardFlowTable").bootstrapTable({
        	data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
	        columns: [{
                field: 'id',
                title: 'ID'
            },{
                field: 'sendshopid',
                title: '发放门店',
                formatter:function(value,row,index){
                    var shopname = $("#option_" + value).text();
                    return shopname;
                }
            },{
                field: 'username',
                title: '发放人'
            },{
                field: 'nickname',
                title: '会员昵称'
            },{
                field: 'realname',
                title: '真实姓名'
            },{
                field: 'phone',
                title: '手机号'
            },{
                field: 'gettime',
                title: '获得时间',
                formatter:function(value,row,index){
                    return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
                }
            },{
                field: 'cardname',
                title: '卡券名称'
            },{
                field: 'cardtype',
                title: '卡券类型',
                formatter:function(value,row,index){
                    if(parseInt(value) == 0){
                        return "抵现卷";
                    }
                    else if(parseInt(value) == 1){
                        return "兑换卷";
                    }
                    else{
                        return "";
                    }
                }
            },{
                field: 'useflag',
                title: '是否使用',
                formatter:function(value,row,index){
                    if(value == 0){
                        return "未使用";
                    }
                    else if(value == 1){
                        return "已使用";
                    }
                    else{
                    	return "";
                    }
                }
            },{
                field: 'usetime',
                title: '使用时间',
                formatter:function(value,row,index){
                	if (!value) 
                		return "";
                    return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
                }
            },{
                field: 'usedshopid',
                title: '使用门店',
                formatter:function(value,row,index){
                    var shopname = $("#option_" + value).text();
                    return shopname;
                }
            },{
                field: 'id',
                title: '操作',
                formatter: function (value, row) {
                    return [//'<button class="btn btn-xs btn-success">编辑</button> ',
                        '<button class="btn btn-xs btn-danger" onclick="Cardflow.deleterow(' + value + ');">删除</button>'
                    ].join("");
                }
            }]
	    });
    },
    
    refreshTable:function(){
        $("#cardFlowTable").bootstrapTable("refreshOptions",{ajax:Cardflow.reloadCardflows});
    },
    
    reloadCardflows:function(obj){
        
        var url = UrlUtil.createWebUrl('card',"loadCardflows");
        
        var params = obj.data;
        params.timearea = $("#timearea").val();
        params.useflag = $('input:radio[name="useflag"]:checked').val();
        params.sendshopid = $("#sendshopid").val();
        params.usedshopid = $("#usedshopid").val();
        params.cardtype = $("#cardtype").val();
        params.cardid = $("#cardid").val();
        
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

        var url = UrlUtil.createWebUrl('Cardflow',"loadUsers");
        
        var params = {};
        
        $.post(url,params,function(data){
            if(data.state == 0){
                if (data.obj.length > 0) {
                    Cardflow.users = data.obj;
                    // for(var i = 0; i < data.obj.length; i++){
                    //     var item = {};
                    //     item.id = data.obj[i].id;
                    //     item.account = data.obj[i].account;
                    //     item.shopid = data.obj[i].shopid;

                    //     this.users.push(item);
                    // }  
                };
            }
            else{
                Tips.failTips(data.msg);
            }
        });
    },

    flushUsers:function(shopid){
        $("#usersList").html("");
        $("#usersList").prepend("<option value='0'>请选择</option>");
        if (this.users.length > 0) {
            for (var i = 0; i < this.users.length; i++) {
                if (this.users[i].shopid == shopid) {
                    $("#usersList").append("<option value='" + this.users[i].id + "'>" + this.users[i].account + "</option>");
                };
            };
        };
    },

    deleterow:function(id){
        var url = UrlUtil.createWebUrl('card',"deleteCardflow");
        
        var params = {};
        params.id = id;

        $.post(url,params,function(data){
            if(data.state == 0){
                Cardflow.refreshTable();
            }
            else{
                Tips.failTips(data.msg);
            }
        });
    }
    
};