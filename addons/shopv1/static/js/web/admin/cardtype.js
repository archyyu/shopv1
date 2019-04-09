/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    
    CardType.initTable();
    CardType.reloadTable();
    
});


var CardType = {
    
    initTable : function(){
        $("#cardList").bootstrapTable({
    data: [{
        id: 1,
        text: 2
      },
      {
        id: 2,
        text: 3
      }
    ],
    columns: [{
        field: 'id',
        title: '卡券ID'
      },
      {
        field: 'id',
        title: '卡券名称'
      },
      {
        field: 'id',
        title: '类别'
      },
      {
        field: 'id',
        title: '使用场景'
      },
      {
        field: 'id',
        title: '关联商品'
      },
      {
        field: 'id',
        title: '卡券金额'
      },
      {
        field: 'id',
        title: '折扣值'
      },
      {
        field: 'id',
        title: '最低使用价格'
      },
      {
        field: 'id',
        title: '卡券有效期'
      },
      {
        field: 'text',
        title: '操作',
        formatter: function (value, row) {
          return ['<button class="btn btn-xs btn-primary" data-toggle="modal" data-target="#sendCardModal">发行卡券</button> ',
            '<button class="btn btn-xs btn-success">编辑</button> ',
            '<button class="btn btn-xs btn-danger">删除</button>'
          ].join("");
        }
      }
    ]
  });
    },
    
    reloadTable : function(){
        
    },
    
    loadCardTypeList : function(){
        
    },
    
    info : function(){
        
    }
    
};