/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    
    memberLevel.initTable();

});

var memberLevel = {
    
    queryLevelList : function(obj){
        var url = UrlUtil.createShortUrl("loadMemberGroups");
        var params = {};
        
        $.post(url,params,function(data){
            if(data.state==0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    initTable : function(){
        
        $("#memberTypeList").bootstrapTable({
           ajax: memberLevel.queryLevelList,
           columns:[{
                   field:'groupid',
                   title:'等级ID'
               },{
                   field:'title',
                   title:'会员名称'
               },
               {
                   field:'credit',
                   title:'所需成长值'
               },{
                   field:'discountdetail',
                   title:'等级优惠'
               },{
                   field:'uniacid',
                   title:'操作',
                   events:{
                       'click .edit-membertype':function(e,value,row,index){
                           memberLevel.openMemberTypeModal(1,row);
                        }
                   },
                   formatter:function(value,row,index){
                        return '<button class="btn btn-xs btn-primary edit-membertype" >编辑</button>';
                    }
               }
           ]
        });
        
    },
    
    
    reloadTable:function(){ 
        $("#memberTypeList").bootstrapTable('refresh');
    },
    
    openMemberTypeModal : function(type,item){
        $("#memberLevelModal").modal('show');

        if(type == 0){

            $("#memberLevelModal [name=groupid]").val('');
            $("#memberLevelModal [name=title]").val("");
            $("#memberLevelModal [name=credit]").val('');

        }
        else{

            $("#memberLevelModal [name=groupid]").val(item.groupid);
            $("#memberLevelModal [name=title]").val(item.title);
            $("#memberLevelModal [name=credit]").val(item.credit);
        }

    },

    save:function(){

        let url = UrlUtil.createShortUrl("saveMemberGroup");

        let params = {};
        params.groupid = $("#memberLevelModal [name=groupid]").val();
        params.title = $("#memberLevelModal [name=title]").val();
        params.credit = $("#memberLevelModal [name=credit]").val();

        $.post(url,params,function(data){
            if(data.state == 0){
                $("#memberLevelModal").modal("hide");
                Tips.successTips("保存成功");
                memberLevel.reloadTable();
            }
            else{
                Tips.failTips(data.msg);
            }
        });


    },
    
    info : function(){
        
    }
    
};