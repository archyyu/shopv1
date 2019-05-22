<div class="modal fade" role="dialog" id="transformMaterial">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">选择商品</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="conForm" onsubmit="javascript:return false;">
                    <div class="pop_body">
                        <div class="row">
                            <div class="col-xs-12">
                                <p class="selectall">
                                <button class="btn btn-link" onclick="Transform.isCheck(this);" state="0">全选/反选&nbsp;&nbsp;</button><span id="checkNum">0</span>/10
                                </p>
                                <div class="checkboxs" id="selectProductList">  
                                    <div class="checkself">
                                        <input type="checkbox">
                                        <span>XXX</span> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;&nbsp;&nbsp;消</button>
                <button class="btn btn-primary">确&nbsp;&nbsp;&nbsp;&nbsp;定</button>
            </div>
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->