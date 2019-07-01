<div id="addCardModal" class="modal fade add-card-modal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加/更新商品抵现卡券</h5>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券ID：</label>
                        <p class="form-control-static col-xs-8">默认</p>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券类型：</label>
                        <p name="cardtypename" class="form-control-static col-xs-8">商品抵现券</p>
                        <input name="cardtype" type="hidden" value="0"/>
                        <input type="hidden" name="cardid" value="0" />
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券名称：</label>
                        <div class="col-xs-8">
                            <input type="text" name="cardname" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">商品类型：</label>
                        <div class="col-xs-8">
                            <select id="producttype" class="form-control input-sm selectpicker">
                                <option value='0'>请选择</option>
                                {foreach $typelist as $type}
                                <option value='{$type.id}'>{$type.typename}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">商品：</label>
                        <div class="col-xs-8">
                            <select id="product" class="form-control input-sm selectpicker">
                                
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">抵现金额：</label>
                        <div class="col-xs-8">
                            <input type="text" name="exchange" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">折扣值：</label>
                        <div class="col-xs-8">
                            <input type="text" name="discount"  class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">最低使用价格：</label>
                        <div class="col-xs-8">
                            <input type="num" name="effectiveprice"  class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">卡券有效期：</label>
                        <div class="col-xs-8">
                            <div class="input-group col-xs-6">
                                <input type="text" name="effectiveday" class="form-control">
                                <span class="input-group-addon">天</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">放&nbsp;&nbsp;&nbsp;&nbsp;弃</button>
                <button class="btn btn-primary" onclick="CardType.saveCard();">确 &nbsp;&nbsp; 认</button>
            </div>
        </div>
    </div>
</div>