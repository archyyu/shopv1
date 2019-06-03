


$(function(){

    memberClass.initTable();

});

var memberClass={

    initTable:function(){

        $("#memberClassList").bootstrapTable({
            ajax:memberClass.queryClassList,
            columns:[{
                field:'classid',
                title:'分组id',
            },{
                field:'title',
                title:'分组名称',
            },{
                field:'uniacid',
                title:'操作',
                events:{
                    'click .edit-membertype':function(e,value,row,index){
                        //memberLevel.openMemberTypeModal(1,row);
                        memberClass.openModal(1,row);
                    }
                },
                formatter:function(value,row,index){

                    return '<button class="btn btn-xs btn-primary edit-membertype" >编辑</button>';

                }
            }]
        });

    },

    queryClassList:function(obj){
        let url = UrlHelper.createShortUrl("loadMemberClass");

        let params = {};

        $.post(url,params,function(data){

            if(data.state == 0){
                obj.success(data.obj);
            }
            else{

            }

        });
    },




    openModal:function(type,obj){

        if(type == 0){
            $("#memberClassModal [name='classid']").val(0);
            $("#memberClassModal [name='title']").val('');
        }
        else{

            $("#memberClassModal [name='classid']").val(obj.classid);
            $("#memberClassModal [name='title']").val(obj.title);

        }

        $("#memberClassModal").modal("show");

    },

    saveData:function(){

        let url = UrlHelper.createShortUrl("saveMemberClass");

        let params = {};
        let classid = $("#memberClassModal [name='classid']").val();

        if(classid != 0){
            params.classid = classid;
        }

        params.title = $("#memberClassModal [name='title']").val();

        $.post(url,params,function(data){
            if(data.state == 0){

                Tips.successTips("保存成功");
                $("#memberClassList").bootstrapTable("refresh");

            }
            else{
                Tips.failTips(data.msg);
            }
        });

    },



    info:function(){

    }

}