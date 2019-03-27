{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

{include file="../common/netbarSelect.tpl"}
<div class="rate-setting period-setting">
  <div class="add-period">
      <button class="btn btn-sm btn-success" data-toggle="modal" onclick='period.openPeriodModal(0,null)'>添加包时</button>
  </div>
  <div>
    <table id="periodList" class="table table-bordered table-center">
      <thead>
        <tr>
          <th>包时类型</th>
          <th>金额</th>
          <th>时段/时长</th>
          <th>区域</th>
          <th>会员类型</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>包时段</td>
          <td>8元</td>
          <td>120分钟</td>
          <td>竞技区域</td>
          <td>普通会员，免费会员</td>
          <td class="operate">
              <button class="btn btn-xs btn-primary">编辑</button>
            <button class="btn btn-xs btn-danger">删除</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

<div id="addperiod" class="modal fade add-period-modal" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <input type='hidden' id='addOrSave' value='0' />
          <input type="hidden" id="pid" />
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">新增包时</h4>
        </div>
        <div class="modal-body">
          <div class="form-horizontal">
            <div class="form-group form-group-sm">
              <label class="col-xs-2 control-label">包时类型：</label>
              <div class="col-xs-4">
                  <label class="radio-inline">
                    <input name='periodtype' value='0' onclick="period.confirmPeriodType(0)" type="radio" checked='checked'> 包时段
                  </label>
                  <label class="radio-inline">
                    <input name='periodtype' value='1' onclick="period.confirmPeriodType(1)" type="radio"> 包时长
                  </label>
              </div>
            </div>
            
            <div id='periodPeriodInput' class="form-group form-group-sm">
              <label class="col-xs-2 control-label">可用时段：</label>
              <div class="col-xs-4">
                <div class="input-group">
                  <input id='starttime' class="form-control">
                  <span class="input-group-addon"> - </span>
                  <input id='endtime' class="form-control">
                </div>
              </div>
            </div>
            <div id='periodDurationInput' class="form-group form-group-sm hide-ele">
              <label class="col-xs-2 control-label">上网时长：</label>
              <div class="col-xs-4">
                <div class="input-group">
                  <input id='periodtime' class="form-control">
                  <span class="input-group-addon">分钟</span>
                </div>
              </div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-2 control-label">金额：</label>
              <div class="col-xs-4">
                  <div class="input-group">
                  <input id='periodprice' class="form-control">
                  <span class="input-group-addon">元</span>
                </div>
              </div>
            </div>
            
            <div class="form-group form-group-sm">
              <label class="col-xs-2 control-label">上网区域：</label>
              <div id='periodArea' class="col-xs-10">
                  
              </div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-2 control-label">会员等级：</label>
              <div id='periodMemberType' class="col-xs-10">
                  
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          <button type="button" class="btn btn-primary" onclick="period.addOne()" id='periodSave'>保存</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
<script src="{$StaticRoot}/js/web/tariffyRate/period.js"></script>

<script id='periodAreaTmpl' type="text/template">
    {literal}
    {foreach $areaList as $area}
        <label class="checkbox-inline">
            <input type="checkbox" value='{$area.areaid}'>{$area.areaname} 
        </label>
    {/foreach}
    {/literal}
</script>

<script id='periodMemberTypeTmpl' type="text/template">
    {literal}
    {foreach $memberTypeList as $memberType}
        <label class="checkbox-inline">
        <input type="checkbox" value='{$memberType.membertypeid}'>{$memberType.membertypename} 
        </label>
    {/foreach}
    {/literal}
</script>

{include file="../common/footer.tpl"}
