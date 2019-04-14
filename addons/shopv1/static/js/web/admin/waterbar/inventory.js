$(function () {
  
    Inventory.goodsTableInit();
    Inventory.goodsTableReload();
    
    Inventory.classListInit();
    Inventory.classListReload();
  
});

var Inventory = {
  goodsTableInit: function () {
    $("#goodsTable").bootstrapTable({
      data: [
      ],
      columns: [{
          field: 'id',
          title: '商品Id'
        },
        {
          field: 'productname',
          title: '商品名称'
        },
        {
          field: 'typename',
          title: '商品分类'
        },
        {
          field: 'normalprice',
          title: '正常价'
        },
        {
          field: 'memberprice',
          title: '会员价'
        },
        {
          field: 'salenum',
          title: '销量'
        },
        {
          field: 'producttype',
          title: '商品类型',
          formatter:function(value, row,index){
              value = Number(value);
              if(value == -1){
                  return "虚拟商品";
              }
              else if(value == 0){
                  return "成品";
              }
              else if(value == 1){
                  return "自制";
              }
              else{
                  return "原料";
              }
          }
        },
        {
          field: 'index',
          title: '排序'
        },
        {
            field:'attributes',
            title:'多属性'
        },
        {
          field: 'deleteflag',
          title: '操作',
          events:{
              'click .edit-event':function(e,value,row,index){
                  Inventory.openGoodModal(1,row);
              }
          },
          formatter: function(value, row,index){
            return '<button class="btn btn-xs btn-success edit-event">编辑</button>';
          }
        }
      ]
    });
  },
  
  goodsTableReload:function(){
    $("#goodsTable").bootstrapTable("refreshOptions",{ajax:Inventory.loadGoodsList});  
  },
  
  openGoodModal:function(addOrUpdate,obj){
      
      if(addOrUpdate == 0){
          $("#addProductModal [name=productid]").val(0);
          $("#addProductModal [name=productname]").val('');
          $("#addProductModal [name=productcode]").val('');
          $("#addProductModal [name=make]").val(0);
          $("#addProductModal [name=normalprice]").val(0);
          $("#addProductModal [name=memberprice]").val(0);
          $("#addProductModal [name=index]").val(0);
          $("#addProductModal [name=attributes]").val('');
          $("#addProductModal [name=unit]").val('');
          $("#addProductModal [name=producttype][value=-1]").attr('checked', 'checked');
          
      }
      else{
          $("#addProductModal [name=productid]").val(obj.id);
          $("#addProductModal [name=productname]").val(obj.productname);
          $("#addProductModal [name=productcode]").val(obj.productcode);
          $("#addProductModal [name=make]").selectpicker('val', obj.make);
          $("#addProductModal [name=normalprice]").val(obj.normalprice);
          $("#addProductModal [name=memberprice]").val(obj.memberprice);
          $("#addProductModal [name=index]").val(obj.index);
          $("#addProductModal [name=attributes]").val(obj.attributes);
          $("#addProductModal [name=unit]").val(obj.unit);
          $("#addProductModal [name=typeid]").selectpicker('val',obj.typeid);
          
          $("#addProductModal [name=producttype][value=" +obj.producttype + "]").attr('checked', 'checked');
          
      }
      
      $("#addProductModal").modal("show");
  },
  
  saveGood:function(){
      
      var url = UrlUtil.createWebUrl("product",'saveProduct');
      
      var params = {};
      
      params.productid = $("#addProductModal [name=productid]").val();
      params.productname = $("#addProductModal [name=productname]").val();
      params.productcode = $("#addProductModal [name=productcode]").val();
      params.make = $("#addProductModal [name=make]").val();
      params.producttype = $("#addProductModal [name=producttype]:checked").val();
      params.normalprice = $("#addProductModal [name=normalprice]").val();
      params.memberprice = $("#addProductModal [name=memberprice]").val();
      params.index = $("#addProductModal [name=index]").val();
      params.attributes = $("#addProductModal [name=attributes]").val();
      params.unit = $("#addProductModal [name=unit]").val();
      
      
      $.post(url,params,function(data){
            
            if(data.state == 0){
                Tips.successTips("保存成功");
                $("#addProductModal").modal("hidden");
                Inventory.goodsTableReload();
            }
            else{
                Tips.failTips(data.msg);
            }
            
      });
      
      
  },
  
  addMoreProduct:function(){
        
  },
  
  
  loadGoodsList: function (obj) {

    var url = UrlUtil.createWebUrl('product', 'loadProduct');
    var params = {};

    $.post(url, params, function (data) {
      if (data.state == 0) {
        obj.success(data.obj);
      } else {
        Tips.failTips(data.msg);
      }
    });

  },
  
  classListQuery:function(obj){
      var url = UrlUtil.createWebUrl("product",'loadProductType');
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
  
  classListReload:function(){
      $("#productTypeTable").bootstrapTable("refreshOptions",{ajax:Inventory.classListQuery});
  },
  

  classListInit: function () {
    $("#productTypeTable").bootstrapTable({
      data: [],
      columns: [
        {
          field: 'pos',
          title: '排序'
        },
        {
          field: 'typename',
          title: '类别'
        },
        {
          field: 'id',
          title: '操作',
          events:{
              'click .edit-event':function(e,value,row,index){
                  Inventory.openTypeModal(1,row);
              }
          },
          formatter: function(value, row){
            return '<button class="btn btn-xs edit-event btn-success">编辑</button> ';
          }
        }
      ]
    });
  },
  
  openTypeModal:function(addOrUpdate,obj){
      if(addOrUpdate == 0){
          $("#addProductClassModal [name=typeid]").val(0);
          $("#addProductClassModal [name=pos]").val(0);
          $("#addProductClassModal [name=typename]").val("");
      }
      else{
          $("#addProductClassModal [name=typeid]").val(obj.id);
          $("#addProductClassModal [name=pos]").val(obj.pos);
          $("#addProductClassModal [name=typename]").val(obj.typename);
      }
      
      $("#addProductClassModal").modal("show");
        
  },
  
  saveTypeModal:function(){
      
      var url = UrlUtil.createWebUrl("product","saveProductType");
      
      var params = {};
      params.typeid = $("#addProductClassModal [name=typeid]").val();
      params.pos = $("#addProductClassModal [name=pos]").val();
      params.typename = $("#addProductClassModal [name=typename]").val();
      
      $.post(url,params,function(data){
         if(data.state == 0){
             Tips.successTips("保存成功");
             Inventory.classListReload();
         } 
         else{
             Tips.failTips(data.mss);
         }
      });
      
  },
  
  openClassModal: function () {
    $("#productClassModal").modal("show");
  },
  
  openAddClassModal:function(){
      
  },

  openProductModal: function (type) {
    if(type === 0){
      $(".commonname").text('商品');
      $(".associatename").text('原料');
    }else{
      $(".commonname").text('套餐');
      $(".associatename").text('商品');
    }
    $("#addProductModal").modal("show");
  }
};