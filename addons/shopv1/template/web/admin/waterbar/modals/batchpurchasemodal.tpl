<div class="modal fade batch-purchase-modal" tabindex="-1" role="dialog" id="batchPurchaseModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
        <h4 class="modal-title">添加进货原料</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form" id="conForm" onsubmit="javascript:return false;">
          <div class="pop_body">
            <div class="form-group">
              <label for="inputEmail3" class="col-sm-2  form-control-static ">原料分类</label>
              <div class="col-sm-3">
                <select class="form-control input-sm" id="materialType">
                  <option value="">默认</option>
                  @foreach($materialTypes as $type)
                  <option value="{{$type->id}}">{{$type->typename}}</option>
                  @endForeach

                </select>
              </div>
              <label for="inputEmail3" class="col-sm-2  form-control-static ">关键字</label>
              <div class="col-sm-3 ">
                <input class="form-control" id="materialName">
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12" id="tabMaterialTemplate">

              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <div class="row btn-foot">
          <div class="col-sm-offset-2 col-sm-3 text-center ">
            <button class="btn btn-block btn-default">取&nbsp;&nbsp;&nbsp;&nbsp;消</button>
          </div>
          <div class="col-sm-3 col-sm-offset-2 text-center">
            <button class="btn btn-block btn-info">确&nbsp;&nbsp;&nbsp;&nbsp;定</button>
          </div>
        </div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->