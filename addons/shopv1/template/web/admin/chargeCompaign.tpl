{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

<div class="staff-list">
    <div class="staff">
        <div class="add-staff-list">
            <button class="btn btn-sm btn-success" data-toggle="modal" onclick="Charge.openModal(0,null);">添加活动</button>
        </div>
        <div class="staff-group-table">
            <table id="chargeListTable" class="table table-bordered">
                <thead>
                <tr>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<!-- add sraff modal -->
<div id="chargeModal" class="modal fade add-staff-modal" role="dialog">
    <div class="modal-dialog" role="document">
        <input type="hidden" value="0" name="chargeid" value="0" />
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" name="title">活动编辑</h4>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group form-group-sm">
                        <label class="col-xs-3 control-label">充值</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="chargefee">
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-xs-3 control-label">赠送</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="awardfee">
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-xs-3 control-label">卡券选择</label>
                        <div class="col-xs-8">
                            <select name="cardid" class="form-control">
                                <option >空</option>
                                {foreach $cardlist as $card}
                                    <option value='{$card.id}'>{$card.cardname}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-xs-3 control-label">卡券数量</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="cardnum">
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-xs-3 control-label">积分</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="credit1">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
                <button type="button" class="btn btn-primary" onclick="Charge.saveCharge();" name="add">确 认</button>
            </div>
        </div><!-- /.modal-content -->
    </div>
</div><!-- /.modal -->

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script src="{$StaticRoot}/js/web/admin/charge.js"></script>

{include file="../common/footer.tpl"}
