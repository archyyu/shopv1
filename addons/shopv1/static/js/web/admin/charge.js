$(function(){

    Charge.initTable();

});

var Charge={

    initTable:function(){

        $("#chargeListTable").bootstrapTable({
           ajax:Charge.queryChargeList,
           columns:[{
               field:'id',
               title:'活动id'

           },{
               field:'chargefee',
               title:'充值金额(元)',
           },{
               field:'awardfee',
               title:'赠送金额(元)'
           },{
               field:'uniacid',
               title:'操作',
               events:{
                   'click .edit-event':function(e,value,row,index){
                       //Shop.openShopModal(1,row);
                       Charge.openModal(1,row);
                   }
               },
               formatter:function(value,row,index){
                   return  '<button class="btn btn-xs btn-success edit-event">编辑</button> ';
               }
           }]
        });

    },

    queryChargeList:function(obj){
        let url = UrlHelper.createShortUrl("loadChargeCompaignList");

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
            $("#chargeModal [name='chargeid']").val(0);
            $("#chargeModal [name='chargefee']").val('');
            $("#chargeModal [name='awardfee']").val('');
        }
        else{
            $("#chargeModal [name='chargeid']").val(obj.id);
            $("#chargeModal [name='chargefee']").val(obj.chargefee);
            $("#chargeModal [name='awardfee']").val(obj.awardfee);
        }

        $("#chargeModal").modal("show");

    },

    saveCharge:function() {
        let url = UrlHelper.createShortUrl("saveData");

        let params = {};

        let id = $("#chargeModal [name='chargeid']").val();
        if(id != 0){
            params.id = id;
        }

        params.chargefee = $("#chargeModal [name='chargefee']").val();
        params.awardfee = $("#chargeModal [name='awardfee']").val();

        $.post(url,params,function(data){
            if(data.state == 0){

                Tips.successTips("保存成功");
                $("#chargeListTable").bootstrapTable("refresh");

            }
            else{

            }
        });


    },
    info:function(){

    }

};