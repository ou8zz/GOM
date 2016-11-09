-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2012-10-25 09:30:14
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

/** add user and grant privileges to it. */
create user 'gom'@'localhost' identified by '654321';
grant SELECT,INSERT,UPDATE,DELETE,CREATE,DROP on gom.* to 'gom'@'localhost';

-- Dumping database structure for gom
CREATE DATABASE IF NOT EXISTS `gom` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `gom`;

DROP FUNCTION IF EXISTS sum_item;
delimiter //
/*
 * 统计给定项目，给定日期或期限的单项目总值
 * 
 * param in_range 日/周/月/季/年  从DateRange Enum中得到，注意传入整数
 * param in_date 统计日期
 * param in_userId 用户ID
 * param in_item 统计条目
 * 
 * return l_sum 统计结果
 * 
 * */
CREATE FUNCTION sum_item(in_range INT, in_date DATE, in_userId INT, in_item INT) RETURNS INT
BEGIN
	DECLARE l_sum INT;
	CASE in_range
	  WHEN 0 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.dated=DATE(in_date);
	  WHEN 1 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.dated=WEEKOFYEAR(in_date);
	  WHEN 2 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND MONTH(s.dated)=MONTH(in_date);
	  WHEN 3 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND QUARTER(s.dated)=QUARTER(in_date);
	  WHEN 4 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND YEAR(s.dated)=YEAR(in_date);
	END CASE;
	RETURN l_sum;
