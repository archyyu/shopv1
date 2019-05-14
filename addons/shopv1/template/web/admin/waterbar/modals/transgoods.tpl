<div class="modal fade" id="transferModal" role="dialog">
    <div class="modal-dialog transfer_goods">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal"><span>&times;</span></button>
                <h5 class="modal-title"><span></span>调货</h5>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-6 transfer_out">
                        <h5>商品调出</h5>
                        <input type="hidden" name="productid" value="0" />
                        <div>
                            <div class="form-horizontal">
                                <div class="form-group form-group-sm">
                                    <label class="col-xs-5 control-label">库房：</label>
                                    <div class="col-xs-7">
                                        <select class="form-control" name="sourceid" onchange="Inventory.transferStoreChange();">
                                            {foreach $storelist as $store}
                                                <option value='{$store.id}'>{$store.storename}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="col-xs-5 control-label">现库存：</label>
                                    <p class="col-xs-7 form-control-static" name="inventory">0</p>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="col-xs-5 control-label">单位：</label>
                                    <p class="col-xs-7 form-control-static" name="unit">米</p>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="col-xs-5 control-label">数量：</label>
                                    <div class="col-xs-7">
                                        <input class="form-control" name="num">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6 transfer_in">
                        <h5>商品调入</h5>
                        <div>
                            <div class="form-horizontal">
                                <div class="form-group form-group-sm">
                                    <label class="col-xs-5 control-label">库房：</label>
                                    {*<p class="col-xs-7 form-control-static"> 吧台库 </p>*}
                                    <select class="col-xs-7 form-control-static" name="destinationid">
                                        {foreach $storelist as $store}
                                            <option value='{$store.id}'>{$store.storename}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">关 &nbsp;&nbsp; 闭</button>
                <button type="button" class="btn btn-primary" onclick="Inventory.inventoryTransfer();">调 &nbsp;&nbsp; 货</button>
            </div>
        </div>

    </div>
</div>