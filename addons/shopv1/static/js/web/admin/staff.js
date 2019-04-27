/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){
    Staff.staffTableInit();
    Staff.staffTableReload();
});

$("#shopSelect").change(function(){
    Staff.staffTableReload();
});

var Staff = {
    
    staffTableInit:function(){
        $("#staffListTable").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[{
                        field:'account',
                        title:'账号'
                    },{
                        field:'phone',
                        title:'手机号'
                    },{
                        field:'openid',
                        title:'openid'
                    },{
                        field:'sex',
                        title:'性别',
                        formatter:function(value,row,index){
                            if(value == 0){
                                return '男';
                            }
                            else{
                                return "女";
                            }
                        }
                    },{
                        field:'id',
                        title:'操作',
                        events:{
                            'click .edit-event':function(e,value,row,index){
                                Staff.openStaffModal(1,row);
                            }
                        },
                        formatter:function(value,row,index){
                            return '<button class="btn btn-xs btn-success edit-event">编辑</button> ';
                        }
                    }
            ]
        });
    },
    
    staffTableReload:function(){
        $("#staffListTable").bootstrapTable("refreshOptions",{ajax:Staff.queryStaffList});
    },
    
    queryStaffList:function(obj){
        var url = UrlUtil.createWebUrl('shop','loadStaffList');
        var params = obj.data;
        params.shopid = $("#shopSelect").val();
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
        });
    },
    
    openStaffModal:function(au,obj){
        if(au == 0){
            $("#addStaffModal [name=userid]").val(0);
        } 
        else{
            $("#addStaffModal [name=userid]").val(obj.id);
            $("#addStaffModal [name=account]").val(obj.account);
            $("#addStaffModal [name=password]").val(obj.password);
            $("#addStaffModal [name=sex]").val(obj.sex);
            $("#addStaffModal [name=phone]").val(obj.phone);
            $("#addStaffModal [name=openid]").val(obj.openid);
        }
        
        $("#addStaffModal").modal("show");
    },
    
    saveStaff:function(){
        var url = UrlUtil.createWebUrl("shop","saveStaff");
        
        var params = {};
        params.shopid = $("#shopSelect").val();
        params.userid = $("#addStaffModal [name=userid]").val();
        params.account = $("#addStaffModal [name=account]").val();
        params.password = $("#addStaffModal [name=password]").val();
        params.sex = $("#addStaffModal [name=sex]").val();
        params.phone = $("#addStaffModal [name=phone]").val();
        params.openid = $("#addStaffModal [name=openid]").val();
        
        $.post(url,params,function(data){
            if(data.state == 0){
                $("#addStaffModal").modal("hidden");
                Tips.successTips("保存成功");
                Staff.staffTableReload();
            }
            else{
                Tips.failTips(data.msg);
            }
            
        });
        
    },
    
    info:function(){
        
    }
    
};