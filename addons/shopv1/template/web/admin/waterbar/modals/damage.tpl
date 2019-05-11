<div class="modal fade" tabindex="-1" role="dialog" id="damageModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">报损报溢</h4>
            </div>
            <div class="modal-body">
                    <div class="form-horizontal">
                        <input type="hidden" name="productid" value="0" />
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
                                <label class="col-sm-3 control-label" >数量：</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="num">
                                </div>
                                <div class="col-sm-9 col-sm-offset-3">
                                    <span class="help-block">正数表示报溢，负数表示报损</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" name="remark">原因：</label>
                                <div class="col-sm-8">
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
            </div>
            <div class="modal-footer">
                    <button class="btn btn-default" onclick="$('#damageModal').modal('hide');">取&nbsp;&nbsp;&nbsp;&nbsp;消</button>
                    <button class="btn btn-primary" onclick="Inventory.damage();" >确&nbsp;&nbsp;&nbsp;&nbsp;定</button>
            </div>
        </div>
    </div>
</div>