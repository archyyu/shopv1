$(function () {
  
    Inventory.goodsTableInit();
    Inventory.goodsTableReload();
    
    Inventory.classListInit();
    Inventory.classListReload();
  
    Inventory.unitTableInit();
    
    $('#selectProductBtn').click(function(){
        
        Inventory.selectProductList = [];
        
        $("#selectProductList div").each(function(){
            
            if( $(this).find("input").is(':checked')){
            
                var item = {};
                item.productname = $(this).find("span").html();
                item.productid = $(this).find("input").attr("productid");
                Inventory.selectProductList.push(item);
            
            }
        });
        var jsonStr = JSON.stringify(Inventory.selectProductList);
        
        $('#addStockMaterial').modal('hide');
        $("#addProductModal [name=linkproduct]").empty();
        Inventory.linkProductList();
    });
    
    $("#storeSelect").change(function(){
        
        Inventory.goodsTableReload();
        
    });
    
    $('#typeSelectQuery').change(function(){
       Inventory.goodsTableReload(); 
    });
    
});

var Inventory = {
    
   selectProductList:[],
    
  goodsTableInit: function () {
    $("#goodsTable").bootstrapTable({
      data: [
      ],
      sidePagination: "server",
        pageSize: 10,
        pagination: true,
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
          title: '正常价(分)'
        },
        {
          field: 'memberprice',
          title: '会员价(分)'
        },
        {
          field: 'salenum',
          title: '销量'
        },
        {
            field:'inventory',
            title:'库存'
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
              },
              'click .unit-event':function(e,value,row,index){
                  Inventory.openProductUnitModal(row.id);
                  $("#addSpecModal [name=unit]").val(row.unit);
              },
              'click .damage-event':function(e,value,row,index){
                  $("#damageModal [name=productid]").val(row.id);
                  $("#damageModal").modal("show");
              },
              'click .transfer-event':function(e,value,row,index){
                  Inventory.openTransModal(row.id,row.unit);
              },
              'click .stock-event':function(e,value,row,index){
                  Inventory.openStockModal(row);
              },
              'click .check-event':function(e,value,row,index){
                  Inventory.openCheckModal(row);
              }
          },
          formatter: function(value, row,index){
              
              if(row.producttype != 1){
                return '<button class="btn btn-xs btn-success unit-event">规格</button>\
                    <button class="btn btn-xs btn-success stock-event">进货</button>\
                    <button class="btn btn-xs btn-success check-event">盘点</button>\
                    <button class="btn btn-xs btn-success damage-event">报损报溢</button>\
                    <button class="btn btn-xs btn-success transfer-event">调货</button>\
                    <button class="btn btn-xs btn-success edit-event">编辑</button>';
              }
              else{
                    return '<button class="btn btn-xs btn-success edit-event">编辑</button>';
              }              
          }
        }
      ]
    });
  },
  
  inventoryList : [],
  
  transferStoreChange:function(){
      $("#transferModal [name=inventory]").html(0);
        for(var i = 0;i<inventoryList.length;i++){
            if(inventoryList[i].storeid == $("#transferModal [name=sourceid]").val()){
                $("#transferModal [name=inventory]").html(inventoryList[i].inventory);
                return;
            }
        }
  },
  
  inventoryTransfer:function(){
      var url = UrlUtil.createWebUrl('product','inventoryTransfer');
      
      var params = {};
      params.productid = $("#transferModal [name=productid]").val();
      params.sourceid = $("#transferModal [name=sourceid]").val();
      params.destinationid = $("#transferModal [name=destinationid").val();
      params.inventory = $("#transferModal [name=num]").val();
      
      $.post(url,params,function(data){
         if(data.state == 0){
             Tips.successTips('调货成功');
             $("#transferModal").modal('hide');
         } 
         else{
             Tips.failTips("失败");
         }
      });
      
  },
  
  openStockModal:function(product){
      
      $("#proInModal [name=productid]").val(product.id);
      $("#proInModal [name=productname]").html(product.productname);
      $("#proInModal [name=unit]").html(product.unit);
      
      $("#proInModal").modal('show');
  },
  
  //单品盘点
  openCheckModal:function(product){
      
      $('#stockModal [name=productid]').val(product.id);
      $('#stockModal').modal('show');
      
  },
  
  productCheck:function(){
      var url = UrlUtil.createWebUrl('product','productCheck');
      
      var params = {};
      params.productid = $('#stockModal [name=productid]').val();
      params.storeid = $("#stockModal [name=store]").val();
      params.inventory = $("#stockModal [name=inventory]").val();
      
      $.post(url,params,function(data){
         if(data.state == 0){
             Tips.successTips('盘点成功');
             $("#stockModal").modal('hide');
         } 
         else{
             Tips.failTips(data.msg);
         }
      });
      
  },
  
  productStock:function(){
      var url = UrlUtil.createWebUrl("product","productStock");
      
      var params = {};
      params.productid = $("#proInModal [name=productid]").val();
      params.storeid = $("#proInModal [name=store]").val();
      params.inventory = $("#proInModal [name=inventory]").val();
      
      $.post(url,params,function(data){
         if(data.state == 0){
             Tips.successTips("进货成功");
             $("#proInModal").modal('hide');
         } 
         else{
             Tips.failTips(data.msg);
         }
      });
      
  },
  
  openTransModal:function(productid,unit){
       $("#transferModal [name=unit]").val(unit);
       $("#transferModal [name=productid]").val(productid);
       
      var url = UrlUtil.createWebUrl('product','inventorylist');
      
      var params = {};
      params.productid = productid;
      
      $.post(url,params,function(data){
          if(data.state == 0){
              inventoryList = data.obj;
              console.log(inventoryList);
              for(var i = 0;i<inventoryList.length;i++){
                  if(inventoryList[i].storeid == $("#transferModal [name=sourceid]").val()){
                      $("#transferModal [name=inventory]").html(inventoryList[i].inventory);
                       $("#transferModal").modal("show");
                      return;
                  }
              }
              
              $("#transferModal [name=inventory]").html(inventoryList[i].inventory);
              $("#transferModal").modal("show");
              
          }
          else{
              
          }
          
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
          $("#addProductModal [name=producttype][value='0']").prop('checked', 'checked');
          
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
          $("#addProductModal [name=linkproduct]").empty();
          try{
            var list = JSON.parse(obj.productlink);
            for(let item of list){
                var str = "<div class='form-group form-group-sm associalproduct' name='associalproduct'>"+
                  "<label class='col-sm-3 control-label'>" +
                  "</label>" + 
                  "<div class='col-sm-4'>" +
                      "<input type='hidden' name='productid' productid='" + item.materialid + "' />"+
                      "<span name='productname'>" + item.materialname + "</span>"+
                  "</div>" +
                  "<div class='col-sm-2'>"+
                      "<span></span><input name=num class='form-control' value='" + item.num + "' >"+
                  "</div>"+
                "</div>";

              $("#addProductModal [name=linkproduct]").append(str);
            }
        }
        catch (ex){
            
        }
          
          $("#addProductModal [name=producttype][value='" +obj.producttype + "']").prop('checked', 'checked');
          
        }
        
        Inventory.selectProductType();
        
      $("#addProductModal").modal("show");
  },
  
  linkProductList:function(){
      
      for(var i=0;i<Inventory.selectProductList.length;i++){
          var item = Inventory.selectProductList[i];
          var str = "<div class='form-group form-group-sm associalproduct' name='associalproduct'>"+
                "<label class='col-sm-3 control-label'>" +
                "</label>" + 
                "<div class='col-sm-4'>" +
                    "<input type='hidden' name='productid' productid='" + item.productid + "' />"+
                    "<span name='productname'>" + item.productname + "</span>"+
                "</div>" +
                "<div class='col-sm-2'>"+
                    "<span></span><input name=num class='form-control'>"+
                "</div>"+
              "</div>";
          
          $("#addProductModal [name=linkproduct]").append(str);
          
      }
      
  },
  
  selectProductType:function(){
      var producttype = $("#addProductModal [name=producttype]:checked").val();
      if(producttype == 1){
          $("#addProductModal .associalproduct").css("display","block");
      }
      else{
          $("#addProductModal .associalproduct").css("display","none");
      }
      
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
      params.typeid = $("#addProductModal [name=typeid]").val();
      
      var list = [];
      $("#addProductModal [name=associalproduct]").each(function(){
          var item = {};
          item.materialid = $(this).find("[name=productid]").attr('productid');
          item.materialname = $(this).find("[name=productname]").html();
          item.num = $(this).find("[name=num]").val();
          list.push(item);
      });
      
      params.link = JSON.stringify(list);
      
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
    var params = obj.data;
    
    params.storeid = $("#storeSelect").val();
    params.typeid = $("#typeSelectQuery").val();
    
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
  
  saveUnit:function(){
      var url = UrlUtil.createWebUrl('product','saveProductUnit');
      
      var params = {};
      params.productid = $("#specModal [name=productid]").val();
      params.unitname = $("#addSpecModal [name=unitname]").val();
      params.num = $("#addSpecModal [name=num]").val();
      params.price = $("#addSpecModal [name=price]").val();
      
      $.post(url,params,function(data){
          if(data.state == 0){
              $("#addSpecModal").modal("hide");
              $("#unitTable").bootstrapTable("refreshOptions",{ajax:Inventory.loadProductUnit});
          }
          else{
              Tips.failTips(data.msg);
          }
      });
      
  },
  
  openProductUnitModal:function(productid){
     
     $("#specModal [name=productid]").val(productid);
     $("#specModal").modal("show");
     $("#unitTable").bootstrapTable("refreshOptions",{ajax:Inventory.loadProductUnit});
     
  },
  
  damage:function(){
      var url = UrlUtil.createWebUrl('product','inventoryChange');
      var params = {};
      params.productid = $("#damageModal [name=productid]").val();
      params.storeid = $("#damageModal [name=store]").val();
      params.num = $("#damageModal [name=num]").val();
      params.remark = $("#damageModal [name=remark]").val();
      
      $.post(url,params,function(data){
          if(data.state==0){
              Tips.successTips("变更成功");
              $("#damageModal").modal('hide');
          }
          else{
              Tips.failTips(data.msg);
          }
      });
      
  },
  
  loadProductUnit:function(obj){
      var url = UrlUtil.createWebUrl("product",'loadProductUnit');
      var params = {};
      params.productid = $("#specModal [name=productid]").val();
      
      $.post(url,params,function(data){
           if(data.state == 0){
               obj.success(data.obj);
           }
           else{
               Tips.failTips(data.msg);
           }
      });
      
  },
  
  unitTableInit:function(){
      $("#unitTable").bootstrapTable({
          data:[],
          columns:[
              {
                  field:'productname',
                  title:'商品名称'
              },{
                  field:'unitname',
                  title:'规格名称'
              },{
                  field:'num',
                  title:'容量'
              },{
                  field:'unit',
                  title:'单位'
              },{
                  field:'price',
                  title:"价格"
              },{
                  field:'id',
                  title:'操作'
              }
          ]
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
  },
  
  selectProduct:function(){
      $('#addStockMaterial').modal('show');
  },
  
  info : function(){
      
  }
};