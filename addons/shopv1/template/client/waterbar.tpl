{include file="./common/header.tpl"}

<div id="app">
    <div class="water_content">
        <div class="class">
            <div class="logo"><img src="http://placehold.it/100x66"></div>
            <div id="typeNav" class="class_nav">
                <el-menu
                    default-active="1">
                    <el-menu-item index="1" title="123">
                    </el-menu-item>
                </el-menu>
            </div>
        </div>
        <div class="content">
            <div class="banner">
                <img src="{$StaticRoot}/img/client/water_banner.png">
            </div>
            <div id="productList" class="product">

            </div>
        </div>
        <div class="checkout">
            <div class="water_info">
                <div id="memberInfo" class="clearfix">
                    <div class="water_avatar"><img id="headImgUrl" src="http://placehold.it/60x60"></div>
                    <div id="purseBalance" class="balance">
                        <p>
                            <font id="balanceTitle"></font><span><em id="balance">0</em> 元</span>
                        </p>
                    </div>
                </div>
                <!-- user ditail hover-->
                <div class="user_detail">
                    <p class="user_name text-center">亲爱的会员<span id="memberName" memberid=""></span></p>
                    <div class="user_class">
                        <p id="memberTypeName"></p>
                        <p>
                            <font id="productDiscount"></font>
                        </p>
                    </div>
                    <p>积分：<span id="memberPoints">0</span></p>
                    <div class="user_coupon">
                        <p>兑换券：<span id="couponNum">0</span>张</p>
                        <button class="btn btn-xs btn-default">查看兑换</button>
                    </div>
                </div>
                <!-- user ditail hover end-->
            </div>
            <div class="checkout_content">
                <div id="cartList">

                </div>
                <div class="meal_tips" id="mealTips" style="display:none;">
                    <p>您有<font id="orderNum"></font>个订单正在路上...</p>
                    <button class="btn btn-xs btn-link btn-text">查看订单</button>
                </div>
            </div>
            <div class="submit">
                <p>总价：<span id="totalPrice">0</span>元</p>
                <el-button type="primary" size="mini" round>下一步</el-button>
            </div>
        </div>
    </div>
</div>

<script src="{$StaticRoot}/js/client/waterbar.js"></script>

{include file="./common/footer.tpl"}