END;//
-- Dumping structure for table gom.address
CREATE TABLE IF NOT EXISTS `address` (QUARTER(dated)
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addrType` tinyint(4) unsigned DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `cell` varchar(11) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `relation` varchar(10) NOT NULL,
  `zipcode` varchar(6) DEFAULT NULL,
  `user_address_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1ED033D45358BB32` (`user_address_fk`),
  CONSTRAINT `FK1ED033D45358BB32` FOREIGN KEY (`user_address_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.address: ~0 rows (approximately)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;


-- Dumping structure for table gom.asset
CREATE TABLE IF NOT EXISTS `asset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin` varchar(15) NOT NULL,
  `ascription` varchar(15) NOT NULL,
  `assetName` varchar(30) NOT NULL,
  `assetState` tinyint(4) unsigned NOT NULL,
  `assetType` tinyint(4) unsigned NOT NULL,
  `attachment` varchar(36) DEFAULT NULL,
  `buyDate` date DEFAULT NULL,
  `buyNum` int(10) NOT NULL,
  `buyer` varchar(15) NOT NULL,
  `controlDate` date DEFAULT NULL,
  `des` varchar(100) DEFAULT NULL,
  `scrapDate` date DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `warrantyDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.asset: ~0 rows (approximately)
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;


-- Dumping structure for table gom.borrow
CREATE TABLE IF NOT EXISTS `borrow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `applyState` tinyint(4) unsigned DEFAULT NULL,
  `funCode` varchar(50) NOT NULL,
  `overStaff` varchar(12) NOT NULL,
  `receiveDate` date DEFAULT NULL,
  `receiveNum` int(10) NOT NULL,
  `receiver` varchar(12) NOT NULL,
  `remark` varchar(80) DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `asset_borrow_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK76F1961559B4B28E` (`asset_borrow_fk`),
  CONSTRAINT `FK76F1961559B4B28E` FOREIGN KEY (`asset_borrow_fk`) REFERENCES `asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.borrow: ~0 rows (approximately)
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;


-- Dumping structure for table gom.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `node` varchar(10) NOT NULL,
  `parentid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PARENTID` (`parentid`),
  CONSTRAINT `FK_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.category: ~0 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Dumping structure for table gom.config
CREATE TABLE IF NOT EXISTS `config` (
  `_key` varchar(45) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.config: ~24 rows (approximately)
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` (`_key`, `name`, `value`) VALUES
	('basis', '基础参数', NULL),
	('basis.adminIT', 'IT管理员', 'admin'),
	('basis.company.cn', '公司中文名称', '上海实名信息科技有限公司'),
	('basis.company.en', '公司英文名称', 'SQE SERVICE'),
	('basis.jobNo.prefix', '工号前缀', 'SQE'),
	('basis.mail.host', '邮件服务主机', 'mail.sqeservice.com'),
	('basis.mail.pwd', '系统邮件账号密码', 'service11'),
	('basis.mail.user', '系统邮件账号', 'gom-admin@sqeservice.com'),
	('basis.version', '系统版本', '3.0'),
	('departure', '离职流程节点参数', NULL),
	('departure.fieldwork.days', '实习生离职提前天数', '7'),
	('departure.financial', '离职财务核算专员', 'test2'),
	('departure.HR', '离职审核人事专员', 'test1'),
	('departure.qualified.days', '正式员工离职申请提前天数', '30'),
	('departure.training.days', '试用期员工离职提前天数', '15'),
	('entrant', '入职流程节点参数', NULL),
	('entrant.HR', '入职资料审核人事专员', 'admin'),
	('fileUpload', '文件上传参数组', NULL),
	('fileUpload.rootPath', '上传根目录', 'E:/workspace/gom/src/main/webapp/uploads/'),
	('fileUpload.typesAllows', '允许上传文件类型', 'jpg,gif,png,pdf,doc,docx,xls,xlsx'),
	('fileUpload.typesForbid', '禁止上传类型', 'exe,bat,sh'),
	('leave', '请假模块参数组', NULL),
	('leave.daysDtr', '部门主管可批准的请假天数', '1'),
	('leave.daysMgr', '部门经理可批准的请假天数', '3');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;


-- Dumping structure for table gom.departure
CREATE TABLE IF NOT EXISTS `departure` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `handover` varchar(500) DEFAULT NULL,
  `reason` varchar(200) NOT NULL,
  `recipient` varchar(15) DEFAULT NULL,
  `recipientDpt` varchar(15) DEFAULT NULL,
  `recipientJobNo` varchar(15) DEFAULT NULL,
  `recipientPst` varchar(15) DEFAULT NULL,
  `salaryDate` date DEFAULT NULL,
  `state` tinyint(4) unsigned DEFAULT NULL,
  `toMailAddr` varchar(350) DEFAULT NULL,
  `user_departure_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2EC128D44756C132` (`user_departure_fk`),
  CONSTRAINT `FK2EC128D44756C132` FOREIGN KEY (`user_departure_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.departure: ~0 rows (approximately)
/*!40000 ALTER TABLE `departure` DISABLE KEYS */;
/*!40000 ALTER TABLE `departure` ENABLE KEYS */;


-- Dumping structure for table gom.education
CREATE TABLE IF NOT EXISTS `education` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ed` varchar(16) NOT NULL,
  `endDate` date DEFAULT NULL,
  `idScan` varchar(36) DEFAULT NULL,
  `idno` varchar(30) DEFAULT NULL,
  `major` varchar(20) NOT NULL,
  `school` varchar(30) NOT NULL,
  `startDate` date DEFAULT NULL,
  `user_education_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK661D8788AD8775FE` (`user_education_fk`),
  CONSTRAINT `FK661D8788AD8775FE` FOREIGN KEY (`user_education_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.education: ~0 rows (approximately)
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
/*!40000 ALTER TABLE `education` ENABLE KEYS */;


-- Dumping structure for table gom.experience
CREATE TABLE IF NOT EXISTS `experience` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createDate` date DEFAULT NULL,
  `gain` text,
  `student` varchar(15) NOT NULL,
  `resource_how_fk` int(10) unsigned DEFAULT NULL,
  `training_experience_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK71B8358A540790D5` (`resource_how_fk`),
  KEY `FK71B8358A3618EA51` (`training_experience_fk`),
  CONSTRAINT `FK71B8358A3618EA51` FOREIGN KEY (`training_experience_fk`) REFERENCES `training` (`id`),
  CONSTRAINT `FK71B8358A540790D5` FOREIGN KEY (`resource_how_fk`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.experience: ~0 rows (approximately)
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;


-- Dumping structure for table gom.fixedtask
CREATE TABLE IF NOT EXISTS `fixedtask` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createDate` datetime DEFAULT NULL,
  `des` varchar(500) DEFAULT NULL,
  `expectedEnd` time DEFAULT NULL,
  `expectedStart` time DEFAULT NULL,
  `frequency` int(10) DEFAULT NULL,
  `hours` float DEFAULT NULL,
  `period` smallint(6) DEFAULT NULL,
  `state` tinyint(4) unsigned DEFAULT NULL,
  `taskTitle` varchar(35) NOT NULL,
  `updateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.fixedtask: ~0 rows (approximately)
/*!40000 ALTER TABLE `fixedtask` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixedtask` ENABLE KEYS */;


-- Dumping structure for table gom.guser
CREATE TABLE IF NOT EXISTS `guser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(19) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `bank` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `cell` varchar(15) NOT NULL,
  `censusType` tinyint(4) unsigned DEFAULT NULL,
  `cname` varchar(12) NOT NULL,
  `documents` tinyint(4) unsigned NOT NULL,
  `email` varchar(35) DEFAULT NULL,
  `emailPwd` varchar(16) DEFAULT NULL,
  `ename` varchar(15) NOT NULL,
  `entryDate` date DEFAULT NULL,
  `exitDate` date DEFAULT NULL,
  `fullDate` date DEFAULT NULL,
  `gender` tinyint(4) unsigned DEFAULT NULL,
  `height` varchar(3) DEFAULT NULL,
  `idScan` varchar(36) DEFAULT NULL,
  `idcard` varchar(18) NOT NULL,
  `jobNo` varchar(15) NOT NULL,
  `locked` bit(1) DEFAULT NULL,
  `marriage` tinyint(4) unsigned DEFAULT NULL,
  `nation` varchar(8) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `portrait` varchar(36) DEFAULT NULL,
  `privateMail` varchar(35) DEFAULT NULL,
  `pwd` varchar(32) NOT NULL,
  `telExt` varchar(5) DEFAULT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.guser: ~1 rows (approximately)
/*!40000 ALTER TABLE `guser` DISABLE KEYS */;
INSERT INTO `guser` (`id`, `accountNo`, `active`, `bank`, `birthday`, `cell`, `censusType`, `cname`, `documents`, `email`, `emailPwd`, `ename`, `entryDate`, `exitDate`, `fullDate`, `gender`, `height`, `idScan`, `idcard`, `jobNo`, `locked`, `marriage`, `nation`, `phone`, `portrait`, `privateMail`, `pwd`, `telExt`, `type`) VALUES
	(1, '6226555488855445', b'10000000', '中国建设银行', '1994-09-01', '8613588746566', 1, '管理员', 1, 'gom-admin@sqeservice.com', 'service11', 'admin', '2012-09-25', NULL, NULL, 0, '163', 'ab2938b5f6dc4bbe82301f18175ffef9.jpg', '430902198710015578', 'SQE12004', b'00000000', 1, '汉族', '0737-21321321', '1fa0e2627404477b8391f31390829676.jpg', 'gom-admin@sqeservice.com', '905dcb52b6585ac391ffcf8162cd6c99', NULL, 2);
/*!40000 ALTER TABLE `guser` ENABLE KEYS */;


-- Dumping structure for table gom.leaves
CREATE TABLE IF NOT EXISTS `leaves` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agent` varchar(12) NOT NULL,
  `agentCname` varchar(12) NOT NULL,
  `agentDpt` varchar(15) NOT NULL,
  `agentJobNo` varchar(15) NOT NULL,
  `agentPst` varchar(15) NOT NULL,
  `applyDate` datetime NOT NULL,
  `contact` varchar(30) NOT NULL,
  `days` smallint(6) NOT NULL,
  `endDate` datetime NOT NULL,
  `event` varchar(150) NOT NULL,
  `handOver` varchar(500) NOT NULL,
  `recipient` varchar(15) NOT NULL,
  `relationAddr` varchar(300) DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `state` tinyint(4) unsigned NOT NULL,
  `type` tinyint(4) unsigned NOT NULL,
  `user_leave_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKBE08889C14E11AE5` (`user_leave_id`),
  CONSTRAINT `FKBE08889C14E11AE5` FOREIGN KEY (`user_leave_id`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.leaves: ~0 rows (approximately)
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;


-- Dumping structure for table gom.login
CREATE TABLE IF NOT EXISTS `login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `des` varchar(150) DEFAULT NULL,
  `loginIP` varchar(15) NOT NULL,
  `loginOut` datetime DEFAULT NULL,
  `loginTake` varchar(250) NOT NULL,
  `loginTime` datetime DEFAULT NULL,
  `unlockTime` time DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK462FF49AB101B5D` (`user_id`),
  CONSTRAINT `FK462FF49AB101B5D` FOREIGN KEY (`user_id`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.login: ~0 rows (approximately)
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
/*!40000 ALTER TABLE `login` ENABLE KEYS */;


-- Dumping structure for table gom.meeting
CREATE TABLE IF NOT EXISTS `meeting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(200) DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `explains` varchar(200) DEFAULT NULL,
  `host` varchar(20) NOT NULL,
  `isTrace` bit(1) DEFAULT NULL,
  `locale` varchar(20) NOT NULL,
  `notes` varchar(20) NOT NULL,
  `number` varchar(20) NOT NULL,
  `participants` varchar(50) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `title` varchar(20) NOT NULL,
  `traceDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.meeting: ~0 rows (approximately)
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;


-- Dumping structure for table gom.process
CREATE TABLE IF NOT EXISTS `process` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actor` varchar(15) DEFAULT NULL,
  `assignType` tinyint(4) unsigned NOT NULL,
  `icon` varchar(36) DEFAULT NULL,
  `nodeCode` varchar(10) NOT NULL,
  `nodeName` varchar(20) DEFAULT NULL,
  `nodeOrder` int(10) NOT NULL,
  `type` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.process: ~27 rows (approximately)
/*!40000 ALTER TABLE `process` DISABLE KEYS */;
INSERT INTO `process` (`id`, `actor`, `assignType`, `icon`, `nodeCode`, `nodeName`, `nodeOrder`, `type`) VALUES
	(1, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Apply', '申请人', 1, 3),
	(2, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '直接主管', 2, 3),
	(3, 'test4', 0, '253534dc6b794874aa048d57ec62544c.jpg', 'Personnel', '离职审核人事专员', 3, 3),
	(4, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Receiver', '工作接收人', 4, 3),
	(5, 'ABCD', 0, '253534dc6b794874aa048d57ec62544c.jpg', 'Financial', '离职财务结算专员', 5, 3),
	(6, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Adjustment', '工作接收人责任调整', 6, 3),
	(7, 'basis.adminIT', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Technology', 'IT管理员', 7, 3),
	(8, 'departure.ftl', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Email', '发送邮件', 8, 3),
	(9, 'Close', 4, '2dd62e0cbb8c4d67833331dbb1bd376a.jpg', 'End', '流程结束', 9, 3),
	(10, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'newEntry', '新职员', 1, 2),
	(11, 'entrant.HR', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Personnel', '人事审核资料', 2, 2),
	(12, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '主管分配职责', 3, 2),
	(13, 'basis.adminIT', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Technology', 'IT管理员开通帐号', 4, 2),
	(14, 'entrant.ftl', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Email', '发送入职邮件', 5, 2),
	(15, 'Close', 4, '2dd62e0cbb8c4d67833331dbb1bd376a.jpg', 'End', '流程结束', 6, 2),
	(16, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Apply', '申请人', 1, 0),
	(17, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Agent', '代理人', 2, 0),
	(18, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '直接主管', 3, 0),
	(19, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Manager', '上级管理者', 4, 0),
	(20, 'leave.ftl', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Email', '发送邮件', 5, 0),
	(21, 'Close', 4, '2dd62e0cbb8c4d67833331dbb1bd376a.jpg', 'End', '流程结束', 6, 0),
	(22, 'OLEZ,ABCD', 1, '253534dc6b794874aa048d57ec62544c.jpg', 'AddTask', '添加工作', 1, 1),
	(23, 'OLEZ,ABCD', 1, '253534dc6b794874aa048d57ec62544c.jpg', 'Allocation', '分配工作', 2, 1),
	(24, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Executor', '执行者', 3, 1),
	(25, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Help', '需要帮忙', 4, 1),
	(26, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '审核者', 5, 1),
	(27, 'Close', 4, '2dd62e0cbb8c4d67833331dbb1bd376a.jpg', 'End', '结束', 6, 1);
/*!40000 ALTER TABLE `process` ENABLE KEYS */;


-- Dumping structure for table gom.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `explains` varchar(200) NOT NULL,
  `num` int(10) NOT NULL,
  `outputDate` date DEFAULT NULL,
  `productName` varchar(12) NOT NULL,
  `productType` tinyint(4) unsigned DEFAULT NULL,
  `unit` varchar(10) NOT NULL,
  `version` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.product: ~0 rows (approximately)
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;


-- Dumping structure for table gom.project
CREATE TABLE IF NOT EXISTS `project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actualEnd` date DEFAULT NULL,
  `actualTime` varchar(10) DEFAULT NULL,
  `des` varchar(200) DEFAULT NULL,
  `director` varchar(15) NOT NULL,
  `endDate` date DEFAULT NULL,
  `expectedTime` varchar(10) DEFAULT NULL,
  `projectName` varchar(30) NOT NULL,
  `projectNo` varchar(30) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `state` tinyint(4) unsigned DEFAULT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `parentid` int(10) unsigned DEFAULT NULL,
  `project_product_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK50C8E2F92C5EF48` (`project_product_fk`),
  KEY `FK_PROJECT_PARENTID` (`parentid`),
  CONSTRAINT `FK50C8E2F92C5EF48` FOREIGN KEY (`project_product_fk`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_PROJECT_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.project: ~0 rows (approximately)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


-- Dumping structure for table gom.resource
CREATE TABLE IF NOT EXISTS `resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attachment` varchar(36) NOT NULL,
  `createDate` date DEFAULT NULL,
  `des` varchar(200) NOT NULL,
  `downloadDate` date DEFAULT NULL,
  `isValid` bit(1) DEFAULT NULL,
  `level` varchar(15) DEFAULT NULL,
  `maintainDpt` varchar(20) NOT NULL,
  `resourceType` tinyint(4) unsigned DEFAULT NULL,
  `responsibility` varchar(255) DEFAULT NULL,
  `score` int(10) NOT NULL,
  `swot` varchar(255) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `updateDate` date DEFAULT NULL,
  `uploadDate` date DEFAULT NULL,
  `uploadEname` varchar(16) NOT NULL,
  `version` varchar(15) NOT NULL,
  `category_resource_fk` int(10) unsigned DEFAULT NULL,
  `number` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKEF86282EE2CDBA35` (`category_resource_fk`),
  CONSTRAINT `FKEF86282EE2CDBA35` FOREIGN KEY (`category_resource_fk`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.resource: ~0 rows (approximately)
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;


-- Dumping structure for table gom.responsibility
CREATE TABLE IF NOT EXISTS `responsibility` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `explanation` varchar(100) NOT NULL,
  `funcode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `parentid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_R_PARENTID` (`parentid`),
  CONSTRAINT `FK_R_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `responsibility` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.responsibility: ~24 rows (approximately)
/*!40000 ALTER TABLE `responsibility` DISABLE KEYS */;
INSERT INTO `responsibility` (`id`, `explanation`, `funcode`, `name`, `parentid`) VALUES
	(1, '所有涉及开发编码的程序开发工作', 'F2_0', '程序开发', NULL),
	(2, '对需求分析并编写开发文档', 'F2_1', '文档编写', 1),
	(3, '程序的测试（包括单元、集成，压力等所有测试）', 'F2_2', '程序测试', 1),
	(4, '功能的代码编写实现', 'F2_3', '编码开发', 1),
	(5, '对编写程序的再修改或变更', 'F2_4', '程序DEBUG', 1),
	(6, '最终用户UI的白盒测试', 'F2_5', '页面测试', 1),
	(7, '负责公司项目的立项、需要设计、资源分配等', 'F1_0', '项目管理', NULL),
	(8, '跟踪项目成员的最新进度', 'F1_1', '开发进度追踪', 7),
	(9, '所有项目的需求分析设计文档', 'F1_2', '需求分析设计文档', 7),
	(10, '确定分歧问题，定案解决思路', 'F1_3', '项目研讨定案', 7),
	(11, '根据需求档编写开发文档', 'F1_4', '编写开发文档', 7),
	(12, '为项目成员解决技术难点', 'F1_5', '技术疑难解决', 7),
	(13, '负责公司账务、税费、日常收支等 管理', 'F3_0', '账务、税费收支管理', NULL),
	(14, '公司所涉及的税收、应缴税款', 'F3_1', '税费统计结算', 13),
	(15, '员工薪酬统计，奖金结算', 'F3_2', '薪酬奖金统计', 13),
	(16, '公司内部的日常', 'F3_3', '日常收支', 13),
	(17, '员工的差旅收支结算', 'F3_4', '差旅结算', 13),
	(18, '所有公司往来账务统计、结算、收支', 'F3_5', '业务帐务', 13),
	(19, 'UI图片的PS、DW设计制作', 'F4_0', 'UI设计制作', NULL),
	(20, '按需求制作UI版面', 'F4_2', 'UI版面制作', 19),
	(21, '按W3C业界标准优化或整合图片', 'F4_3', 'WEB图片优化', 19),
	(22, '按W3C标准优化页面布局', 'F4_4', 'CSS样式优化', 19),
	(23, '按需求PS或其他工具制作UI图片', 'F4_5', 'UI图片制作', 19),
	(24, '所涉及的界面图片设计', 'F4_1', 'UI图片或版面设计', 19);
/*!40000 ALTER TABLE `responsibility` ENABLE KEYS */;


-- Dumping structure for table gom.swot
CREATE TABLE IF NOT EXISTS `swot` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `countType` tinyint(4) unsigned DEFAULT NULL,
  `foreignEntityId` int(10) DEFAULT NULL,
  `rolling` float DEFAULT NULL,
  `swotType` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.swot: ~0 rows (approximately)
/*!40000 ALTER TABLE `swot` DISABLE KEYS */;
/*!40000 ALTER TABLE `swot` ENABLE KEYS */;


-- Dumping structure for table gom.swotconfig
CREATE TABLE IF NOT EXISTS `swotconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `centerline` float NOT NULL,
  `colorO` varchar(6) NOT NULL,
  `colorS` varchar(6) NOT NULL,
  `colorT` varchar(6) NOT NULL,
  `colorW` varchar(6) NOT NULL,
  `continuousChange` float DEFAULT NULL,
  `continuousDistanceGtOne` float DEFAULT NULL,
  `continuousDistanceLtOne` float DEFAULT NULL,
  `continuousSameSide` float DEFAULT NULL,
  `continuousStaggered` float DEFAULT NULL,
  `datum` int(10) DEFAULT NULL,
  `datumO` float DEFAULT NULL,
  `datumS` float DEFAULT NULL,
  `datumT` float DEFAULT NULL,
  `datumW` float DEFAULT NULL,
  `distanceCenter` float DEFAULT NULL,
  `distanceGtOne` float DEFAULT NULL,
  `distanceGtTwo` float DEFAULT NULL,
  `improveTarget` float DEFAULT NULL,
  `isContinuousChange` bit(1) DEFAULT NULL,
  `isContinuousDistanceGtOne` bit(1) DEFAULT NULL,
  `isContinuousDistanceLtOne` bit(1) DEFAULT NULL,
  `isContinuousSameSide` bit(1) DEFAULT NULL,
  `isContinuousStaggered` bit(1) DEFAULT NULL,
  `isDistanceCenter` bit(1) DEFAULT NULL,
  `isDistanceGtOne` bit(1) DEFAULT NULL,
  `isDistanceGtTwo` bit(1) DEFAULT NULL,
  `method` tinyint(4) unsigned DEFAULT NULL,
  `model` tinyint(4) unsigned DEFAULT NULL,
  `tolerance` float DEFAULT NULL,
  `swot_config_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9B39040B850ACE17` (`swot_config_fk`),
  CONSTRAINT `FK9B39040B850ACE17` FOREIGN KEY (`swot_config_fk`) REFERENCES `swot` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.swotconfig: ~4 rows (approximately)
/*!40000 ALTER TABLE `swotconfig` DISABLE KEYS */;
INSERT INTO `swotconfig` (`id`, `centerline`, `colorO`, `colorS`, `colorT`, `colorW`, `continuousChange`, `continuousDistanceGtOne`, `continuousDistanceLtOne`, `continuousSameSide`, `continuousStaggered`, `datum`, `datumO`, `datumS`, `datumT`, `datumW`, `distanceCenter`, `distanceGtOne`, `distanceGtTwo`, `improveTarget`, `isContinuousChange`, `isContinuousDistanceGtOne`, `isContinuousDistanceLtOne`, `isContinuousSameSide`, `isContinuousStaggered`, `isDistanceCenter`, `isDistanceGtOne`, `isDistanceGtTwo`, `method`, `model`, `tolerance`, `swot_config_fk`) VALUES
	(1, 60, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 5, 55, 70, 35, 20, NULL, NULL, NULL, NULL, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, NULL),
	(2, 140, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 35, 25, 50, 1, NULL, NULL, NULL, NULL, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 1, NULL, NULL),
	(3, 140, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 180, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 3, NULL, NULL),
	(4, 150, 'yellow', 'green', 'blue', 'red', 120, 120, 130, 130, 135, 4, NULL, NULL, NULL, NULL, 140, 140, 150, NULL, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 2, NULL, NULL);
/*!40000 ALTER TABLE `swotconfig` ENABLE KEYS */;


-- Dumping structure for table gom.task
CREATE TABLE IF NOT EXISTS `task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actualEnd` datetime DEFAULT NULL,
  `actualHours` float DEFAULT NULL,
  `actualStart` datetime DEFAULT NULL,
  `assignor` varchar(15) DEFAULT NULL,
  `completedRate` varchar(10) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `des` varchar(500) DEFAULT NULL,
  `executor` varchar(15) DEFAULT NULL,
  `expectedEnd` datetime DEFAULT NULL,
  `expectedHours` float DEFAULT NULL,
  `expectedStart` datetime DEFAULT NULL,
  `occupyRate` varchar(10) DEFAULT NULL,
  `state` tinyint(4) unsigned DEFAULT NULL,
  `taskTitle` varchar(35) NOT NULL,
  `taskType` tinyint(4) unsigned DEFAULT NULL,
  `task_fixed_fk` int(10) unsigned DEFAULT NULL,
  `task_project_fk` int(10) unsigned DEFAULT NULL,
  `task_respon_fk` int(10) unsigned DEFAULT NULL,
  `needHelp` bit(1) DEFAULT NULL,
  `needState` int(11) DEFAULT NULL,
  `delay` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK27A9A5935E11C` (`task_project_fk`),
  KEY `FK27A9A58B77D80B` (`task_respon_fk`),
  KEY `FK27A9A55936A5E1` (`task_fixed_fk`),
  CONSTRAINT `FK27A9A55936A5E1` FOREIGN KEY (`task_fixed_fk`) REFERENCES `fixedtask` (`id`),
  CONSTRAINT `FK27A9A58B77D80B` FOREIGN KEY (`task_respon_fk`) REFERENCES `responsibility` (`id`),
  CONSTRAINT `FK27A9A5935E11C` FOREIGN KEY (`task_project_fk`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.task: ~0 rows (approximately)
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;


-- Dumping structure for table gom.trace
CREATE TABLE IF NOT EXISTS `trace` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actor` varchar(15) DEFAULT NULL,
  `arrow` varchar(25) DEFAULT NULL,
  `attachment` varchar(36) DEFAULT NULL,
  `deliverTime` datetime DEFAULT NULL,
  `icon` varchar(20) NOT NULL,
  `opinion` varchar(500) DEFAULT NULL,
  `processId` int(10) NOT NULL,
  `state` tinyint(4) unsigned DEFAULT NULL,
  `process_trace_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4D501253C486DEA` (`process_trace_fk`),
  CONSTRAINT `FK4D501253C486DEA` FOREIGN KEY (`process_trace_fk`) REFERENCES `process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.trace: ~0 rows (approximately)
/*!40000 ALTER TABLE `trace` DISABLE KEYS */;
/*!40000 ALTER TABLE `trace` ENABLE KEYS */;


-- Dumping structure for table gom.training
CREATE TABLE IF NOT EXISTS `training` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `endDate` date NOT NULL,
  `fee` double NOT NULL,
  `lecturer` varchar(12) NOT NULL,
  `otherFee` double NOT NULL,
  `qualification` varchar(100) NOT NULL,
  `startDate` date NOT NULL,
  `tcontent` varchar(500) NOT NULL,
  `tprogram` varchar(30) NOT NULL,
  `trainingTime` float NOT NULL,
  `trainingType` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.training: ~0 rows (approximately)
/*!40000 ALTER TABLE `training` DISABLE KEYS */;
/*!40000 ALTER TABLE `training` ENABLE KEYS */;


-- Dumping structure for table gom.ugroup
CREATE TABLE IF NOT EXISTS `ugroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) NOT NULL,
  `ename` varchar(15) NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.ugroup: ~10 rows (approximately)
/*!40000 ALTER TABLE `ugroup` DISABLE KEYS */;
INSERT INTO `ugroup` (`id`, `cname`, `ename`, `type`) VALUES
	(1, '普通用户', 'User', 0),
	(2, '管理员', 'Admin', 0),
	(3, '人事部', 'Personnel', 1),
	(4, '财务部', 'Financial', 1),
	(5, 'IT部', 'Technology', 1),
	(6, '助理', 'Assistant', 2),
	(7, '主管', 'Director', 2),
	(8, '经理', 'Manager', 2),
	(9, '员工', 'Employee', 2),
	(10, '董事长', 'CEO', 2);
/*!40000 ALTER TABLE `ugroup` ENABLE KEYS */;


-- Dumping structure for table gom.usergroup
CREATE TABLE IF NOT EXISTS `usergroup` (
  `uid` int(10) unsigned NOT NULL,
  `gid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uid`,`gid`),
  KEY `FK12E9C174B3D6F19E` (`uid`),
  KEY `FK12E9C174C60C751E` (`gid`),
  CONSTRAINT `FK12E9C174B3D6F19E` FOREIGN KEY (`uid`) REFERENCES `guser` (`id`),
  CONSTRAINT `FK12E9C174C60C751E` FOREIGN KEY (`gid`) REFERENCES `ugroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.usergroup: ~3 rows (approximately)
/*!40000 ALTER TABLE `usergroup` DISABLE KEYS */;
INSERT INTO `usergroup` (`uid`, `gid`) VALUES
	(1, 2),
	(1, 5),
	(1, 9);
/*!40000 ALTER TABLE `usergroup` ENABLE KEYS */;


-- Dumping structure for table gom.userresp
CREATE TABLE IF NOT EXISTS `userresp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `expected` int(10) NOT NULL,
  `node` varchar(10) NOT NULL,
  `resp_user_fk` int(10) unsigned DEFAULT NULL,
  `user_resp_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF3F7425B3A92013A` (`resp_user_fk`),
  KEY `FKF3F7425B502D886E` (`user_resp_fk`),
  CONSTRAINT `FKF3F7425B3A92013A` FOREIGN KEY (`resp_user_fk`) REFERENCES `responsibility` (`id`),
  CONSTRAINT `FKF3F7425B502D886E` FOREIGN KEY (`user_resp_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.userresp: ~0 rows (approximately)
/*!40000 ALTER TABLE `userresp` DISABLE KEYS */;
/*!40000 ALTER TABLE `userresp` ENABLE KEYS */;


-- Dumping structure for table gom.usertree
CREATE TABLE IF NOT EXISTS `usertree` (
  `uid` int(10) unsigned NOT NULL,
  `zid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uid`,`zid`),
  KEY `user_ztree_FK` (`uid`),
  KEY `ztree_user_FK` (`zid`),
  CONSTRAINT `ztree_user_FK` FOREIGN KEY (`zid`) REFERENCES `ztree` (`id`),
  CONSTRAINT `user_ztree_FK` FOREIGN KEY (`uid`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.usertree: ~39 rows (approximately)
/*!40000 ALTER TABLE `usertree` DISABLE KEYS */;
INSERT INTO `usertree` (`uid`, `zid`) VALUES
	(1, 27),
	(1, 28),
	(1, 29),
	(1, 30),
	(1, 33),
	(1, 34),
	(1, 39),
	(1, 43),
	(1, 47),
	(1, 48),
	(1, 49),
	(1, 50),
	(1, 52),
	(1, 53),
	(1, 54),
	(1, 55),
	(1, 56),
	(1, 57);
	
/*!40000 ALTER TABLE `usertree` ENABLE KEYS */;


-- Dumping structure for table gom.ztree
CREATE TABLE IF NOT EXISTS `ztree` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ico` varchar(30) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `node` varchar(10) NOT NULL,
  `position` varchar(30) DEFAULT NULL,
  `role` varchar(30) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `parentid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Z_PARENTID` (`parentid`),
  CONSTRAINT `FK_Z_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `ztree` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.ztree: ~57 rows (approximately)
/*!40000 ALTER TABLE `ztree` DISABLE KEYS */;
INSERT INTO `ztree` (`id`, `ico`, `name`, `node`, `position`, `role`, `title`, `url`, `parentid`) VALUES
	(1, '', '审批中心', '1', 'Employee', 'manager', 'task center of user', '../app/index.htm', NULL),
	(2, '', '会议记录', '1.1', 'Employee', 'manager', 'Meeting Information', '../app/meeting.htm', 1),
	(3, '', '待批请假', '1.2', 'Employee', 'manager', 'the leave waitting for approve', '../app/leaves.htm', 1),
	(4, '', '待批申领', '1.3', 'Manager', 'manager', 'DaiPi explain get', '../app/handle_asset.html', 1),
	(5, '', '开设邮箱', '1.4', 'Employee', 'manager', '为新员工开设邮箱', '../app/entrant_mail.htm', 1),
	(6, '', '入职审核', '1.5', 'Employee', 'manager', '审核新入职员工资料', '../app/get_users.html', 1),
	(7, '', '离职审核', '1.6', 'Director', 'manager', 'Departure Audit', '../app/departures.htm', 1),
	(8, '', '工作管理', '2', 'Employee', 'user', 'WorkTask management', '../app/index.htm', NULL),
	(9, '', '我的任务', '2.1', 'Employee', 'user', 'My Task', '../app/user_task.html', 8),
	(10, '', '工作任务', '2.2', 'Manager', 'manager', 'Work Task', '../app/get_task.html', 8),
	(11, '', '工作命令', '2.3', 'Director', 'manager', 'Work Task Order', '../app/workorder.html', 8),
	(12, '', '追踪执行', '2.4', 'Employee', 'user', 'Execution Trace\r\n', '../app/approval_task.html', 8),
	(13, '', '固定工作', '2.5', 'Employee', 'manager', 'Fixed Task', '../app/fixed_task.htm', 8),
	(14, '', '需要帮忙', '2.6', 'Employee', 'manager', 'Need Help', '../app/get_help.htm', 8),
	(15, '', '培训管理', '3', 'Employee', 'user', 'Training management', '', NULL),
	(16, '', '人力培训', '3.1', 'Manager', 'manager', 'Human training', '../app/get_training.html', 15),
	(17, '', '心得收获', '3.2', 'Employee', 'user', 'Experience harvest', '../app/get_experiences.htm', 15),
	(18, '', '如何做', '3.3', 'Employee', 'user', 'How to do', '../app/howtodo.html', 15),
	(19, '', '项目管理', '4', 'Manager', 'parent', 'System management', '', NULL),
	(20, '', '项目', '4.1', 'Manager', 'manager', 'Project management', '../app/get_projects.html', 19),
	(21, '', '产品', '4.2', 'Manager', 'manager', 'Product management', '../app/get_products.html', 19),
	(22, '', '资产管理', '5', 'Manager', 'manager', 'Asset Management', '', NULL),
	(23, '', '物资申请', '5.1', 'Employee', 'user', 'Material apply for', '../app/apply_assets.html', 22),
	(24, '', '申领回执', '5.2', 'Employee', 'user', 'For receipt', '../app/receipt_asset.html', 22),
	(25, '', '资产清单', '5.3', 'Manager', 'manager', 'Assets list', '../app/get_assets.htm', 22),
	(26, '', '领用记录', '5.4', 'Manager', 'manager', 'Use record', '../app/get_borrows.html', 22),
	(27, '', '文件管理', '6', 'Employee', 'manager', 'File management', '', NULL),
	(28, '', '文件', '6.1', 'Employee', 'manager', 'File management', '../app/resource.htm', 27),
	(29, '', '分组', '6.2', 'Employee', 'manager', 'Category management', '../admin/category.html', 27),
	(30, '', '责任管理', '7', 'Employee', 'user', 'Responsibility management', '', NULL),
	(31, '', '主管分配', '7.1', 'Director', 'manager', 'Responsibility management', '../app/mgr_responsibility.html', 30),
	(32, '', '我的责任', '7.2', 'Employee', 'user', 'User Responsibility', '../app/get_responsibility.html', 30),
	(33, '', '责任配置', '7.3', 'Manager', 'manager', 'Responsibility Config', '../app/respon_config.htm', 30),
	(34, '', '私人秘书', '8', 'Employee', 'user', 'personal secretary', '', NULL),
	(35, '', '请假', '8.1', 'Employee', 'user', 'user leave', '', 34),
	(36, '', '申请', '8.1.1', 'Employee', 'user', 'user for leave', '../app/leave.htm', 35),
	(37, '', '回执', '8.1.2', 'Employee', 'user', 'receipt for leave', '../app/get_leave.htm', 35),
	(38, '', '记录', '8.1.3', 'Employee', 'manager', 'receipt for leave', '../app/get_leave_record.html', 35),
	(39, '', '个人资料', '8.2', 'Employee', 'user', 'update user information', '', 34),
	(40, '', '基本信息', '8.2.1', 'Employee', 'user', 'user basic information', '../app/edit_user.htm', 39),
	(41, '', '教育经历', '8.2.2', 'Employee', 'user', 'Education for user', '../app/education.html', 39),
	(42, '', '地址列表', '8.2.3', 'Employee', 'user', 'list of address for user', '../app/address.html', 39),
	(43, '', '修改密码', '8.2.4', 'Employee', 'user', 'update user password', '../app/update_pwd.html', 39),
	(44, '', '离职', '9', 'Employee', 'user', 'Departure Application', '', NULL),
	(45, '', '申请', '9.1', 'Employee', 'user', 'Departure Application', '../app/apply_departure.htm', 44),
	(46, '', '回执', '9.2', 'Employee', 'user', 'Departure Receipt', '../app/get_departure.htm', 44),
	(47, '', '系统管理', '10', 'Manager', 'manager', 'manager the system user', '', NULL),
	(48, '', '左侧菜单', '10.1', 'Manager', 'parent', 'ZTree  Management', '', 47),
	(49, '', '全局配置', '10.1.1', 'Manager', 'manager', 'ZTree Management', '../admin/ztree.html', 48),
	(50, '', '通用配置', '10.1.2', 'Manager', 'manager', 'ZTree Basic  Management', '../admin/basic_tree.htm', 48),
	(51, '', '用户定制', '10.1.3', 'Manager', 'manager', 'ZTree User Management', '../admin/tree_config.html', 48),
    (52, '', '用户配置', '10.2', 'Manager', 'manager', 'Users Config management', '../app/user_config.htm', 47),
	(53, '', '系统参数', '10.3', 'Manager', 'manager', 'config the system parameter', '../admin/config.htm', 47),
	(54, '', '组管理', '10.4', 'Manager', 'manager', 'System of Group Manager', '../admin/group.htm', 47),
	(55, '', '用户清单', '10.5', 'Manager', 'manager', 'Basic information', '../admin/list_users.htm', 47),
	(56, '', '流程配置', '10.6', 'Manager', 'manager', 'Process', '../app/process.htm', 47),
	(57, '', 'SWOT配置', '10.7', 'Director', 'manager', 'Department Task', '../app/swotconfig.html', 47);

	
/*!40000 ALTER TABLE `ztree` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
