{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="warehouse">
  <div class="water-btn-group clearfix">
    <div class="left-group">
      <button class="btn btn-primary" data-toggle="modal" data-target="#">添加卡券</button>
    </div>
  </div>
  <div class="detail_content">
    <table id="cardList" class="table">
    </table>
  </div>
  {include file="../modals/addwarehouse.tpl"}
</div>

<script src="{$StaticRoot}/js/web/card/cardManagement.js"></script>
<script>
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
          return ['<button class="btn btn-xs btn-primary">发行卡券</button> ',
            '<button class="btn btn-xs btn-success">编辑</button> ',
            '<button class="btn btn-xs btn-danger">删除</button>'
          ].join("");
        }
      }
    ]
  })
</script>
{include file="../../common/footer.tpl"}