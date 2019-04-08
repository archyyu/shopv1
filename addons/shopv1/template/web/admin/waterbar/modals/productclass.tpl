<div id="productClassModal" class="modal fade product-class-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">商品分类</h5>
      </div>
      <div class="modal-body">
        <div class="productClass_pop">
          <div class="add-class-btn">
            <button class="btn btn-sm btn-primary" data-toggle="modal" data-target="#addProductClassModal">添加分类</button>
          </div>
          <div class="row addClass_table ">
            <div class="col-xs-12">
              <table id="productListTable" class="table table-bordered text-center">
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-default" data-dismiss="modal">关&nbsp;&nbsp;&nbsp;&nbsp;闭</button>
      </div>
    </div>
  </div>
</div>

<div id="addProductClassModal" class="modal fade add-product-class-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">新增分类</h5>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label for="" class="col-xs-3 control-label">排序：</label>
            <div class="col-xs-8">
              <input type="text" class="form-control">
            </div>
          </div>
          <div class="form-group">
            <label for="" class="col-xs-3 control-label">类别：</label>
            <div class="col-xs-8">
              <input type="text" class="form-control">
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-default" data-dismiss="modal">关&nbsp;&nbsp;&nbsp;&nbsp;闭</button>
        <button class="btn btn-primary" data-dismiss="modal">保&nbsp;&nbsp;&nbsp;&nbsp;存</button>
      </div>
    </div>
  </div>
</div>