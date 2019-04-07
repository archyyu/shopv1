{include file="../../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="warehouse">
  <div class="water-btn-group">
    <div class="left-group">
      <button class="btn btn-primary" data-toggle="modal" data-target="#addWarehouseModal">添加库房</button>
    </div>
  </div>
  <div class="detail_content">
    <table class="table table-bordered table-condensed">
      <thead>
        <tr>
          <th>库房名称</th>
          <th>创建时间</th>
          <th>操作员</th>
          <th colspan="3" class="text-center">操作 </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td></td>
          <td></td>
          <td>店长</td>
          <td class="text-center"><button class="btn btn-link btn-xs modify"></button>
          </td>
          <td class="text-center"><button class="btn btn-xs btn-link edit">编辑</button></td>

          <td class="text-center"><button class="btn btn-xs btn-link delete">
            </button></td>

        </tr>
      </tbody>
    </table>
  </div>
  {include file="../modals/addwarehouse.tpl"}
</div>
{include file="../common/footer.tpl"}