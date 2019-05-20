/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    
    CardType.init();

    CardType.initTable();
    CardType.reloadTable();

    $('#producttype').change(function(){
        CardType.initCurrent(this.value);
        CardType.flushSelect(0);
    });
    
    
});


var CardType = {

    productsList : [],

    currentProductList : [],

    init : function(){

        var products = $('#products').val();
        if (products != "") {
            products = JSON.parse(products);
            for (var i = 0; i < products.length; i++) {
                CardType.productsList.push(products[i]);
            };
        };
    },

    initCurrent : function(typeid){
        
        $("#producttype").val(typeid);
        $('#producttype').selectpicker('refresh');

        var list = this.productsList;
        
        this.currentProductList = [];
        
        if (typeid == 0 || list.length == 0) {
            return ;
        }

        for (var i = 0; i < list.length; i++) {
            if (list[i].typeid == typeid) {
                this.currentProductList.push(list[i]);
            };    
        };
    },

    flushSelect : function(productid){
        $("#product").html("");
        $("#product").prepend("<option value='0'>请选择</option>");
        if (this.currentProductList.length > 0) {
            for (var i = 0; i < this.currentProductList.length; i++) {
                $("#product").append("<option value='" + this.currentProductList[i].id + "'>" + this.currentProductList[i].productname + "</option>");
            };
        };

        $("#product").val(productid);
        $('#product').selectpicker('refresh');
    },

    initTable : function(){
        $("#cardList").bootstrapTable({
            data: [],
            columns: [{
                field: 'id',
                title: '卡券ID'
              },
              {
                field: 'cardname',
                title: '卡券名称'
              },
              {
                field: 'productid',
                title: '关联商品'
              },
              {
                field: 'exchange',
                title: '抵现金额',
                formatter:function(value, row,index){
                    return value/100;
                }
              },
              {
                field: 'exchange',
                title: '折扣',
                formatter:function(value,row,index){
                    return value + "%";
                }
              },
              {
                field: 'effectiveprice',
                title: '最低使用价格',
                formatter:function(value, row,index){
                    return value/100;
                }
              },
              {
                field: 'effectiveday',
                title: '卡券有效期',
                formatter:function(value,row,index){
                    return value + "天";
                }
              },
              {
                field: 'deleteflag',
                title: '操作',
                events:{
                    'click .edit-event':function(e,value,row,index){
                        CardType.openCardModal(1,row);
                    },
                    'click .remove-event':function(e,value,row,index){
                        Tips.confirm("确认要删除吗",row.id,CardType.deleteCard);
                    }
                },
                formatter: function (value, row) {
                  return ['',
                    '<button class="btn btn-xs btn-success edit-event">编辑</button> ',
                    '<button class="btn btn-xs btn-danger remove-event">删除</button>'
                  ].join("");
                }
              }
            ]
          });
    },
    
    reloadTable : function(){
        $("#cardList").bootstrapTable("refreshOptions",{ajax:CardType.loadCardTypeList});
    },
    
    loadCardTypeList : function(obj){
        
        var url = UrlUtil.createWebUrl("card","loadCardTypeList");
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
    
    openCardModal:function(addOrUpdate,obj){
        
        if(addOrUpdate == 0){
            //新增
            $("#addCardModal [name=cardid]").val(0);
            $("#addCardModal [name=cardname]").val("");
            $("#addCardModal [name=exchange]").val('');
            $("#addCardModal [name=discount]").val('');
            $("#addCardModal [name=effectiveprice]").val('');
            $("#addCardModal [name=effectiveday]").val('');
            
            $("#producttype").val(0);
        
            this.initCurrent(0);
            this.flushSelect(0);
        }
        else{
            $("#addCardModal [name=cardid]").val(obj.id);
            $("#addCardModal [name=cardname]").val(obj.cardname);
            $("#addCardModal [name=exchange]").val(obj.exchange/100);
            $("#addCardModal [name=discount]").val(obj.discount);
            $("#addCardModal [name=effectiveprice]").val(obj.effectiveprice/100);
            $("#addCardModal [name=effectiveday]").val(obj.effectiveday);
        
            this.initCurrent(obj.typeid);
            this.flushSelect(obj.productid);
        }
        $("#addCardModal").modal("show");
        
    },
    
    saveCard:function(){
        
        var url = UrlUtil.createWebUrl("card","saveCardType");  
        var params = {};
        
        params.cardid = $("#addCardModal [name=cardid]").val();
        params.cardname = $("#addCardModal [name=cardname]").val();
        params.exchange = $("#addCardModal [name=exchange]").val();
        params.discount = $("#addCardModal [name=discount]").val();
        params.effectiveprice = $("#addCardModal [name=effectiveprice]").val();
        params.effectiveday = $("#addCardModal [name=effectiveday]").val();
        params.typeid = $("#producttype").val();
        params.productid = $("#product").val();
        
        $.post(url,params,function(data){
           if(data.state == 0){
               Tips.successTips("保存成功");
               $("#addCardModal").modal("hide");
               CardType.reloadTable();
           } 
           else{
               Tips.failTips(data.msg);
           }
        });
        
    },
    
    deleteCard:function(id){
        var url = UrlUtil.createWebUrl('card','removeCardType');
        var params = {};
        params.cardid = id;
        
        $.post(url,params,function(data){
            if(data.state == 0){
                Tips.successTips("删除成功");
                CardType.reloadTable();
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
    
    info : function(){
        
    }
    
};