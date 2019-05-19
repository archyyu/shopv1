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
    <div class="add-staff-list">
        <button class="btn btn-sm btn-success" data-toggle="modal" onclick="Banner.openModal();" >添加轮播图</button>
      </div>
      <div class="staff-group-table">
        <table id="bannerListTable" class="table table-bordered">
          <thead>
            <tr>
            </tr>
          </thead>
        </table>
      </div>
  </div>
</div>

    <!-- add sraff modal -->
    <div id="addBannerModal" class="modal fade add-staff-modal" role="dialog">
        <div class="modal-dialog" role="document">
            <input type="hidden" value="0" name="userid"/>
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" name="title">添加轮播图</h4>
            </div>
            <div class="modal-body">
              <div class="form-horizontal">
                  <div class="form-group form-group-sm">
                    <label class="col-xs-3 control-label">优先级</label>
                    <div class="col-xs-8">
                      <input class="form-control" name="index">
                    </div>
                  </div>
                  <div class="form-group form-group-sm">
                    <label class="col-sm-3 control-label">
                      商品LOGO：
                    </label>
                    <div class="col-sm-8">
                      <label class="upload-area">
                        <span class="iconfont icon-add"></span>
                        <img id="previewImg" alt="logo">
                        <input type="file" class="logo-input" name="logo" id="logoInput" onchange="Banner.uploadLogo('logoInput','previewImg',120,120)">
                      </label>
                    </div>
                  </div>
                  
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
              <button type="button" class="btn btn-primary" onclick="Banner.saveBanner();" name="add">确 认</button>
            </div>
          </div><!-- /.modal-content -->
        </div>
      </div><!-- /.modal -->
      
<script src="{$StaticRoot}/js/web/admin/banner.js"></script>

{include file="../common/footer.tpl"}
