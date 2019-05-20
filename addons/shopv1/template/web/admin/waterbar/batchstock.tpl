{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<textarea id="types" style="display:none;">{$types}</textarea>


<div class="batch-stock">
    <div class="water-btn-group">
        <!-- <button class="btn btn-primary" data-toggle="modal" data-target="#addStockMaterial" onclick="BatchStock.openStockDIV();">添加进货</button> -->
        <button class="btn btn-primary" onclick="BatchStock.openStockDIV();">添加进货</button>
        <div class="form-inline batch-stock-form">
            <div class="form-group">
                <label class="control-label">进货库房：</label>
                <select id="storage" class="form-control selectpicker">
                    {foreach $storelist as $store}
                    <option value='{$store.id}'>{$store.storename}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="detail_content">
        <table id="batchStockTable" class="table table-bordered table-condensed">
            <!-- <thead>
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
            </thead> -->
        </table>
    </div>

    <div class="remark_box">
        <div class="row">
            <div class="col-md-9">
                <div class="form-group">
                    <label>备注：</label>
                    <input type="text" id="remark" class="form-control">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label>优惠价格：</label>
                    <div class="input-group">
                        <input type="text" id="discount" sum="0" onchange="BatchStock.discount(this);" class="form-control" value="0" placeholder="优惠金额">
                        <div class="input-group-addon">（元）</div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="">实际支付：</label>
                    <p class="pay_last"><span id="payPrice">0</span>（元）</p>
                </div>
            </div>
        </div>
        <div class="stock_btn">
            <button type="button" class="btn  btn-default" onclick="BatchStock.repeal();">取消进货</button>
            <button type="button" class="btn  btn-primary" onclick="BatchStock.save();">确认进货</button>
        </div>
    </div>
</div>

{include file="./modals/selectproduct.tpl"}

<script src="{$StaticRoot}/js/web/admin/waterbar/BatchStock.js"></script>

{include file="../../common/footer.tpl"}