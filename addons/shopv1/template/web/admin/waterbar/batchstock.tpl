{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="batch-stock">
    <div class="water-btn-group">
        <button class="btn btn-primary" data-toggle="modal" data-target="#addStockMaterial">添加进货原料</button>
    </div>
    <div class="detail_content">
        <table id="batchStockTable" class="table table-bordered table-condensed">
            <!-- <thead>
                <tr>
                    <th>类型</th>
                    <th>原料名称</th>
                    <th>进货单位</th>
                    <th>进货价</th>
                    <th>进货数量</th>
                    <th>合计</th>
                    <th>操作 </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <thead>
                <tr>
                    <th colspan="5" class="text-center">小计</th>
                    <th colspan="2" class="text-center"><span id="subtotal">0</span>元</th>
                </tr>
            </thead> -->
        </table>
    </div>

    <div class="remark_box">
        <div class="row">
            <div class="col-md-9">
                <div class="form-group">
                    <label>备注：</label>
                    <input type="text" class="form-control">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label>优惠价格：</label>
                    <div class="input-group">
                        <input type="text" class="form-control" value="0" placeholder="优惠金额">
                        <div class="input-group-addon">（元）</div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="">实际支付：</label>
                    <p class="pay_last"><span id="payPrice">0</span>（元）</p>
                </div>
            </div>
        </div>
        <div class="stock_btn">
            <button type="button" class="btn  btn-default">取消进货</button>
            <button type="button" class="btn  btn-primary">确认进货</button>
        </div>
    </div>
</div>

{literal}
<script>
$("#batchStockTable").bootstrapTable({
    data: [{
        id: 1,
        text: 'a',
        num: 5
    },
    {
        id: 1,
        text: 'a',
        num: 5
    }],
    showFooter: true,
    footerStyle: footerStyle,
    columns: [{
            field: 'id',
            title: '类型'
        },
        {
            field: 'id',
            title: '原料名称'
        },
        {
            field: 'text',
            title: '进货单位',
            footerFormatter: function (value) {
				return '合计';
			}
        },
        {
            field: 'id',
            title: '进货价'
        },
        {
            field: 'id',
            title: '进货数量'
        },
        {
            field: 'num',
            title: '合计',
            footerFormatter: priceFormatter
        },
        {
            field: 'id',
            title: '操作'
        }
    ]
})

function priceFormatter(data) {
    var field = this.field;
    var sum = 0;
    data.map(function (row) {
        console.log(row)
        sum += row[field]
    })
    return '<span>'+sum+'</span> 元'
  }
  function footerStyle(column) {
    return [
      {
        css: {'border-right': 0}
      },
      {
        classes: 'none-border'
      },
      {
        classes: 'none-border',
        css: {'text-align': 'center'}
      },
      {
        classes: 'none-border'
      },
      {
        classes: 'none-border'
      },
      {
        classes: 'footer-sum'
      },
      {
        css: {'border-left' : 0}
      }
    ][column.fieldIndex]
  }
</script>
    
{/literal}

{include file="./modals/selectproduct.tpl"}
{include file="../../common/footer.tpl"}