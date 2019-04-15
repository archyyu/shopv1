{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

{include file="../common/netbarSelect.tpl"}
<!--所有组模板-->
<script id='staffGroup' type='text/x-jsmart-tmpl'>
    {literal}
    {foreach $data as $val}
       <option value="{$val.id}">{$val.name}</option>
   {/foreach}
    {/literal}
</script>
<!--班次模板-->
<script id='staffTime' type='text/x-jsmart-tmpl'>
    {literal}
    {foreach $data as $val}
       <option value="{$val.id}">{$val.name}</option>
   {/foreach}
    {/literal}
</script>
<input type="hidden" value="0" name="gid"/>
<div class="staff-list">
  <div class="staff-group" id="staffGroup">
    <div class="add-staff-group">
      <button class="btn btn-sm btn-success" onclick="Member.initGroupSave()" data-toggle="modal" data-target="#staffGroupModal">添加员工组</button>
    </div>
    <div class="staff-group-table">
      <table id="staffGroupTable" class="table table-bordered">
        <thead>
          <tr>
            <th>员工组</th>
            <!--<th>组内成员</th>-->
            <th>操作</th>
          </tr>
        </thead>
      </table>
    </div>
  </div>
  <div class="staff-class">
    <h5>员工班次</h5>
      <table id="staffClassTable" class="table table-bordered table-straped">
        <thead>
          <tr>
            <th>班次</th>
            <th>上班时间</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
            <tr>
              <td>早班</td>
              <td>08:00 - 12:00</td>
              <td><span class="tag tag-xs tag-success">启用</span></td>
              <td>
                <button class="btn btn-xs btn-primary" disabled="disabled">编辑</button>
              </td>
            </tr>
            <tr>
              <td>中班</td>
              <td>-</td>
              <td><span class="tag tag-xs tag-info">未启用</span></td>
              <td>
                <button class="btn btn-xs btn-primary" data-toggle="modal" data-target="#staffClassModal">编辑</button>
              </td>
            </tr>
            <tr>
              <td>晚班</td>
              <td>08:00 - 12:00</td>
              <td><span class="tag tag-xs tag-success">启用</span></td>
              <td>
                <button class="btn btn-xs btn-primary" disabled="disabled">编辑</button>
              </td>
            </tr>
        </tbody>
      </table>
  </div>
  <div class="staff">
    <div class="add-staff-list">
        <button class="btn btn-sm btn-success" data-toggle="modal" onclick="Member.initStaffSave()" data-target="#addStaffModal">添加员工</button>
      </div>
      <div class="staff-group-table">
        <table id="staffListTable" class="table table-bordered">
          <thead>
            <tr>
              <th>头像</th>
              <th>姓名</th>
              <th>账号</th>
            </tr>
          </thead>
        </table>
      </div>
  </div>
</div>

<!-- staff group modal -->
<div id="staffGroupModal" class="modal fade staff-group-modal" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
            <input type="hidden" value="0" name="id"/>
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" name="title">添加员工组</h4>
        </div>
        <div class="modal-body">
          <div class="form-horizontal">
            <div class="form-group form-group-sm staff-group-name">
              <label class="col-xs-3 control-label">员工组名称</label>
              <div class="col-xs-8">
                <input name="name" class="form-control">
              </div>
            </div>
            <div class="form-group form-group-sm">
              <label class="col-xs-3 control-label">权限</label>
              <div class="col-xs-8 col-xs-offset-2"></div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
          <button type="button" class="btn btn-primary" onclick="Member.saveUserGroup()" name="addUserGroup">确 认</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->

  <!-- staff class modal -->
  <div id="staffClassModal" class="modal fade staff-class-modal" role="dialog">
      <input type="hidden" value="0" name="id"/>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" name="title">班次</h4>
          </div>
          <div class="modal-body">
            <div class="form-horizontal">
                <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">状态：</label>
                    <div class="col-xs-8">
                        <select name="state" class="form-control">
                            <option value="{$state.enable}">{$state.enable_name}</option>
                            <option value="{$state.disable}">{$state.disable_name}</option>
                        </select>
                    </div>
                </div>
              <div class="form-group form-group-sm">
                <label class="col-xs-3 control-label">上班时间</label>
                <div class="col-xs-8">
                  <input id="dutyStartTime" name="start_time" class="form-control">
                </div>
              </div>
              <div class="form-group form-group-sm">
                <label class="col-xs-3 control-label">下班时间</label>
                <div class="col-xs-8">
                  <input id="dutyEndTime" name="end_time" class="form-control">
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
            <button type="button" class="btn btn-primary" onclick="Member.saveStaffTimes()" name="add">确 认</button>
          </div>
        </div><!-- /.modal-content -->
      </div>
    </div><!-- /.modal -->

    <!-- add sraff modal -->
    <div id="addStaffModal" class="modal fade add-staff-modal" role="dialog">
        <div class="modal-dialog" role="document">
            <input type="hidden" value="0" name="id"/>
            <input type="hidden" value="1" name="dataversion"/>
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" name="title">添加员工</h4>
            </div>
            <div class="modal-body">
              <div class="form-horizontal">
                  <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">账号</label>
                    <div class="col-xs-8">
                      <input class="form-control" name="account">
                    </div>
                  </div>
                  <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">姓名</label>
                    <div class="col-xs-8">
                      <input class="form-control" name="membername">
                    </div>
                  </div>
                  <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">密码</label>
                    <div class="col-xs-8">
                      <input class="form-control" name="password" type="password">
                    </div>
                  </div>
                  <div class="form-group form-group-sm">
                      <label class="col-xs-3 control-label">生日</label>
                      <div class="col-xs-8">
                          <input name="birthday" type="text" id="buildTime" class="form-control">
                      </div>
                  </div>
                  <div class="form-group form-group-sm">
                      <label class="col-xs-3 control-label">性别</label>
                      <div class="col-xs-8">
                          <select class="form-control" name="sex">
                              <option value="{$sex.man}">{$sex.man_name}</option>
                              <option value="{$sex.woman}">{$sex.woman_name}</option>
                          </select>
                      </div>
                  </div>
                  <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">手机号</label>
                    <div class="col-xs-8">
                      <input class="form-control" name="phone">
                    </div>
                  </div>
                  <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">所在组</label>
                    <div class="col-xs-8">
                      <select class="form-control" name="groupid">

                      </select>
                    </div>
                  </div>
                  <!--<div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">工号</label>
                    <div class="col-xs-8">
                      <input class="form-control">
                    </div>
                  </div>-->
                  <div class="form-group form-group-sm">
                      <label class="col-xs-3 control-label">班次</label>
                      <div class="col-xs-8">
                          <select class="form-control" name="usertimeid">

                          </select>
                      </div>
                  </div>
                  <div class="form-group form-group-sm">
                      <label class="col-xs-3 control-label">状态</label>
                      <div class="col-xs-8">
                          <select class="form-control" name="state">
                              <option value="{$state.enable}">{$state.enable_name}</option>
                              <option value="{$state.disable}">{$state.disable_name}</option>
                          </select>
                      </div>
                  </div>
                  <!--<div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">身份证号</label>
                    <div class="col-xs-8">
                      <input class="form-control">
                    </div>
                  </div>-->
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
              <button type="button" class="btn btn-primary" onclick="Member.saveStaff()" name="add">确 认</button>
            </div>
          </div><!-- /.modal-content -->
        </div>
      </div><!-- /.modal -->

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script src="{$StaticRoot}/js/web/staff/staff.js"></script>

{include file="../common/footer.tpl"}
