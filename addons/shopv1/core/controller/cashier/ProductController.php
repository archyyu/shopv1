<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

use model\Controller;
use service\ProductService;

class ProductController extends Controller{
    
    private $productService;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
    }
    
    public function loadProductTypeList(){
        
        
        
    }
    
}