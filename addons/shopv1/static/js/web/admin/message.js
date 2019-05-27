
$(function(){

    Message.initTable();
    Message.refreshTable();

});

$("#shopSelect").change(function(){

    Message.refreshTable();

});


var Message={

    initTable:function(){

        $("#messageListTable").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[{
                field:'id',
                title:'留言流水'
            },{
                field:'createtime',
                title:'留言时间',
                formatter:function(value,row,index){
                    return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
                }
            },{
                field:'address',
                title:'座位号'
            },{
                field:'content',
                title:'内容'
            },{
                field:'membername',
                title:'会员'
            },{
                field:'phone',
                title:'手机号'
            }]
        })

    },

    refreshTable:function(){
        $("#messageListTable").bootstrapTable("refreshOptions",{ajax:Message.queryMsgs});
    },

    queryMsgs:function(obj){

        let url = UrlHelper.createShortUrl("getData");
        let params = {};
        params.shopid = $("#shopSelect").val();

        $.post(url,params,function(data){

            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });

    },

    info:function(){

    }

}
