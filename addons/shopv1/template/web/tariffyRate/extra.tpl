{include file="../common/header.tpl" title=foo1 logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

{include file="../common/netbarSelect.tpl"}

<script id='areaSelectTmpl' type='text/x-jsmart-tmpl'>
    {literal}
    {foreach $areaList as $area}
       {if $area@index == 0}
            <div class='area-list-item active' onclick='extra.selectArea(this)' areaid='{$area.areaid}' >{$area.areaname}</div>
       {else}
           <div class='area-list-item' onclick='extra.selectArea(this)' areaid='{$area.areaid}' >{$area.areaname}</div>
       {/if}
   {/foreach}
    {/literal}
</script>

<script id='memberTypeSelectTmpl' type='text/x-jsmart-tmpl'>
    {literal}
        {foreach $memberTypeList as $memberType}
            <label class="checkbox-inline">
            <input type="checkbox" value='{$memberType.membertypeid}'>{$memberType.membertypename} 
            </label>
        {/foreach}
    {/literal}
</script>

<div class="rate-setting extra-fee">
  <div class="area">
    <h5>区域选择</h5>
    <div class="area-list" id='areaSelect'>
      
    </div>
  </div>
  <div class="rate-section">
    <h5>费率设置</h5>
    <div class="add-extra">
        <button class="btn btn-sm btn-success" data-toggle="modal" onclick='extra.openExtraMadol(0)'>新增附加费</button>
    </div>
    <div class="extra-rule">
      <table id="extraList" class="table table-bordered">
        <thead>
          <tr>
            <th>会员等级</th>
            <th>金额(元)</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td></td>
            <td></td>
            <td>
              <button class="btn btn-xs btn-primary">编辑</button>
              <button class="btn btn-xs btn-danger">删除</button>
            </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div id="addExtraModal" class="modal fade add-extra-modal" role="dialog">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">新增附加费</h4>
        <input type="hidden" id='extraid' />
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          <div class="form-group">
            <label class="col-xs-3 control-label">会员等级：</label>
            <div class="col-xs-9" id='memberTypeSelect'>
                
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-3 control-label">金额：</label>
            <div class="col-xs-6">
              <div class="input-group">
                <input type="text" id='extraprice' class="form-control">
                <span class="input-group-addon">元</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick='extra.save();'>确认</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="{$StaticRoot}/js/web/tariffyRate/extra.js"></script>
{include file="../common/footer.tpl"}
