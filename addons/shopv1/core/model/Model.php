<?php
/*!
 * Medoo database framework
 * https://medoo.in
 * Version 1.6
 *
 * Copyright 2018, Angel Lai
 * Released under the MIT license
 */

namespace model;
use PDO;
use Exception;
use PDOException;
use InvalidArgumentException;

class Model{

    protected $table;
    
    private static $medoo;

    public function __construct() {
        global $_W;
        
        if(Model::$medoo == NULL){
            $options = [
                'database_type' => 'mysql',
                'database_name' => $_W['config']['db']['master']['database'],
                'server' => $_W['config']['db']['master']['host'],
                'username' => $_W['config']['db']['master']['username'],
                'password' => $_W['config']['db']['master']['password'],
                'charset' => $_W['config']['db']['master']['charset'],

                //可选：端口
                'port' => $_W['config']['db']['master']['port'],

                //可选：表前缀
                'prefix' => $_W['config']['db']['master']['tablepre']]; 
            
            Model::$medoo = new Medoo($options);
        }

        
    }

    protected function getList($join, $columns = null, $where = null) {
        return Model::$medoo->select($this->table, $join, $columns, $where);
    }

    protected function getOne($join, $columns = null, $where = null) {
        return Model::$medoo->get($this->table, $join, $columns, $where);
    }

    protected function add(&$data) {
        $pdoStateResult = Model::$medoo->insert($this->table, $data);
        if ($pdoStateResult == false) {
            return false;
        }
        if ($pdoStateResult->rowCount() > 0) {
            $data['lastInsertId'] = Model::$medoo->id();
            return true;
        } else {
            logInfoWithArr("add error", $pdoStateResult->errorInfo());
            return false;
        }

    }
    
    public function getLastInsertId(){
        return Model::$medoo->id();
    }

    protected function save($data, $where) {
        $pdoStateResult = Model::$medoo->update($this->table, $data, $where);
        if ($pdoStateResult == false) {
            return false;
        }
        if ($pdoStateResult->rowCount() >= 0) {
            return true;
        } else {
            logInfoWithArr("save error", $pdoStateResult->errorInfo());
            return false;
        }
    }
    
    protected function remove($where){
        $pdoStateResult = Model::$medoo->delete($this->table, $where);
        if($pdoStateResult == false){
            return false;
        }
        
        if($pdoStateResult->rowCount() > 0){
            return true;
        }
        else{
            logInfoWithArr("save error", $pdoStateResult->errorInfo());
            return false;
        }
        
    }

    public function beginTransaction(){
        Model::$medoo->beginTransaction();
    }
    
    public function commit(){
        Model::$medoo->commit();
    }
    
    public function rollback(){
        Model::$medoo->rollBack();
    }
    

    public function reSelect($columns, $where) {
        return Model::$medoo->select($this->table, $columns, $where);
    }
    
    public function countNum($column, $where) {
        return Model::$medoo->count($this->table, $column, $where);
    }
    
    public function page($offset,$limit, $field, $where, $order = '', $join = '') {
        
        $data['total'] = $this->countNum($field, $where);
        $where['LIMIT'] = [$offset, $limit];
        if ($order) {
            $where['ORDER'] = [$order => 'DESC'];
        }
        if ($join) {
            $list = $this->getList($join, $field, $where);
        } else {
            $list = $this->getList($field, $where);
        }
        $data['rows'] = $list;
        return $data;
    }

}
