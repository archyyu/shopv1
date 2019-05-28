/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    
    memberLevel.initTable();

});

var memberLevel = {
    
    queryLevelList : function(params){
        var url = '';
        var params = {};
        
        $.post(url,params,function(data){
            if(data.state==0){
                params.success(data.obj.list);
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
                       if(value==1){
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
    
    openMemberTypeModal : function(){           
        $("#memberLevelModal").modal('show');
    },
    
    info : function(){
        
    }
    
};