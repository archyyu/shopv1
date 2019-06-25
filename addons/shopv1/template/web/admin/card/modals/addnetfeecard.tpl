<div id="addNetfeeCardModal" class="modal fade add-card-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加/更新网费兑换券</h5>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券ID：</label>
                        <p class="form-control-static col-xs-8">默认</p>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券类型：</label>
                        <p class="form-control-static col-xs-8">网费兑换券</p>
                        <input type="hidden" name="netcardid" value="0" />
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券名称：</label>
                        <div class="col-xs-8">
                            <input type="text" name="netcardname" class="form-control" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券有效期：</label>
                        <div class="col-xs-8">
                            <input id="netfeeDate" type="text" name="nettimearea" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">抵现金额：</label>
                        <div class="col-xs-8">
                            <input type="tel" name="netexchange" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
                <button class="btn btn-primary" onclick="CardType.saveNetCard();">确 &nbsp;&nbsp; 认</button>
            </div>
        </div>
    </div>
</div>

<!-- <script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script>
    $(".range-picker-js").daterangepicker();
</script> -->