{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css?t={$smarty.now}">
{include file="../common/netbarSelect.tpl"}
<div class="area-setting">
  <table class="table table-bordered table-center">
    <thead>
      <tr>
        <th>区域选择</th>
        <th>所属计算机</th>
        <th>选择</th>
        <th>未分组计算机</th>
        <th>会员类型</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td rowspan="2" class="area-list">
          <div>
            <button class="btn btn-sm btn-link btn-success" onclick="NetbarInfoLogic.addAreaBtn()">添加</button>
            <button class="btn btn-sm btn-link btn-primary" onclick="NetbarInfoLogic.editAreaBtn()">修改</button>
            <button class="btn btn-sm btn-link btn-danger" onclick="NetbarInfoLogic.delAreaBtn()">删除</button>
          </div>
          <ul id="areaNav">
            <!--<li class="active" onclick="NetbarInfoLogic.changeArea(this)">默认区域</li>
            <li onclick="NetbarInfoLogic.changeArea(this)">默认区域1</li>-->
            {foreach $barAreaList as $val}
              {if $val.areaname == '默认区域'}
                <li onclick="NetbarInfoLogic.changeArea(this,{$val.areaid})" class="active" value="{$val.areaid}" >{$val.areaname}</li>
              {else}
                <li onclick="NetbarInfoLogic.changeArea(this,{$val.areaid})" value="{$val.areaid}" >{$val.areaname}</li>
              {/if}

            {/foreach}
          </ul>
          <div id="areaSettingCard" class="card area-setting-card">
            <div class="card-content">
              <div class="card-header">添加区域</div>
              <div class="card-body">
                <input type="hidden" id="seleTd">
                <div class="form-inline">
                  <div class="form-group">
                    <label>名称：</label>
                    <input type="tel" id="rateInput" class="form-control rate-input">

                  </div>
                </div>
              </div>
              <div class="card-footer">
                <button class="btn btn-sm btn-default" onclick="$('#areaSettingCard').hide()">取消</button>
                <button class="btn btn-sm btn-primary" onclick="NetbarInfoLogic.confirmAreaBtn()">确认</button>
              </div>
            </div>
          </div>
        </td>
        <td rowspan="2">
          <div class="form-inline text-left search-pc">
            <label class="control-label">电脑名称：</label>
            <input type="text" name="areaSearch" oninput="NetbarInfoLogic.areaSearch()" class="form-control input-sm">
          </div>
          <div class="pc-list">
            <select class="form-control" name="groupMac" multiple>
              <!--<option value="11">1111</option>-->
            </select>
          </div>
        </td>
        <td class="doble-choose" rowspan="2">
          <div><button onclick="NetbarInfoLogic.groupMac(1)" class="btn btn-primary">&lt;</button></div>
          <div><button onclick="NetbarInfoLogic.groupMac(2)" class="btn btn-primary">&lt;&lt;</button></div>
          <div><button onclick="NetbarInfoLogic.removeOneMac(1)" class="btn btn-primary">&gt;</button></div>
          <div><button onclick="NetbarInfoLogic.removeOneMac(2)" class="btn btn-primary">&gt;&gt;</button></div>
        </td>
        <td>
          <div class="form-inline text-left search-pc">
            <label class="control-label">电脑名称：</label>
            <input type="text" name="search" class="form-control input-sm">
          </div>
          <div class="pc-list">
            <select class="form-control" name="allMac" multiple>

              {nocache}
                {foreach $areaList as $k => $v }
                  <option value="{$v.machineid}">{$v.machinename}</option>
                {/foreach}
              {/nocache}
            </select>
          </div>
          
        </td>
        <td rowspan="2" class="member-select">
            <div class="text-left" id="myTd">
              <div class="checkbox">
                <label>
                  <input type="checkbox" onclick="NetbarInfoLogic.addMemberType()" name="membertypelist" value="1"> 普通会员
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" onclick="NetbarInfoLogic.addMemberType()" name="membertypelist" value="2"> 普通会员普通会员
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" onclick="NetbarInfoLogic.addMemberType()" name="membertypelist" value="3"> 普通普通会员
                </label>
              </div>
            </div> 
        </td>
      </tr>
      <tr>
        <td>
            <div>
              <button class="btn btn-sm btn-success" data-toggle="modal" data-target="#addPc">添加</button>
              <button class="btn btn-sm btn-danger" name="delArea">删除</button>
            </div>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<div id="addPc" class="modal fade add-pc-modal" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" name="title">添加机器</h4>
        <input type="hidden" name="gid" value="0"/>
      </div>
      <div class="modal-body">
        <div class="form-horizontal">
          <div class="form-group form-group-sm">
            <label class="col-xs-3 control-label">机器名前缀：</label>
            <div class="col-xs-7"><input name="pre_name" class="form-control"></div>
          </div>
          <div class="form-group form-group-sm">
            <label class="col-xs-3 control-label">座位号起止：</label>
            <div class="col-xs-7">
              <label class="radio-inline"><input name="type" type="radio" value="1" checked="checked"> 单机添加</label>
              <label class="radio-inline"><input name="type" type="radio" value="2"> 批量添加</label>
            </div>
          </div>
          <div class="form-group form-group-sm">
              <div id="addSinglePc" class="col-xs-10 col-xs-offset-1">
                <input type="number" name="name" class="form-control">
              </div>
              <div id="addMutiPc" class="col-xs-10 col-xs-offset-1" hidden="true">
                <div class="input-group">
                  <input type="number" class="form-control" name="start_name" placeholder="设置开始机器号">
                  <span class="input-group-addon">——</span>
                  <input type="number" class="form-control" oninput="NetbarInfoLogic.getComputerNum()" name="end_name" placeholder="设置结束机器号">
                </div>
              </div>
              <div class="col-xs-10 col-xs-offset-1">
                <p class="form-control-static text-right">机器数：<span id="PcNum"></span></p>
              </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
        <button type="button" class="btn btn-primary" name="save_area">确 认</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="{$StaticRoot}/js/web/netbarInfo/netbarinfo.js"></script>

{include file="../common/footer.tpl"}
