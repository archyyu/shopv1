$(function () {
  
    Inventory.goodsTableInit();
    Inventory.classListInit();
    Inventory.classListReload();
  
});

var Inventory = {
  goodsTableInit: function () {
    $("#goodsTable").bootstrapTable({
      data: [{
          id: 1
        },
        {
          id: 2
        }
      ],
      columns: [{
          field: 'id',
          title: 'ID'
        },
        {
          field: 'id',
          title: '商品名称'
        },
        {
          field: 'id',
          title: '商品分类'
        },
        {
          field: 'id',
          title: '正常价'
        },
        {
          field: 'id',
          title: '会员价'
        },
        {
          field: 'id',
          title: '销量'
        },
        {
          field: 'id',
          title: '状态'
        },
        {
          field: 'id',
          title: '商品类型'
        },
        {
          field: 'id',
          title: '关联商品'
        },
        {
          field: 'id',
          title: '排序'
        },
        {
            field:'id',
            title:'多属性'
        },
        {
          field: 'id',
          title: '操作'
        }
      ]
    });
  },

  loadGoodsList: function (obj) {

    var url = UrlUtil.createWebUrl('shop', 'loadShopList');
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