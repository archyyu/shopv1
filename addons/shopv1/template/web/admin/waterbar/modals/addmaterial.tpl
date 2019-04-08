<div id="addMaterialModal" class="modal fade add-material-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center">添加原料</h5>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-xs-12">
            <div class="form-horizontal form_info">
              <div class="form-group">
                <label class="control-label col-xs-2">操作员：</label>
                <p class="form-control-static col-xs-10"></p>
              </div>
            </div>
          </div>
          <div class="col-xs-12">
            <div class="row">
              <div class="col-xs-2 add_button">
                <button class="btn btn-block btn-success text-center"><span
                    class="pull-left">+</span>增加</button>
              </div>
            </div>
          </div>
          <div class="col-xs-12">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th style="width: 102px;">原料类型</th>
                  <th style="width: 102px;">原料名称</th>
                  <th>原料单位</th>
                  <th></th>
                </tr>
              </thead>
              <tbody id="tbodyMaterial">
                <tr class="add_input" id="cloneTrMaterial">

                  <td class="updiv">
                    <div class="tddiv">
                      <input class="form-control input-sm" type="text" style="width: 100px"/>
                      <div class="linediv" style="width:100px"></div>
                      <input type="text" style="display:none;" name="typeid" />
                    </div>
                  </td>
                  <td>
                    <input class="form-control input-sm " type="text" name="materialname">
                  </td>
                  <td>
                    <input class="form-control input-sm" name="unit">
                  </td>
                  <td>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="col-xs-2 col-xs-offset-3">
          <button type="button" class="btn btn-block btn-default"
            data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
        </div>
        <div class="col-xs-2 col-xs-offset-2">
          <button type="button" class="btn btn-block btn-primary">保存</button>
        </div>
      </div>
    </div>
  </div>
</div>