<div class="modal fade" role="dialog" id="addStockMaterial">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">选择商品</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="conForm" onsubmit="javascript:return false;">
                    <div class="pop_body">
                        {*<div class="form-group">
                            <label class="col-sm-2  form-control-static ">原料分类</label>
                            <div class="col-sm-3">
                                <select class="form-control input-sm selectpicker">
                                    <option value="">默认</option>
                                </select>
                            </div>
                            <label class="col-sm-2  form-control-static ">关键字</label>
                            <div class="col-sm-3 ">
                                <input class="form-control">
                            </div>
                        </div>*}
                        <div class="row">
                            <div class="col-xs-12">
                                <p class="selectall">
                                <button class="btn btn-link" onclick="BatchStock.isCheck(this);" state="0">全选/反选&nbsp;&nbsp;</button><span id="checkNum">0</span>/{count($productlist)}
                                </p>
                                <div class="checkboxs" id="selectProductList">
                                    {foreach $productlist as $product}
                                        
                                        {if $product.producttype != 1}
                                        
                                        <div class="checkself" onclick="BatchStock.clkDIV(this);BatchStock.count();">
                                            <input type="checkbox" value="{$product.id}" typeid="{$product.typeid}" productName="{$product.productname}" unit="{$product.unit}" name="product[]" onclick="BatchStock.clkDIV($(this).parent('.checkself'));BatchStock.count();" />
                                            <span>{$product.productname}</span> 
                                        </div>
                                        {/if}
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;&nbsp;&nbsp;消</button>
                <button class="btn btn-primary" onclick="BatchStock.addProduct();">确&nbsp;&nbsp;&nbsp;&nbsp;定</button>
            </div>
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->