{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

{include file="../common/netbarSelect.tpl"}

<script id='areaList' type='text/x-jsmart-tmpl'>
    {literal}
    {foreach $data as $val}
       {if $val@index == 0}
            <li class="area-list-item active" value="{$val.areaid}" onclick="NetbarInfoLogic.changeArea(this,{$val.areaid})">{$val.areaname}</li>
       {else}
           <li class="area-list-item" value="{$val.areaid}" onclick="NetbarInfoLogic.changeArea(this,{$val.areaid})">{$val.areaname}</li>
       {/if}
   {/foreach}
    {/literal}
</script>

<div class="rate-setting normal-rate">
  <div class="area">
    <h5>区域选择</h5>
    <div class="area-list" id="areaNav" >
      <input type="hidden" value="" name="areaid" />
      <!--<div class="area-list-item active" onclick="NetbarInfoLogic.changeArea(this,{$val.areaid})">默认区域</div>
      <div class="area-list-item" onclick="NetbarInfoLogic.changeArea(this,{$val.areaid})" >默认区域</div>-->
    </div>
  </div>
  <div class="rate-section">
    <h5>费率设置</h5>
    <div class="member-level">
      <div class="member-level-nav">
        <div class="member-level-wrap">
          <div class="member-level-item active" name="clicktypeid" onclick="NetbarInfoLogic.clickMemberType(1)" value="1">普通会员</div>
          <div class="member-level-item" name="clicktypeid" onclick="NetbarInfoLogic.clickMemberType(2)" value="2">工作人员</div>
          <div class="member-level-item" name="clicktypeid" onclick="NetbarInfoLogic.clickMemberType(3)" value="3">白银会员</div>
        </div>
      </div>
    </div>
    <div class="rate-base-setting">
      <div class="form-inline">
        <div class="form-group form-group-sm">
          <label class="control-label">起价：</label>
          <input type="hidden" value="0" name="id"/>
          <input type="hidden" value="1" name="typeid"/>
          <div class="input-group"><input type="text" name="startprice" class="form-control"><span class="input-group-addon">元</span></div>
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">最小收费：</label>
          <div class="input-group"><input name="mincostprice" type="text" class="form-control"><span class="input-group-addon">元</span></div>
        </div>
        <div class="form-group form-group-sm">
          <label class="control-label">忽略时间：</label>
          <div class="input-group"><input name="ignoretime" type="text" class="form-control"><span class="input-group-addon">分钟</span></div>
        </div>
        <div class="form-group form-group-sm">
          <label class="radio-inline"><input type="radio" name="freq"> 半点有效</label>
          <label class="radio-inline"><input type="radio" name="freq"> 整点有效</label>
        </div>
        <button onclick="NetbarInfoLogic.saveRate()" class="btn btn-sm btn-primary">确定</button>
      </div>
    </div>
    <div class="rate-form">
      <table id="rateTable" class="table table-bordered table-responsive rate-table">
        <thead>
          <tr>
            <th></th>
            {for $hours = 1 to 24}
            <th>
              {if $hours<10}
                0{$hours}
              {else}
                {$hours}
              {/if}
            </th>
            {/for}
          </tr>
        </thead>
        <tbody onmousedown="NetbarInfoLogic.selectRate(this)">
          {assign var=weeks value=['周一','周二','周三','周四','周五','周六','周日']}
          {foreach $weeks as $week}
          <tr>
            <th>{$week}</th>
            {for $hours = 1 to 24}
            <td class="rate-td-js">0</td>
            {/for}
          </tr>
          {/foreach}
        </tbody>
      </table>
      <div id="rateSettingCard" class="card rate-setting-card">
        <div class="card-content">
          <div class="card-header">设置费率</div>
          <div class="card-body">
            <input type="hidden" id="seleTd">
            <div class="form-inline">
              <div class="form-group">
                <label>费率：</label>
                <input type="tel" id="rateInput" class="form-control rate-input">
                <p class="form-control-static">元/小时</p>
              </div>
            </div>
          </div>
          <div class="card-footer">
            <button class="btn btn-sm btn-default" onclick="NetbarInfoLogic.cancelRate()">取消</button>
            <button class="btn btn-sm btn-primary" onclick="NetbarInfoLogic.confirmRate()">确认</button>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>
<script src="{$StaticRoot}/js/dist/selectarea.js"></script>
<script src="{$StaticRoot}/js/web/netbarInfo/rateSetting.js"></script>

{include file="../common/footer.tpl"}
