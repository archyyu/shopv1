<div class="popup damage_pop" style="display: none;">
	<div class="pop_header">
		<h5 class="text-center">大可乐-报损报溢</h5>
	</div>
	<div class="pop_body">
		<input type="hidden">
		<div class="form-horizontal">
			<input type="hidden" id="damagetypeid" value="0">
			<div class="form-group form-group-sm" id="damagetype">
				<label class="col-sm-3 control-label">报损报溢：</label>
				<div class="col-sm-8">
					<label class="radio-inline">
						<input type="radio" damagetype="0" onclick="checkdamagetype(this,0)"> 报损
					</label>
					<label class="radio-inline">
						<input type="radio" damagetype="1" onclick="checkdamagetype(this,1)"> 报溢
					</label>
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-3 control-label">库房名称：</label>
				<div class="col-sm-8">
					<select class="form-control" id="damagestorageid">
														<option value="405">吧台库</option>
														<option value="483">ghfhgfgh</option>
														<option value="1015">g</option>
													</select>
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-3 control-label">数量：</label>
				<div class="col-sm-8">
					<input class="form-control" id="damageInventory">
				</div>
				<div class="col-sm-9 col-sm-offset-3">
					<span class="help-block">此数额为变动的数额</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">原因：</label>
				<div class="col-sm-8">
					<textarea class="form-control" rows="3" id="damageRemark"></textarea>
				</div>
			</div>
		</div>
		<div class="row ">
			<div class="col-sm-offset-2 col-sm-4 text-center ">
				<button class="btn btn-block btn-default" onclick="closePop();">取&nbsp;&nbsp;&nbsp;&nbsp;消</button>
			</div>
			<div class="col-sm-4 text-center">
				<input type="text" style="display:none;" id="damageId">
				<button class="btn btn-block btn-info" onclick="updateDamageInventory()">确&nbsp;&nbsp;&nbsp;&nbsp;定</button>
			</div>
		</div>
	</div>
</div>