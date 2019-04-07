{include file="../../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="purchase-change">
  <div class="panel panel-search">
    <div class="panel-heading search">
      <h3 class="panel-title">查询</h3>
    </div>
    <div class="panel-body">
      <form id="stockCountSelectForm">
        <div class="form-inline">
          <div class="form-group">
            <label for="name" class="control-label">时间：</label>
            <div class="input-group input-group-sm">
              <input type="text" class="datetimepicker datetime form-control" readonly="readonly" placeholder="起"
                name="starttime" id="starttimeSelect">
              <div class="input-group-addon"> —— </div>
              <input type="text" class="datetimepicker datetime form-control" readonly="readonly" placeholder="止"
                name="endtime" id="endtimeSelect">
            </div>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">物料名称：</label>
            <input type="text" class="form-control input-sm" name="materialName" id="materialName">
          </div>
          <div class="form-group">
            <label for="name" class="control-label">变动商品类型：</label>
            <select class="form-control input-sm" name="changeType" id="changeType">
              <option value="">请选择</option>
              <option value="1">商品销售</option>
              <option value="2">客户退货</option>
              <option value="3">货流进货</option>
              <option value="4">货流出货</option>
              <option value="5">库存盘点</option>
              <option value="6">库存报损</option>
              <option value="7">库存报溢</option>
              <option value='8'>调拨出库</option>
              <option value='9'>调拨入库</option>
              <option value="100">未定义</option>
            </select>
          </div>
          <button type="button" class="btn btn-search">筛选</button>
        </div>
      </form>
    </div>
  </div>
  <div class="detail_content">

    <table class="table table-bordered">
      <thead>
        <tr>
          <th>流水ID</th>
          <th>物料名称</th>
          <th>库房</th>
          <th>供货单号</th>
          <th>供货商</th>
          <th>变动类型</th>
          <th>变动数量</th>
          <th>剩余数量</th>
          <th>进货总价（元）</th>
          <th>时间 </th>
          <th>操作员</th>
          <th>备注 </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{$T.record.id}</td>
          <td>{$T.record.materialName}</td>
          <td>{$T.record.storagename || ""}</td>
          <td>{$T.record.stockorderid || ""}</td>
          <td>{$T.record.suppliername || ""}</td>
          <td>{$T.record.changetype}</td>
          <td>{$T.record.totalvolume}({$T.record.unit})</td>
          <td></td>
          <td>{$T.record.totalprice}</td>
          <td>{$T.record.time}</td>
          <td>{$T.record.username}</td>
          <td>{$T.record.remark}</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

<script src="{$StaticRoot}/js/web/waterbar/material.js"></script>
{include file="../../common/footer.tpl"}