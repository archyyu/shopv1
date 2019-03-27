/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){
    extra.initTable();
    extra.reloadAreaList();
    
});

$("#barSelect").change(function(){
    extra.reloadAreaList();
});

var extra = {
    
    reloadAreaList:function(){
        var url = UrlUtil.createWebUrl('extra','getAreaList');
        
        var prms = {};
        prms.gid = $("#barSelect").val();
        
        $.post(url,prms,function(data){
            if(data.state == 0){
                var smartyjs = new jSmart($("#areaSelectTmpl").html());
                var output = smartyjs.fetch({areaList:data.obj.areaList});
                $("#areaSelect").html(output);
                extra.refreshExtraList();
                
                var memberTypeTmpl = new jSmart($("#memberTypeSelectTmpl").html());
                var output1 = memberTypeTmpl.fetch({memberTypeList:data.obj.memberTypeList})
                console.log(output1);
                $("#memberTypeSelect").html(output1);
                
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    initTable : function(){
        $("#extraList").bootstrapTable({
            data:[],
            columns:[
                {
                    field:'membertypedetail',
                    title:'会员等级'
                },{
                    field:'price',
                    title:'金额(元)'
                },{
                    field:'id',
                    title:'操作',
                    events:{
                        'click .edit-event':function(e,value,row,index){
                            extra.openExtraMadol(1,row);
                        },
                        'click .delete-event':function(e,value,row,index){
                            
                        }
                    },
                    formatter:function(value,row,index){
                        return '<button class="btn btn-xs btn-primary edit-event">编辑</button>' +
                                '<button class="btn btn-xs btn-danger delete-event">删除</button>';
                    }
                }
            ]
            }
            );
    },
    
    selectArea : function(obj){
        $("#areaSelect div").removeClass('active');
        $(obj).addClass('active');
        extra.refreshExtraList();
    },
    
    refreshExtraList : function(){
        $("#extraList").bootstrapTable('refreshOptions',{ajax:extra.loadExtraList});
    },
    
    loadExtraList : function(obj){
        
        var gid = $("#barSelect").val();
        var areaid = $("#areaSelect .active").attr('areaid');
        var url = UrlUtil.createWebUrl('extra','getList');
        
        var params = {};
        params.gid = gid;
        params.areaid = areaid;
        
        $.post(url,params,function(data){
            
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
            
        });
        
    },
    
    openExtraMadol : function(addOrUpdate,obj){
        if(addOrUpdate == 0){
            $("#extraid").val('');
            $("#extraprice").val('');
            $("#memberTypeSelect input").each(function(){
                $(this).prop('checked',false);
            });
        }
        else{
            $("#extraid").val(obj.id);
            $("#extraprice").val(obj.price);
            $("#memberTypeSelect input").each(function(){
                
                if(obj.typeid.indexOf($(this).val()) != -1){
                    $(this).prop('checked',true);
                }
                
            });
        }
        $("#addExtraModal").modal('show');
    },
    
    save : function(){
        
        var url = UrlUtil.createWebUrl('extra','save');
        
        var parms = {};
        parms.gid = $("#barSelect").val();
        parms.areaid = $("#areaSelect .active").attr('areaid');
        
        parms.typeid = '';
        parms.price = $("#extraprice").val();
        $("#memberTypeSelect input").each(function(){
            if($(this).is(":checked")){
                parms.typeid += $(this).val() + ",";
            }
        });
        
        if($("#extraid").val() != ''){
            parms.id = $("#extraid").val();
        }
        
        $.post(url,parms,function(data){
            if(data.state == 0){
                $("#addExtraModal").modal('hide');
                Tips.successTips("保存成功");
                extra.refreshExtraList();
                
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    info : function(){
        
    }
}