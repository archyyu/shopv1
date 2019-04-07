<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

use controller\Controller;



use service\ProductService;

/**
 * Description of ProductController
 *
 * @author YJP
 */
class ProductController extends Controller{
    //put your code here
    
    private $productService;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
    }
    
    public function index(){
        $this->smarty->display("product.tpl");
    }
    
    public function loadProductStore(){
        
    }
    
    public function loadProductType(){
        
    }
    
    public function saveProductType(){
        
    }
    
    public function loadProduct(){
        
    }
    
    public function saveProduct(){
        
    }
    
}
