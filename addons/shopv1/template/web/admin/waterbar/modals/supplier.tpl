<div class="modal fade" id="supplierModal" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg supplier">
    <div class="modal-content">
      <div class="modal-header">
        <button class="close" data-dismiss="modal"><span>&times;</span></button>
        <h5 class="modal-title">我的供货单位</h5>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-xs-2">
            <button class="btn btn-block btn-primary btn-sm">新&nbsp;&nbsp;&nbsp;&nbsp;增</button>
          </div>
          <div class="col-xs-2">
            <button class="btn btn-block btn-success btn-sm">导出数据</button>
          </div>
          <div class="col-xs-8">
            <form id="supplierSelectForm">
              <div class="form-horizontal">
                <div class="col-xs-7">
                  <div class="form-group">
                    <div class="input-group">
                      <input type="text" class="form-control input-sm" placeholder="查询关键字" id="selectKey">
                      <span class="input-group-btn"><button class="btn btn-default btn-sm" type="button">查
                          询</button></span>
                    </div>
                  </div>
                </div>
                <div class="col-xs-5 ">
                  <label class="control-label">排序：</label>
                  <div class="radio-inline">
                    <label>
                      <input type="radio" name="ordered" id="selectTime" value="0"> 按时间
                    </label>
                  </div>
                  <!--                            <div class="radio-inline">
                                <label>
                                    <input type="radio" name="ordered"> 按供应商
                                </label>
                            </div>-->
                </div>
              </div>
            </form>
          </div>
        </div>
        <div class="row supplier_table">
          <div class="col-xs-12">
            <table class="table table-bordered table-condensed table-default">
              <thead>
                <tr>
                  <th>编号</th>
                  <th>单位名称</th>
                  <th>联系人</th>
                  <th style="width: 90px;">电话</th>
                  <th style="width: 180px;">地址</th>
                  <th>操作员 </th>
                  <th style="width: 100px;">备注</th>
                  <th>状态</th>
                  <th colspan="2" class="text-center">操作 </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>{$T.record.id}</td>
                  <td>{$T.record.name}</td>
                  <td>{$T.record.linkman}</td>
                  <td>{$T.record.phone}</td>
                  <td>{$T.record.address}</td>
                  <td>{$T.record.username}</td>
                  <td>{$T.record.remark}</td>
                  <td><button class="btn btn-xs btn-default">禁用</button></td>


                  <td class="edit_item">
                    <button class="btn btn-xs btn-link edit">编辑</button>
                  </td>
                  <td class="delete_item">
                    <button class="btn btn-xs btn-link delete">删除</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="supplier_btn">
          <button class="btn btn-block btn-info" data-dismiss="modal">关&nbsp;&nbsp;&nbsp;&nbsp;闭</button>
        </div>
      </div>
    </div>
  </div>

</div>