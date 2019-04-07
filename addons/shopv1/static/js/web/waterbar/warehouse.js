
$(function(){
  Warehouse.warehouseTableInit();
});

var Warehouse = {
  warehouseTableInit: function(){
    $("#warehouseList").bootstrapTable({
      data: [{
          id: 1,
          text: 2
        },
        {
          id: 2,
          text: 3
        }
      ],
      columns: [
        {
          field: 'id',
          title: '库房名称'
        },
        {
          field: 'id',
          title: '创建时间'
        },
        {
          field: 'id',
          title: '操作员'
        },
        {
          field: 'text',
          title: '操作',
          formatter: function(value, row){
            return ['<button class="btn btn-xs btn-success">编辑</button> ',
            '<button class="btn btn-xs btn-danger">删除</button>'].join("");
          }
        }
      ]
    });
  },

  info: function(){
    return
  }
}