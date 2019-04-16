{include file="../../common/header.tpl" logo=true}

<div class="batch-stock">
    <div class="">
        <button class="btn btn-primary" data-toggle="modal" data-target="#addStockMaterial">添加进货原料</button>
    </div>
    <div class="detail_content">
        <table class="table table-bordered table-condensed">
            <thead>
                <tr>
                    <th>类型</th>
                    <th>原料名称</th>
                    <th>进货单位</th>
                    <th>进货价</th>
                    <th>进货数量</th>
                    <th>合计</th>
                    <th>操作 </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <thead>
                <tr>
                    <th colspan="5" class="text-center">小计</th>
                    <th colspan="2" class="text-center"><span id="subtotal">0</span>元</th>
                </tr>
            </thead>
        </table>
    </div>

    <div class="remark_box">
        <div class="row">
            <div class="col-md-9">
                <div class="form-group">
                    <label for="">备注：</label>
                    <input type="text" class="form-control">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="">优惠价格：</label>
                    <div class="input-group">
                        <input type="text" class="form-control" value="0" placeholder="优惠金额">
                        <div class="input-group-addon">（元）</div>
                    </div>
                </div>
                <p></p>
                <div class="form-group">
                    <label for="">实际支付：</label>
                    <p class="pay_last"><span id="payPrice">0</span>（元）</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-md-offset-3 foot_remark">
                <button type="button" class="btn  btn-default">取消进货</button>
                <button type="button" class="btn  btn-primary">确认进货</button>
            </div>
        </div>
    </div>
</div>


{include file="./modals/addbatchstock.tpl"}


{include file="../../common/footer.tpl"}