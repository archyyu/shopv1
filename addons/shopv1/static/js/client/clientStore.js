/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


class ClientStore{
    
    static createParams(){
        let params = {};
        params.shopid = UrlUtil.getQueryString("shopid");
        params.source = 2;
        return params;
    }
    
};