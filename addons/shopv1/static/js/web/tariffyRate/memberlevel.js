/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    
    memberLevel.initTable();

});

$("#barSelect").change(function(){
    memberLevel.reloadTable();
});

var memberLevel = {
    
    queryLevelList : function(obj){
        var url = UrlUtil.createWebUrl('memberType','getTypeList');
        var params = {};
        params.gid = $("#barSelect").val();
        
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
           ajax:memberLevel.queryLevelList,
           columns:[{
                   field:'membertypeid',
                   title:'等级ID'
               },{
                   field:'membertypename',
                   title:'会员名称'
               },
               {
                   field:'growth',
                   title:'所需成长值'
               },{
                   field:'discountdetail',
                   title:'等级优惠'
               },{
                   field:'state',
                   title:'状态',
                   events:{
                       'click .change-state':function(e,value,row,index){
                           memberLevel.changeState(row.membertypeid);
                       }
                   },
                   formatter:function(value,row,index){
                       if(value==0){
                           return '<span class="tag tag-sm tag-success change-state">已启用</span>';
                       }
                       else{
                           return '<span class="tag tag-sm tag-danger change-state">停用</span>';
                       }
                   }
               },{
                   field:'gid',
                   title:'操作',
                   events:{
                       'click .edit-membertype':function(e,value,row,index){
                           console.log('events:'+row); 
                           memberLevel.openMemberTypeModal(1,row);
                        }
                   },
                   formatter:function(value,row,index){
                       console.log(row);
                        return '<button class="btn btn-xs btn-primary edit-membertype" >编辑</button>';
                    }
               }
           ]
        });
        
    },
    
    
    reloadTable:function(){ 
        $("#memberTypeList").bootstrapTable('refresh');
    },
    
    openMemberTypeModal : function(addOrSave,memberType=null){
        if(addOrSave == 0){
            //新建
            $("#membertypeid").val('');
            $("#membertypename").val('');
            $("#growth").val(0);
            $("#productdiscount").val(100);
            $("#onlinediscount").val(100);
            
            $("#memberLevelModal").modal('show');
        }
        else{
            //编辑
            
            $("#membertypeid").val(memberType.membertypeid);
            $("#membertypename").val(memberType.membertypename);
            $("#growth").val(memberType.growth);
            $("#productdiscount").val(memberType.productdiscount);
            $("#onlinediscount").val(memberType.onlinediscount);
            
            $("#memberLevelModal").modal('show');
            
        }
    },
    
    changeState : function(membertypeid){
        var url = UrlUtil.createWebUrl('memberType','changeState');
        var params = {};
        params.membertypeid = membertypeid;
        
        
        $.post(url,params,function(data){
            if(data.state==0){
                Tips.successTips('已更新');
                memberLevel.reloadTable();
            }
            else{
                Tips.failTips(data.msg);
            }
        });
    },
    
    save : function(){
        
        $("#memberLevelModal").modal('hide');
        
        var url = UrlUtil.createWebUrl('memberType','save');
        var params = {};
        params.gid = $("#barSelect").val();
        
        if($("#membertypeid").val() != ''){
            params.membertypeid = $("#membertypeid").val();
        }
        
        params.membertypename = $("#membertypename").val();
        params.growth = $("#growth").val();
        params.productdiscount = $("#productdiscount").val();
        params.onlinediscount = $("#onlinediscount").val();
        
        $.post(url,params,function(data){
            
            if(data.state == 0){
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