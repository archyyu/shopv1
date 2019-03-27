<?php

pdo_query("DROP TABLE IF EXISTS ims_shopv1_shop;
create table ims_shopv1_shop(
	id int(11) auto_increment,
	shopname varchar(20) default '',
	uniacid int(11) default 0 comment '所属公众号',
	phone varchar(20) default '' comment '联系电话',
	logo varchar(200) default '' comment 'logo',
	address varchar(200) default '' comment '',
	
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_producttype;
create table ims_shopv1_producttype(
	id int(11) auto_increment,
	typename varchar(20) default '' comment '分类名称',
	uniacid int(11) default 0 comment '所属公众号',
	index int(11) default 0 comment '优先级',
	deleteflag int(11) default 0 '删除标志',	
	primary key(id)
)ENGINE=InnoDB default charset=utf8;

drop table if exists ims_shopv1_product;
create table ims_shopv1_product(
	id int(11) auto_increment,
	productname varchar(20) default '',
	normalprice int(11) default 0 comment '正常价格',
	memberprice int(11) default 0 comment '会员价',
	userget int(11) default 0 comment '员工收益',
	uniacid int(11) default 0 comment '所属公众号',
	visibleshops varchar(20) default '' comment '在哪些门店可用',
	salenum int(11) default 0 comment '销量',
	deleteflag int(11) default 0,
	primary key(id)
)ENGINE=InnoDB default charset=utf8;

drop table if exists ims_shopv1_store;
create table ims_shopv1_store(
	id int(11) auto_increment,
	storename varchar(30) default '',
	uniacid int(11) default '' comment '所属公众号',
	deleteflag int(11) default 0,
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_productinventory;
create table ims_shopv1_productinventory(
	id int(11) auto_increment,
	uniacid int(11) default 0,
	productid int(11) default 0 comment '商品或者原料id',
	storeid int(11) default 0 comment '库房id',
	inventory int(11) default 0 comment '库存',
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_inventorylog;
create table ims_shopv1_inventorylog(
	id int(11) auto_increment,
	uniacid int(11) default 0,
	productid int(11) default 0,
	storeid int(11) default 0,
	num int(11) default 0 comment '变更数量',
	logtype int(11) default 0 comment '变更类型',
	detail varchar(30) default '' comment '变更详情',
	createtime int(20) default 0 comment '时间',
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_cardtype;
create table ims_shopv1_cardtype(
	id int(11) auto_increment,
	cardname varchar(30) default '',
	cardtype int(11) default 0,
	discount int(11) default 0,
	exchange int(11) default 0,
	uniacid int(11) default 0,
	effectiveday int(11) default 0,
	deleteflag int(11) default 0,
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_membercard;
create table ims_shopv1_membercard(
	id int(11) auto_increment,
	cardid int(11),
	memberid int(11),
	useflag int(11) default 0,
	gettime int(20) default 0,
	deleteflag int(11) default 0,
	userid int(11) default '',
	gettype int(11) default '',
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_shift;
create table ims_shopv1_shift(
	id int(11) auto_increment,
	shopid int(11),
	shifyindex int(11),
	userid int(11),
	productcash int(11),
	productwechat int(11),
	productalipay int(11),
	cardnum int(11),
	starttime int(20) comment '接班时间',
	submittime int(20) comment '交班时间',
	deleteflag int(11) default 0,
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_user;
create table ims_shopv1_user(
	id int(11) auto_increment,
	username varchar(20) default '',
	uniacid int(11) default 0,
	deleteflag int(11) default 0,
	shopid int(11) default 0,
	role int(11) default 0,
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_order;
create table ims_shopv1_order(
	id int(20),
	createtime int(20) comment '订单创建时间',
	orderprice int(11) comment '订单价格',
	paytime int(20) comment '支付时间',
	ordersource int(11) comment '',
	ordertype int(11) comment '',
	orderstate int(11) comment '',
	address varchar(200) comment '位置',
	shopid int(11),
	uniacid int(11),
	remark varchar(20),
	
	primary key(id)
)engine=InnoDB default charset=utf8;

drop table if exists ims_shopv1_orderproduct;
create table ims_shopv1_orderproduct(
	id int(20),
	orderid int(20),
	productid int(20),
	num int(11),
	orderstate int(11),
	deleteflag int(11) default 0,
	primary key(id)
)engine=InnoDB default charset=utf8;");