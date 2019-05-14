<div class="modal fade" id="stockModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal"><span>&times;</span></button>
                <h5 class="modal-title"><span></span> 盘点</h5>
                <input type="hidden" name="productid" />
            </div>
            <div class="modal-body">
                <form class="form-horizontal" onsubmit="javascript:return false;">
                    <div class="form-group form-group-sm">
                        <label class="col-sm-3 control-label">库房名称：</label>
                        <div class="col-sm-8">
                           <select class="form-control selectpicker" name="store">
                                {foreach $storelist as $store}
                                    <option value='{$store.id}'>{$store.storename}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-3 control-label">盘点数量：</label>
                        <div class="col-sm-8">
                            <input class="form-control" name="inventory">
                        </div>
                        <div class="col-sm-9 col-sm-offset-3">
                            <span class="help-block">此数额为库存总数额</span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-default" data-dismiss="modal">取 &nbsp;&nbsp; 消</button>
                <button class="btn btn-sm btn-primary" onclick="Inventory.productCheck();">确 &nbsp;&nbsp; 定</button>
            </div>
        </div>
    </div>
</div>