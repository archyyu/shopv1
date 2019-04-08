$(function () {
  Inventory.goodsTableInit();
  Inventory.classListInit();
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
          title: '销售价'
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
          title: '虚物/实物'
        },
        {
          field: 'id',
          title: '是否允许卡口'
        },
        {
          field: 'id',
          title: '关联商品'
        },
        {
          field: 'id',
          title: '销售时段'
        },
        {
          field: 'id',
          title: '排序'
        },
        {
          field: 'id',
          title: '操作'
        }
      ]
    })
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

  classListInit: function (classId) {
    $("#productListTable").bootstrapTable({
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
          title: '排序'
        },
        {
          field: 'id',
          title: '类别'
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
    })
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