/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){
    
    Duty.initDutyTable();
    Duty.refreshDutyTable();
    
});

$('#shopSelect').change(function(){
    Duty.refreshDutyTable();
 });

var Duty = {
    
    initDutyTable:function(){
        $("#dutyListTable").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[{
                field:'id',
                title:'交班流水'
            },{
                field:'shopname',
                title:'门店'
            },{
                field:'username',
                title:'交班人'
            },{
                field:'starttime',
                title:'开始时间',
                formatter:function(value,row,index){
                    return DateUtil.parseTimeInYmdHms(value);
                }
            },{
                field:'endtime',
                title:'结束时间',
                formatter:function(value,row,index){
                    return DateUtil.parseTimeInYmdHms(value);
                }
            },{
                field:'productcash',
                title:'现金收入'
            },{
                field:'productwechat',
                title:'微信收入'
            },{
                field:'productalipay',
                title:'支付宝收入'
            },{
                field:'deleteflag',
                title:'商品售卖详情',
                events:{
                    'click .detail-event':function(value,row,index){
                        //Duty.queryDutyProducts(index.id);
                        Duty.dutyid = index.id;
                        Duty.showProductList();
                    }
                },
                formatter:function(value,row,index){
                    return  '<button class="btn btn-xs btn-success detail-event">商品售卖详情</button> ';
                }
            }]
        });
    },
    
    refreshDutyTable:function(){
        $("#dutyListTable").bootstrapTable("refreshOptions",{ajax:Duty.queryDutys});
    },
    
    queryDutys:function(obj){
        var url = UrlUtil.createWebUrl("duty","loadDutys");
        
        var params = obj.data;
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

    queryDutyProducts:function(obj){

        let url = UrlUtil.createShortUrl("loadDutyProductList");

        let params = {};
        //console.log(dutyid);
        params.dutyid = Duty.dutyid;

        $.post(url,params,function(data){

            if(data.state == 0){

                obj.success(data.obj);

            }
            else{
                Tips.failTips(data.msg);
            }

        });


    },

    dutyid : 0,

    showProductList:function(list){
        $("#proListTable").bootstrapTable({
            height: 360,
            //data:list,
            ajax:Duty.queryDutyProducts,
            columns:[
                {
                    field:'producttype',
                    title:'商品分类'
                },
                {
                    field:'productname',
                    title:'商品名称'
                },
                {
                    field:'price',
                    title:'单价'
                },
                {
                    field:'num',
                    title:'销量'
                },
                {
                    field:'sum',
                    title:'销售额'
                }
            ]
        });
        $("#proListTable").bootstrapTable("refresh")
        $("#productListModal").modal("show");

    },

    info:function(){
        
    }
    
};