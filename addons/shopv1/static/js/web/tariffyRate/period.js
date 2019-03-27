$(function(){
    
    period.initTable();
    period.reloadData();
})

$("#barSelect").change(function(){
    period.reloadData();
    period.reloadTable();
});

var period = {
    
    reloadData : function(){
        var url = UrlUtil.createWebUrl('period','getData');
        
        var parms = {};
        parms.gid = $("#barSelect").val();
        
        $.post(url,parms,function(data){
            if(data.state == 0){
                
                var areaTmpl = new jSmart($("#periodAreaTmpl").html());
                $("#periodArea").html(areaTmpl.fetch({areaList:data.obj.areaList}));
                
                var typeTmpl = new jSmart($("#periodMemberTypeTmpl").html());
                $("#periodMemberType").html(typeTmpl.fetch({memberTypeList:data.obj.memberTypeList}));
                
            }
        });
        
    },
    
    openPeriodModal : function(addOrSave,period){
        if(addOrSave == 0){
            $("#addOrSave").val(0);
            $("#addperiod").find('input[name="periodtype"]').first().click();
            $('#periodArea input').each(function(){
                $(this).attr('checked',false);
             });
             
            $('#periodMemberType input').each(function(){
                $(this).attr('checked',false);
            });
            
            $("#addperiod").modal("show");
        }
        else{
            
            console.log(period);
            
            $("#addOrSave").val(1);
            $("#pid").val(period.id);
            
            if(period.periodtype == 0){
                $("#addperiod").find('input[name="periodtype"]').first().click();
                $("#starttime").val(period.starttime);
                $("#endtime").val(period.endtime);
            }
            else{
                $("#addperiod").find('input[name="periodtype"]').last().click();
                $("#periodtime").val(period.periodtime);
            }
            $("#periodprice").val(period.price);
            
            $("#periodMemberType input").each(function(){
                if(period.typeid.indexOf($(this).val()) != -1){
                    $(this).prop("checked",true);
                }
                else{
                    $(this).prop('checked',false);
                }
            });
            
            $("#periodArea input").each(function(){
                if(period.regionid.indexOf($(this).val()) != -1){
                    $(this).prop("checked",true);
                }
                else{
                    $(this).prop("checked",false);
                }
            });
            
            $("#addperiod").modal("show");
        }
    },
    
    confirmPeriodType : function(type){
        $("#periodDurationInput").hide();
        $("#periodPeriodInput").hide();
        
        if(type == 0){
            $("#periodPeriodInput").show();
        }
        else{
            $("#periodDurationInput").show();
        }
        
    },
    
    reloadTable : function(){
        $('#periodList').bootstrapTable('refreshOptions', {ajax:this.queryPeriodList});
    },
    
    queryPeriodList : function(params){
        
        var gid = $("#barSelect").val();
        var url = UrlUtil.createWebUrl('period','getPeriodList')
        var prs = {};
        prs['gid'] = gid;
        $.post(url,prs,function(data){
           params.success(data);
        });
        
    },
    
    
    initTable:function(){
        $('#periodList').bootstrapTable({
            ajax:this.queryPeriodList,
            columns:[{
             checkbox:true       
            },{
                field:'periodtypedetail',
                title:'包时段类型'
            },{
                field:'price',
                title:'金额'
            },{
                field:'perioddetail',
                title:'时段/时长'
            },{
                field:'areadetail',
                title:'区域'
            },{
                field:'typedetail',
                title:'会员类型'
            },{
                field:'id',
                title:'操作',
                events : {
                    'click .edit-form-js':function(e,value,row,index){
                        period.openPeriodModal(1,row);
                    },
                    'click .delete-form-js':function(e,value,row,index){
                        Tips.confirm("确认要删除此包时段么？",value,period.deleteOne);
                    }
                },
                formatter:function(value,row,index){
                    console.log(row);
                    return '<button class="btn btn-xs btn-primary edit-form-js" >编辑</button>' + 
                        '<button class="btn btn-xs btn-danger delete-form-js" >删除</button>';
                }
            }]
        })
    },
    
    addOne(){
        
        $("#addperiod").modal("hide");
        var url = UrlUtil.createWebUrl("period",'save');
        
        var params = {};
        params['gid'] = $("#barSelect").val();
        params['periodtype'] = $("#addperiod").find("input[name='periodtype']:checked").val();
        params['price'] = $('#periodprice').val();
        
        if(params['periodtype'] == 0){
            params['starttime'] = $("#starttime").val();
            params['endtime'] = $("#endtime").val();
        }
        else{
            params['periodtime'] = $("#periodtime").val();            
        }
        
        params['regionid'] = '';
        $('#periodArea input').each(function(){
           if($(this).is(":checked")){
               params['regionid'] += $(this).val() + ","; 
           }
        });
        
        params['typeid'] = '';
        $('#periodMemberType input').each(function(){
           if($(this).is(':checked')){
               params['typeid'] += $(this).val() + ",";
           }
        });
        
        if($("#addOrSave").val() != 0){
            params['id'] = $("#pid").val();
        } 
        
        $.post(url,params,function(data){
            console.log(data);
            if(data.state == 0){
                Tips.successTips("保存成功"); 
                period.reloadTable();
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    
    deleteOne(id){
        var url = UrlUtil.createWebUrl('period','remove');
        var prms = {};
        prms['id'] = id;
        $.post(url,prms,function(data){
            if(data.state == 0){
                Tips.successTips("已删除");
                period.reloadTable();
            }
            else{
                Tips.dangerTips(data.msg);
            }
        });
    },
    
    info : function(){
        
    }
    
};