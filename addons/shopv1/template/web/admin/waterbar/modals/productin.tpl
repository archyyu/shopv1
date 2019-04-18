<div class="modal fade" id="proInModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal"><span>&times;</span></button>
                <h5 class="modal-title"><span></span>单品进货</h5>
                <input type="hidden" name="productid" />
            </div>
            <div class="modal-body">
                <form class="form-horizontal" onsubmit="javascript:return false;">
                    <div class="form-group form-group-sm" style="margin-bottom: 0">
                        <label class="col-sm-3 control-label">物品类型：</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" name="productname">XXX</p>
                        </div>
                    </div>
                    <hr />
                    <h5>请填写以下信息：</h5>
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
                    {*<div class="form-group form-group-sm">
                        <label class="col-sm-3 control-label">规格名称：</label>
                        <div class="col-sm-8">
                            <select class="form-control selectpicker"></select>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-3 control-label">规格数量：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control">
                        </div>
                    </div>*}
                    <div class="form-group form-group-sm">
                        <label class="col-sm-3 control-label">进货总量：</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <input type="text" class="form-control" name="inventory" placeholder="输入进货数量">
                                <div class="input-group-addon" name="unit">克</div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-3 control-label">进货总价：</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="输入支付的金额">
                                <div class="input-group-addon">元</div>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="Inventory.productStock();">确认添加</button>
            </div>
        </div>

    </div>
</div>