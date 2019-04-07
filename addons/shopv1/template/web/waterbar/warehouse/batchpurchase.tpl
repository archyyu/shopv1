{include file="../../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="batch-purchase">
  <div class="row batch_search">
    <div class="panel search">
      <div class="panel-heading search">
        <h3 class="panel-title">筛选</h3>
      </div>
      <div class="panel-body">
        <div class="form-inline">
          <form id="chooseForm" onsubmit="javascript:return false;">
            <div class="form-group ">
              <label class="control-label">供货商：</label>
              <select class="form-control" id="supplierID">
              </select>
            </div>
            <div class="form-group ">
              <label class="control-label">库房名称：</label>
              <select class="form-control">
              </select>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group">
    <ul class="nav nav-pills netnav in_out_nav">
      <li class="left-title">
        <div class="add_material">

          <button class="btn btn-block btn-info text-center" data-toggle="modal" data-target="#batchPurchaseModal">添加进货原料</button>
        </div>
      </li>
    </ul>
  </div>

  <div class="content-bg">
    <form class="form-horizontal">
      <div class="detail_content">
        <div>
          <table class="table table-bordered table-condensed">
            <thead>
              <tr>
                <th>类型</th>
                <th class="material_name">原料名称</th>
                <th>进货单位</th>
                <th class="material_price">进货价</th>
                <th class="material_number">进货数量</th>
                <th>合计</th>
                <th>操作 </th>
              </tr>
            </thead>
            <tbody id="tabTemplate">
            </tbody>
            <thead>
              <tr>
                <th colspan="5" class="text-center">小计</th>
                <th colspan="2" class="text-center"><span id="subtotal">0</span>元</th>
              </tr>
            </thead>

          </table>
        </div>
      </div>
    </form>
  </div>

  <div class="remark_box">
    <form class="form-inline" id="remarkForm" onsubmit="javascript:return false;">
      <div class="row">
        <div class="col-md-9">
          <div class="form-group">
            <label for="">备注：</label>
            <input type="text" class="form-control" id="remark" placeholder="">
          </div>
        </div>
        <div class="col-md-3">
          <div class="form-group">
            <label for="">优惠价格：</label>
            <div class="input-group">
              <input type="text" class="form-control" id="discountPrice" onchange="BatchStock.flushTemp();" name=""
                value="0" placeholder="优惠金额">
              <div class="input-group-addon">（元）</div>
            </div>
          </div>
          <p></p>
          <div class="form-group">
            <label for="">实际支付：</label>
            <p class="pay_last"><span id="payPrice">0</span>（元）</p>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6 col-md-offset-3 foot_remark">
          <button type="button" class="btn  btn-default" data-dismiss="modal"
            onclick="BatchStock.repeal();">取消进货</button>
          <button type="button" class="btn  btn-primary" onclick="BatchStock.save()">确认进货</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script src="{$StaticRoot}/js/web/waterbar/material.js"></script>
{include file="../../common/footer.tpl"}