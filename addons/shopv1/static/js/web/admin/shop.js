/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
   
   Shop.initShopTable();
   Shop.reloadShopTable();
   
});



var Shop = {
    
    initShopTable : function(){
        $("#shopList").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[
                    {
                        field:'id',
                        title:'门店编号'
                    },{
                        field:'shopname',
                        title:'门店名称'
                    },{
                        field:'detail',
                        title:'门店介绍'
                    },{
                        field:'address',
                        title:'地址'
                    },{
                        field:'master',
                        title:'负责人'
                    },{
                        field:'phone',
                        title:'电话'
                    },{
                        field:'logo',
                        title:'操作',
                        events:{
                            'click .edit-event':function(e,value,row,index){
                                Shop.openShopModal(1,row);
                            }
                        },
                        formatter:function(value,row,index){
                            return  '<button class="btn btn-xs btn-success edit-event">编辑</button> ';
                        }
                    }
            ]
        });
    },
    
    reloadShopTable : function(){
        $("#shopList").bootstrapTable('refreshOptions',{ajax:Shop.loadShopList});
    },
    
    loadShopList:function(obj){
        
        var url = UrlUtil.createWebUrl('shop','loadShopList');
        var params = obj.data;
        
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    openShopModal:function(au,obj){
        
        if(au == 0){
            $("#addShop [name=sid]").val(0);
        }
        else{
            $("#addShop [name=sid]").val(obj.id);
            $("#addShop [name=shopname]").val(obj.shopname);
            $("#addShop [name=detail]").val(obj.detail);
            $("#addShop [name=master]").val(obj.master);
            $("#addShop [name=thephone]").val(obj.thephone);
            $("#addShop [name=setuptime]").val(obj.setuptime);
            $("#addShop [name=address]").val(obj.address);
        }
        
        $("#addShop").modal("show");
    },
    
    save:function(){
        
        var url = UrlUtil.createWebUrl("shop","save");
        
        var params = {};
        
        var sid = $("#addShop [name=sid]").val();
        if(sid != 0){
            params.shopid = sid;
        }
        
        params.shopname = $("#addShop [name=shopname]").val();
        params.detail = $("#addShop [name=detail").val();
        params.master = $("#addShop [name=master]").val();
        params.phone = $("#addShop [name=thephone]").val();
        params.address = $("#addShop [name=address]").val();
        
        $.post(url,params,function(data){
           if(data.state == 0){
               $("#addShop").modal("hidden");
               Tips.successTips("保存成功");
               Shop.reloadShopTable();
           } 
           else{
               Tips.failTips(data.msg);
           }
        });
        
        
    },
    
    
    info : function(){
        
    }
    
};