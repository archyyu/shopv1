
$(function(){
  
    Warehouse.warehouseTableInit();
    Warehouse.reloadTable();
    
});

var Warehouse = {
  warehouseTableInit: function(){
    $("#warehouseList").bootstrapTable({
      data: [],
      columns: [
        {
          field: 'storename',
          title: '库房名称'
        },
        {
          field: 'createdate',
          title: '创建时间'
        },
        {
          field:'shopname',
          title:'所属门店'
        },
        {
          field: 'id',
          title: '操作',
          events:{
              'click .edit-event':function(e,value,row,index){
                  Warehouse.openStore(1,row);
              }
          },
          formatter: function(value, row,index){
            return '<button class="btn btn-xs btn-success edit-event">编辑</button>';
          }
        }
      ]
    });
  },
  
  reloadTable:function(){
       $("#warehouseList").bootstrapTable('refreshOptions',{ajax:Warehouse.loadList});
  },
  
  loadList:function(obj){
      var url = UrlUtil.createWebUrl('product','loadProductStore');
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
  
  openStore:function(type,obj){
      
      if(type == 0){
          $("#storeid").val(0);
          $("#storename").val('');
          $("#addWarehouseModal").modal("show");
      }
      else{
          
          if(obj.shopid != undefined){
              $("#shopid").selectpicker('val',obj.shopid);
          }
          
          $("#storeid").val(obj.id);
          $("#storename").val(obj.storename);
          $("#addWarehouseModal").modal("show");
      }
  },
  
  save : function(){
      var url = UrlUtil.createWebUrl('product','saveStore');
      var params = {};
      
      if($('#storeid').val() != 0){
          params.storeid = $("#storeid").val();
      }
      params.storename = $('#storename').val();
      
      if($("#shopid").val() != ''){
          params.shopid = $("#shopid").val();
      }
      
      $.post(url,params,function(data){
          if(data.state == 0){
              $("#addWarehouseModal").modal("hide");
              Tips.successTips("保存成功");
              Warehouse.reloadTable();
          }
          else{
              Tips.failTips(data.msg);
          }
      });
      
  },

  info: function(){
    
  }
};