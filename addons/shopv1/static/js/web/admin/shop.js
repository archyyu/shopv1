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
            column:[
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
                        title:'操作'
                    }
            ]
        });
    },
    
    reloadShopTable : function(){
        $("#shopList").bootstrapTable('refreshOptions',{ajax:Shop.loadShopList});
    },
    
    loadShopList:function(obj){
        
        var url = UrlUtil.createWebUrl('shop','loadShopList');
        var params = {};
        
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
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