<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace common;

/**
 * Description of OrderType
 *
 * @author YJP
 */
class OrderType {
    
    const ChargeOrder = 1;
    const ProductOrder = 1;
    
    const CashPay = 1;
    const WechatPay = 2;
    const AliPay = 3;
    const CardPay = 4;
    
    const UnPay = -1;
    const Payed = 0;
    const Complated = 3;
    
    const FromPhone = 0;
    const FromClient = 1;
    const FromCash = 2;
    
    const InventoryChangeOrderPay = 1;
    const InventoryChangeOrderCancel = 2;
    const InventoryChangeStock = 3;
    const InventoryChangeDiliver = 4;
    const InventoryChangeCheck = 5;
    const InventoryChangeDamage = 6;
    const InventoryChangeFlow = 7;
    const InventoryChangeTransferOut = 8;
    const InventoryChangeTransferIn = 9;
    
}
