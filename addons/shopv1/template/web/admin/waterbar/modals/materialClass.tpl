<div class="modal fade" id="materialClassModal" role="dialog" aria-hidden="true">
  <div class="modal-dialog material_manage">
    <div class="modal-content">
      <div class="modal-header">
        <button class="close" data-dismiss="modal"><span>&times;</span></button>
        <h5 class="modal-title text-center">添加原料分类</h5>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-xs-3 add_button">
            <button class="btn btn-block btn-success text-center"><span
                class="pull-left">+</span>添加分类</button>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">
            <table class="table table-bordered table-condensed">
              <tbody>
                <tr id="type_tr_{$T.record.id}">
                  <td class="order_num">{$T.record.id}</td>
                  <td>{$T.record.typename}</td>
                  <td style="widht:80px;">
                    <button class="btn btn-xs btn-link edit">编辑</button>
                  </td>
                  <td style="widht:80px;">
                    <button class="btn btn-xs btn-link delete">删除</button>
                  </td>
                </tr>
              </tbody>
            </table>
            <div class="pull-right" id="materialtypePageList">

            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="col-xs-4 col-xs-offset-4">
          <button class="btn btn-block btn-info" data-dismiss="modal">关&nbsp;&nbsp;&nbsp;&nbsp;闭</button>
        </div>
      </div>
    </div>
  </div>


</div>