{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

<div class="bar-select">
  <label class="control-label">门店：</label>
  <select id="shopSelect" class="mysele" data-live-search="true" data-size="6">
    
	{foreach $shopList as $store}
	  <option value='{$store.id}' >{$store.shopname}</option>
	{/foreach}
    
  </select>
</div>

<div class="staff-list">
  <div class="staff">
      <div class="staff-group-table">
        <table id="dutyListTable" class="table table-bordered">
          <thead>
            <tr>
              <th>交班流水</th>
              <th>商品</th>
              <th>库房</th>
              <th>变动类型</th>
              <th>变动数量</th>
              <th>时间</th>
              <th>操作员</th>
              <th>备注</th>
            </tr>
          </thead>
        </table>
      </div>
  </div>
</div>

<!-- product list modal -->
 <div id="productListModal" class="modal fade product-list-modal" role="dialog">
   <div class="modal-dialog" role="document">
     <input type="hidden" value="0" name="userid" />
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title" name="title">商品售卖详情</h4>
       </div>
       <div class="modal-body">
         <table id="proListTable" class="table table-bordered">
         </table>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-primary" data-dismiss="modal">确 认</button>
       </div>
     </div><!-- /.modal-content -->
   </div>
 </div><!-- /.modal -->

<script src="{$StaticRoot}/js/web/admin/duty.js"></script>

{include file="../common/footer.tpl"}
