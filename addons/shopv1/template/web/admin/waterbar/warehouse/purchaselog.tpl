{include file="../../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="purchase-log">
  <div class="panel_search">
    <div class="panel search">
      <div class="panel-heading search">
        <h3 class="panel-title">查询</h3>
      </div>
      <div class="panel-body">
        <div class="form-inline">
          <div id="chooseForm">
            <div class="form-group ">
              <label class="control-label">时间范围：</label>
              <div class="input-group input-group">
                <input type="text" class="datetimepicker datetime form-control" readonly="readonly" placeholder="初始时间" id="startTime" name="startTime">
                <div class="input-group-addon"> —— </div>
                <input type="text" class="datetimepicker datetime form-control" readonly="readonly" placeholder="终止时间" id="endTime" name="endTime">
              </div>
            </div>
            <div class="form-group ">
              <label class="control-label">供货商：</label>
              <select class="form-control" id="supplierID" name="supplierID">
                <option value="">请选择</option>
              </select>
            </div>
            <div class="form-group ">
              <label class="control-label">进货库房：</label>
              <select class="form-control" id="storageID" name="storageID">
                <option value="">请选择</option>
              </select>
            </div>
            <button class="btn btn-sm btn-default btn-search">搜索</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="detail_content">
    <div class="content-bg">
      <div class="form-horizontal">
        <div class="detail_content">
          <div class="row shift_table">
            <div class="col-xs-12" id="tabTemplate">
              <ul class="nav nav-pills data_col">
                <li class="left-title">支出总金额：<span>{$T.item.info.order.totalprice -
                    $T.item.info.order.discountprice}元</span></li>
                <li class="left-title">优惠总金额：<span>{$T.item.info.order.discountprice + 0}元</span></li>
                <li class="left-title">进货总次数：<span class="times">{$T.item.info.order.count}次</span></li>
              </ul>
              <table class="table table-bordered table-condensed">
                <thead>
                  <tr>
                    <th>进货时间</th>
                    <th class="material_name">进货单号</th>
                    <th>供应商名称</th>
                    <th class="material_price">进货库房</th>
                    <th class="material_number">实付金额</th>
                    <th>优惠金额</th>
                    <th>进货人</th>
                    <th colspan="2">操作</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>{$T.list.createtime}</td>
                    <td>{$T.list.id}</td>
                    <td>{$T.list.suppliername}</td>
                    <td>{$T.list.storagename}</td>
                    <td>{$T.list.totalPrice - $T.list.discountPrice}</td>
                    <td>{$T.list.discountPrice}</td>
                    <td>{$T.list.username}</td>
                    <td><button type="button" class="btn btn-link edit">进货明细</button>
                    </td>
                    <td><button type="button" class="btn btn-link modify">导出</button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="{$StaticRoot}/js/web/waterbar/material.js"></script>
{include file="../../common/footer.tpl"}