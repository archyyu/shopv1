{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="batch-stock transform">
    <div class="water-btn-group">
        <button class="btn btn-primary" onclick="BatchShipment.openStockDIV();">添加调货</button>
        <div class="form-inline batch-stock-form">
            <div class="form-group">
                <label class="control-label">调货库房：</label>
                <select class="form-control selectpicker">
                </select>
            </div>
            <div class="form-group">
                <label class="control-label">进货库房：</label>
                <select class="form-control selectpicker">
                </select>
            </div>
        </div>
    </div>
    <div class="detail_content">
        <table id="transformTable" class="table table-bordered table-condensed">
            <thead>
                <tr>
                    <th>123</th>
                    <th>456</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>987</th>
                    <th>654</th>
                </tr>
            </tbody>
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
        </div>
        <div class="stock_btn">
            <button type="button" class="btn  btn-default" onclick="BatchShipment.repeal();">取消调货</button>
            <button type="button" class="btn  btn-primary" onclick="BatchShipment.save();">确认调货</button>
        </div>
    </div>
</div>

{include file="./modals/transformproduct.tpl"}


<script src="{$StaticRoot}/js/web/admin/waterbar/BatchShipment.js"></script>

{include file="../../common/footer.tpl"}