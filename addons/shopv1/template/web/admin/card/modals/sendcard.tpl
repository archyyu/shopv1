<div id="sendCardModal" class="modal fade send-card-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">发行卡券</h5>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-xs-3">用户</label>
                        <div class="col-xs-8">
                            <textarea rows="3" class="form-control"></textarea>
                            <button class="btn btn-link btn-primary" data-toggle="modal" data-target="#selectMemberModal">选择会员</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">用户组：</label>
                        <div class="col-xs-8">
                            <label class="checkbox-inline">
                                <input type="checkbox" checked> 全体用户
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">发送卡券数量</label>
                        <div class="col-xs-8">
                            <div class="input-group">
                                <input type="number" class="form-control">
                                <span class="input-group-addon">张/人</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
                <button class="btn btn-primary">确 &nbsp;&nbsp; 认</button>
            </div>
        </div>
    </div>
</div>