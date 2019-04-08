<div id="addCardModal" class="modal fade add-card-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加卡券</h5>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券ID：</label>
                        <p class="form-control-static col-xs-8">默认</p>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券类型：</label>
                        <p class="form-control-static col-xs-8">默认</p>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券名称：</label>
                        <div class="col-xs-8">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">折扣值：</label>
                        <div class="col-xs-8">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">最低使用价格：</label>
                        <div class="col-xs-8">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">使用场景：</label>
                        <div class="col-xs-8">
                            <select class="form-control selectpicker">
                                <option value="">不限</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">允许收银端发送：</label>
                        <div class="col-xs-8">
                            <label class="checkbox-inline">
                                <input type="checkbox" checked> 允许
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券有效期：</label>
                        <div class="col-xs-8">
                            <label class="radio-inline">
                                <input type="radio" checked> 按天数
                            </label>
                            <div class="input-group col-xs-6">
                                <input type="text" class="form-control">
                                <span class="input-group-addon">天</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
                <button class="btn btn-primary">确 &nbsp;&nbsp; 认</button>
            </div>
        </div>
    </div>
</div>