<div class="modal fade" id="specModal" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center">进购规格</h5>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-xs-3 add_button">
            <button class="btn btn-block btn-success text-center"><span class="pull-left">+</span>添加规格</button>
          </div>
        </div>
        <div class="row materialspec_table">
          <div class="col-xs-12">
            <table class="table table-bordered table-condensed">
              <thead>
                <th>原料名称</th>
                <th>规格名称</th>
                <th>容量</th>
                <th>原料单位</th>
                <th>价格</th>
                <th colspan="2" class="text-center">操作</th>
              </thead>
              <tbody>
                <tr>
                  <td>{$T.record.materialname}</td>
                  <td>{$T.record.name}</td>
                  <td>{$T.record.volume}</td>
                  <td>{$T.record.unit}</td>
                  <td>{$T.record.price/100}元</td>
                  <td style="widht:80px;">
                    <button class="btn btn-xs btn-link edit">编辑</button>
                  </td>
                  <td style="widht:80px;">
                    <button class="btn btn-xs btn-link delete">删除</button>
                  </td>
                </tr>
              </tbody>
            </table>
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