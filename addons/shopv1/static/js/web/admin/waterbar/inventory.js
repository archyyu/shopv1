$(function () {

    Inventory.initProducts();
    Inventory.joinTabInit();
  
    Inventory.goodsTableInit();
    Inventory.goodsTableReload();
    
    Inventory.classListInit();
    Inventory.classListReload();
  
    Inventory.unitTableInit();
    
    // $('#selectProductBtn').click(function(){
        
    //     Inventory.selectProductList = [];
        
    //     $("#selectProductList div").each(function(){
            
    //         if( $(this).find("input").is(':checked')){
            
    //             var item = {};
    //             item.productname = $(this).find("span").html();
    //             item.productid = $(this).find("input").attr("productid");
    //             Inventory.selectProductList.push(item);
            
    //         }
    //     });
    //     var jsonStr = JSON.stringify(Inventory.selectProductList);
        
    //     $('#addStockMaterial').modal('hide');
    //     $("#addProductModal [name=linkproduct]").empty();
    //     Inventory.linkProductList();
    // });
    
    $("#storeSelect").change(function(){
        
        Inventory.goodsTableReload();
        
    });
    
    $('#typeSelectQuery').change(function(){
       Inventory.goodsTableReload(); 
    });
    
});

var Inventory = {
    
   selectProductList:[],

   productInventoryMap : {},

   currentProduct : [],

   products : [],

  productIdArr : [],      //存放关联商品ID

  productJsonArr : [],    //存放关联商品信息

  checkJsonArr : [],      //存放选中关联商品信息

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
          title: '正常价(元)',
          formatter:function(value,row,index){
              return (value/100).toFixed(2);
          }
        },
        {
          field: 'memberprice',
          title: '会员价(元)',
          formatter:function(value,row,index){
              return (value/100).toFixed(2);
          }
        },
        {
            field:'userget',
            title:'吧员收益',
            formatter:function(value,row,index){
                return (value/100).toFixed(2);
            }
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
              else if(value == 2){
                  return "原料";
              }
              else if(value == 3){
                return "套餐";
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
              
              if(row.producttype != 1 && row.producttype != 3){
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
      // $("#transferModal [name=inventory]").html(0);
      //   for(var i = 0;i<inventoryList.length;i++){
      //       if(inventoryList[i].storeid == $("#transferModal [name=sourceid]").val()){
      //           $("#transferModal [name=inventory]").html(inventoryList[i].inventory);
      //           return;
      //       }
      //   }
      $("#transferModal [name=inventory]").html(0);
      var sourceid = $("#transferModal [name=sourceid]").val();
      Inventory.flushStoreInventory(sourceid);
  },
  
  inventoryTransfer:function(){
      var url = UrlUtil.createWebUrl('product','inventoryTransfer');
      
      var params = {};
      params.productid = $("#transferModal [name=productid]").val();
      params.sourceid = $("#transferModal [name=sourceid]").val();
      params.destinationid = $("#transferModal [name=destinationid").val();
      params.inventory = $("#transferModal [name=num]").val();

      if (params.productid == params.destinationid) {
        Tips.failTips("同库不能调动");
        return ;
      };
      
      $.post(url,params,function(data){
         if(data.state == 0){
             Tips.successTips('调货成功');
             $("#transferModal").modal('hide');

             $("#transferModal [name=productid]").val(0);
             $("#transferModal [name=num]").val("");
             delete Inventory.productInventoryMap[params.productid];

             Inventory.goodsTableReload();
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
             Inventory.goodsTableReload();
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
             Inventory.goodsTableReload();
         } 
         else{
             Tips.failTips(data.msg);
         }
      });
      
  },

  flushStoreInventory : function(storeid){
    if (Inventory.currentProduct.length > 0) {
      for (var i = 0; i < Inventory.currentProduct.length; i++) {
        if (Inventory.currentProduct[i].storeid == storeid) {
          $("#transferModal [name=inventory]").html(Inventory.currentProduct[i].inventory);
          $("#transferModal").modal("show");
          return;
        };
      };
    };
    
    $("#transferModal [name=inventory]").html(0);
    $("#transferModal").modal("show");
  },
  
  openTransModal:function(productid,unit){
       $("#transferModal [name=unit]").text(unit);
       $("#transferModal [name=productid]").val(productid);

       var sourceid = $("#transferModal [name=sourceid]").val();

       if (Inventory.productInventoryMap[productid] != undefined) {

          Inventory.currentProduct = Inventory.productInventoryMap[productid];
          Inventory.flushStoreInventory(sourceid);
          return ;
       };
       
      var url = UrlUtil.createWebUrl('product','inventorylist');
      
      var params = {};
      params.productid = productid;
      
      $.post(url,params,function(data){
          if(data.state == 0){
              // inventoryList = data.obj;
              Inventory.productInventoryMap[productid] = data.obj;
              Inventory.currentProduct = data.obj;
              Inventory.flushStoreInventory(sourceid);
              return ;    
          }
          else{
              
          }
          
      });
      
  },
  
  goodsTableReload:function(){
    $("#goodsTable").bootstrapTable("refreshOptions",{ajax:Inventory.loadGoodsList});  
  },
  
  openGoodModal:function(addOrUpdate,obj){
      
      Inventory.repeal();
      
      if(addOrUpdate == 0){
          $("#addProductModal [name=productid]").val(0);
          $("#addProductModal [name=productname]").val('');
          $("#addProductModal [name=productcode]").val('');
          $("#addProductModal [name=make]").val(0);
          $("#addProductModal [name=normalprice]").val(0);
          $("#addProductModal [name=memberprice]").val(0);
          $("#addProductModal [name=userget]").val();
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
          $("#addProductModal [name=normalprice]").val((obj.normalprice/100).toFixed(2));
          $("#addProductModal [name=memberprice]").val((obj.memberprice/100).toFixed(2));
          $("#addProductModal [name=userget]").val((obj.userget/100).toFixed(2));
          $("#addProductModal [name=index]").val(obj.index);
          $("#previewImg").attr("src", UrlUtil.getWebBaseUrl() + obj.productimg);
          $("#addProductModal [name=attributes]").val(obj.attributes);
          $("#addProductModal [name=unit]").val(obj.unit);
          $("#addProductModal [name=typeid]").selectpicker('val',obj.typeid);
          //$("#addProductModal [name=linkproduct]").empty();
          try{
            // for(let item of list){
            //     var str = "<div class='form-group form-group-sm associalproduct' name='associalproduct'>"+
            //       "<label class='col-sm-3 control-label'>" +
            //       "</label>" + 
            //       "<div class='col-sm-4'>" +
            //           "<input type='hidden' name='productid' productid='" + item.materialid + "' />"+
            //           "<span name='productname'>" + item.materialname + "</span>"+
            //       "</div>" +
            //       "<div class='col-sm-2'>"+
            //           "<span></span><input name=num class='form-control' value='" + item.num + "' >"+
            //       "</div>"+
            //     "</div>";

            //   $("#addProductModal [name=linkproduct]").append(str);
            // }
            if (obj.producttype == 1 || obj.producttype == 3) {
              var list = JSON.parse(obj.productlink);
              for (var i = 0; i < list.length; i++) {
                Inventory.productIdArr.push(list[i].materialid);
              };
              Inventory.productJsonArr = list;
            };
            
          }
          catch (ex){
              
          }
            
          $("#addProductModal [name=producttype][value='" +obj.producttype + "']").prop('checked', 'checked');
          
        }
          
        Inventory.refreshJoinTable();
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
      if(producttype == 1 || producttype == 3){
          $("#addProductModal .associalproduct").css("display","block");
      }
      else{
          $("#addProductModal .associalproduct").css("display","none");
      }
      
  },
  
  saveGood:function(){
      
      var url = UrlUtil.createWebUrl("product",'saveProduct');
      
      var params = new FormData();
      
      let productid = $("#addProductModal [name=productid]").val();
      
      if(productid != 0){
          params.append("productid",productid);
      }
      
      params.append("productname",$("#addProductModal [name=productname]").val());
      params.append("productcode",$("#addProductModal [name=productcode]").val());
      params.append("make",$("#addProductModal [name=make]").val());
      params.append("producttype",$("#addProductModal [name=producttype]:checked").val());
      params.append("normalprice",$("#addProductModal [name=normalprice]").val()*100);
      params.append("memberprice",$("#addProductModal [name=memberprice]").val()*100);
      params.append("userget",$("#addProductModal [name=userget]").val()*100);
      params.append("index",$("#addProductModal [name=index]").val());
      params.append("attributes",$("#addProductModal [name=attributes]").val());
      params.append("unit",$("#addProductModal [name=unit]").val());
      params.append("typeid",$("#addProductModal [name=typeid]").val());
      try{
          params.append("productimg",document.getElementById("logoInput").files[0]);
      }
      catch (ex){
          
      }
      
      var list = [];
      $("#addProductModal [name=associalproduct]").each(function(){
          var item = {};
          item.materialid = $(this).find("[name=productid]").attr('productid');
          item.materialname = $(this).find("[name=productname]").html();
          item.num = $(this).find("[name=num]").val();
          list.push(item);
      });
      
      //params.append("link",JSON.stringify(list));
      params.append("link",JSON.stringify(Inventory.productJsonArr));
      
      $.ajax({
                url: url,
                type: 'POST',
                dataType: 'json',
                data: params,
                async: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    if(data.state == 0){
                        Tips.successTips("保存成功");
                        $("#addProductModal").modal("hide");
                        Inventory.goodsTableReload();
                    }
                    else{
                        Tips.failTips(data.msg);
                    }
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
              Inventory.goodsTableReload();
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

    this.openGoodModal(0, null);
  },

  initProducts : function(){
    Inventory.products = [];
    var products = $('#products').val();
    if (products != "") {
      products = JSON.parse(products);
      for (var i = 0; i < products.length; i++) {
        if (products[i].producttype == 0 || products[i].producttype == 2) {
          Inventory.products.push(products[i]);
        };
        
      };
      
    };
  },

  joinTabInit : function(){
    $("#joinTable").bootstrapTable({
      data: [],
        showFooter: false,
        //footerStyle: BatchStock.footerStyle,
        columns: [{
                field: 'materialname',
                title: '关联商品'
            },
            {
                field: 'num',
                title: '数量',
                formatter:function(value,row,index){
                  return [
                          '<input type="text" value="' + value + '" onchange="Inventory.updatenum(this, ' + index + ');" />'
                      ].join("");
                }
            },
            {
                field: 'materialid',
                title: '操作',
                  formatter: function (value, row, index) {
                      return [//'<button class="btn btn-xs btn-success">编辑</button> ',
                          '<button class="btn btn-xs btn-danger" onclick="Inventory.remove(' + index + ', ' + value + ');">删除</button>'
                      ].join("");
                  }
            }
        ]
    });
  },

  refreshJoinTable:function(){
    $("#joinTable").bootstrapTable("load", Inventory.productJsonArr);
  },
  
  updatenum : function(obj, index){

    Inventory.productJsonArr[index].num = obj.value;
    Inventory.refreshJoinTable();
  },

  remove : function(index, id){
    Inventory.productJsonArr.splice(index, 1);
    Inventory.productIdArr.shift(id);

    Inventory.refreshJoinTable();
  },

  selectProduct:function(){
    $('#conForm')[0].reset();
    $("#checkNum").html("0");

    this.flushSelectProduct();

    $('#addStockMaterial').modal('show');
  },

  flushSelectProduct : function(){
    var products = Inventory.products;
    $("#totalNum").html(products.length);
    if (products.length > 0) {
      var div = "";
      for (var i = 0; i < products.length; i++) {
        div += '<div class="checkself" onclick="Inventory.clkDIV(this);Inventory.count();">' + 
          '<input type="checkbox" value="'+products[i].id+'" productName="'+products[i].productname+'" unit="'+products[i].unit+'" name="product[]" onclick="Inventory.clkDIV($(this).parent('+"'.checkself'"+'));Inventory.count();" />' + 
          '<span>'+products[i].productname+'</span></div>';
      };
      $("#selectProductList").html(div);
    };
  },
  
  uploadLogo: function(iputId, imgId, width, height){
    setMultiImagePreview(iputId,imgId,width,height);
    $(".upload-area").addClass('show-pic');
  },

  isCheck : function (obj){
      if($(obj).attr("state") == 0){
          $("#selectProductList input:checkbox[name='product[]']").prop('checked',true);
          $(obj).attr("state",1);
          Inventory.count();
      } else if($(obj).attr("state") == 1){
          $("#selectProductList input:checkbox[name='product[]']").prop('checked',false);
          $(obj).attr("state",0);
          Inventory.count();
      }
  },

  clkDIV : function(obj){
    if($(obj).children('input').prop('checked') == true){
      $(obj).children('input').prop('checked', false);
    } else{
      $(obj).children('input').prop('checked', true);
    }
  },

  count : function(){
      var count = 0;
      Inventory.checkJsonArr = [];
      $("#selectProductList input:checkbox[name='product[]']").each(function(){
          if(this.checked == 1){
              count += 1;
              var json = {};
              json.materialid = this.value;
              json.materialname = $(this).attr("productName");
              json.num = 1;

              Inventory.checkJsonArr.push(json);
          }
      });
      $("#checkNum").html(count);
  },

  addJoinProduct : function(){
    var list = Inventory.checkJsonArr;
    for(var i = 0; i < list.length; i++){
      if(Inventory.productIdArr.indexOf(list[i].materialid) < 0){
        Inventory.productIdArr.push(list[i].materialid);
        Inventory.productJsonArr.push(list[i]);
      }
    }

    //刷新模板
    Inventory.refreshJoinTable();
    $('#addStockMaterial').modal('hide');
  },

  repeal : function(){
    Inventory.productIdArr = [];
    Inventory.productJsonArr = [];
  },

  info : function(){
      
  }
};