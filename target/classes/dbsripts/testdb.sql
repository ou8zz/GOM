-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-04-11 16:41:27
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for gom
CREATE DATABASE IF NOT EXISTS `gom` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `gom`;


-- Dumping structure for table gom.abnormal
CREATE TABLE IF NOT EXISTS `abnormal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `des` varchar(500) DEFAULT NULL,
  `indirect` varchar(50) DEFAULT NULL,
  `reporter` varchar(50) DEFAULT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  `user_abnormal_fk` int(10) unsigned DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6255D06853B55EF6` (`user_abnormal_fk`),
  CONSTRAINT `FK6255D06853B55EF6` FOREIGN KEY (`user_abnormal_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.abnormal: ~25 rows (approximately)
/*!40000 ALTER TABLE `abnormal` DISABLE KEYS */;
INSERT INTO `abnormal` (`id`, `des`, `indirect`, `reporter`, `type`, `user_abnormal_fk`, `state`) VALUES
	(5, '好的，呀', NULL, 'sherry', 0, 3, 5),
	(11, '11111', NULL, 'sherry', 0, 4, 5),
	(12, '22222', NULL, 'sherry', 0, 4, 5),
	(25, '异常了！', NULL, 'sherry', 0, 4, 5),
	(26, '顶戴', NULL, 'sherry', 1, 5, 5),
	(27, '我有异常', NULL, 'sherry', 0, 1, 5),
	(28, 'aa', NULL, 'james', 0, 2, 5),
	(29, '111', NULL, 'sherry', 0, 3, 5),
	(30, '', NULL, 'sherry', 0, 5, 5),
	(31, '11', NULL, 'sherry', 0, 4, 5),
	(32, '11', NULL, 'wendy', 0, 2, 5),
	(33, '111', NULL, 'sherry', 0, 4, 5),
	(34, '', NULL, 'sqe_ole', 0, 2, 5),
	(35, '有问题了？', NULL, 'sherry', 0, 4, 5),
	(36, '昨天下午断电了！', NULL, 'sherry', 1, 4, 5),
	(37, '1111111111111111111111111111', NULL, 'sherry', 2, 5, 5),
	(38, '要', NULL, 'sherry', 0, 5, 5),
	(39, '顶替', NULL, 'sherry', 0, 5, 5),
	(40, '', NULL, 'sherry', 0, 5, 5),
	(41, '', NULL, NULL, 0, 5, 5),
	(42, '出问题了\r\n', NULL, 'james', 0, 5, 5),
	(43, '星期四异常！', NULL, 'sherry', 0, 4, 5),
	(44, 'sherry载波异常1', NULL, 'sqe_ole', 0, 2, 3),
	(45, '大家好，我不好！', NULL, 'sherry', 1, 4, 3),
	(46, '', NULL, NULL, 0, 3, 3);
/*!40000 ALTER TABLE `abnormal` ENABLE KEYS */;


-- Dumping structure for table gom.address
CREATE TABLE IF NOT EXISTS `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addrType` tinyint(4) unsigned DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `cell` varchar(17) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `relation` varchar(10) NOT NULL,
  `zipcode` varchar(6) DEFAULT NULL,
  `user_address_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1ED033D45358BB32` (`user_address_fk`),
  CONSTRAINT `FK1ED033D45358BB32` FOREIGN KEY (`user_address_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.address: ~8 rows (approximately)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`id`, `addrType`, `address`, `cell`, `contact`, `phone`, `relation`, `zipcode`, `user_address_fk`) VALUES
	(1, 0, '上海浦东芳华路', '(86)138-1760-1860', '曾小贤', '86(21)1760-186', '朋友', '465552', 2),
	(2, 0, '上海浦东芳华路', '(86)138-1760-1860', '吕子乔', '86(21)1760-1860', '朋友', '123132', 3),
	(3, 0, '上海浦东芳华路', '(86)138-1741-3430', '吕子乔', '86(733)1750-1222', '朋友1', '231313', 4),
	(4, 0, '上海浦东芳华路', '(86)138-1760-1860', '胡一菲', '86(21)1760-1860', '朋友', '121243', 5),
	(5, 0, '上海浦东芳华路', '(86)138-1760-1860', '胡一菲', '86(21)1760-1860', '朋友', '232323', 6),
	(18, 0, '牡丹路89弄18号602室', '(86)138-1760-1860', '紫色', '86(21)1760-1860', '朋友', '212102', 5),
	(21, 0, '牡丹路89弄18号602室', '(86)138-1760-1860', '光一', '86(21)1760-1860', '朋友', '343434', 4),
	(22, 0, '上海清东', '(86)138-1760-1860', '黄晓明', '86(21)1760-2231', '同学', '412222', 17);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.asset: ~7 rows (approximately)
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
INSERT INTO `asset` (`id`, `admin`, `ascription`, `assetName`, `assetState`, `assetType`, `attachment`, `buyDate`, `buyNum`, `buyer`, `controlDate`, `des`, `scrapDate`, `unit`, `warrantyDate`) VALUES
	(1, 'james', 'IT部', 'HP笔记本电脑', 0, 0, '', '2010-09-03', 1, 'james', '2012-09-27', 'HP笔记本电脑可以使用1', '2012-09-27', '個', '2012-09-30'),
	(2, 'james', '人事部', '打印机', 0, 2, '', '2012-09-01', 1, 'james', '2012-09-08', '所有打印机', '2012-09-20', '個', '2012-09-21'),
	(3, 'james', '人事部', '文件夹', 0, 2, '', '2012-09-01', 12, 'james', '2012-09-22', '办公用文件夹11', '2012-09-27', '件', '2012-09-21'),
	(4, 'james', 'IT部', '显示器', 0, 0, '', '2012-09-01', 1, 'sqe_ole', '2012-09-22', '新购入三台AOC显示器', '2012-09-13', '個', '2012-09-30'),
	(5, 'james', '人事部', '垃圾袋', 2, 2, '', '2013-01-08', 1, 'james', '2013-01-08', '日常使用', '2013-01-31', '件', '2013-01-31'),
	(6, 'admin', '人事部', '小柜子', 0, 0, '', '2013-04-01', 2, 'sherry', '2013-04-01', '小柜子', '2013-04-01', '个', '2013-04-01'),
	(7, 'admin', '人事部', '大桌子', 1, 0, '', '2013-04-06', 1, 'wendy', '2013-04-28', '大桌子1', '2013-04-26', '个', '2013-04-19');
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;


-- Dumping structure for procedure gom.attendance
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `attendance`(userId INT)
BEGIN
DECLARE jobNo VARCHAR(20);
DECLARE ename VARCHAR(15);

TRUNCATE TABLE attendance_tb;		

SELECT u.jobNo, u.ename INTO jobNo, ename FROM guser AS u WHERE u.id=userId;

select insert_attendance(userId, 0, 0, jobNo, ename);
select insert_attendance(userId, 1, 7, jobNo, ename);
select insert_attendance(userId, 2, 30, jobNo, ename);
select insert_attendance(userId, 4, 365, jobNo, ename);

END//
DELIMITER ;


-- Dumping structure for table gom.attendance_tb
CREATE TABLE IF NOT EXISTS `attendance_tb` (
  `jobNo` varchar(30) DEFAULT NULL,
  `ename` varchar(15) DEFAULT NULL,
  `range` tinyint(4) DEFAULT NULL,
  `day` float DEFAULT '0',
  `hours` float DEFAULT '0',
  `leave` int(11) DEFAULT '0',
  `late` int(11) DEFAULT '0',
  `compensatory` int(11) DEFAULT '0',
  `des` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.attendance_tb: ~0 rows (approximately)
/*!40000 ALTER TABLE `attendance_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance_tb` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.borrow: ~12 rows (approximately)
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
INSERT INTO `borrow` (`id`, `applyState`, `funCode`, `overStaff`, `receiveDate`, `receiveNum`, `receiver`, `remark`, `returnDate`, `asset_borrow_fk`) VALUES
	(1, 3, 'F1_3', 'james', '2012-09-27', 1, 'james', '领用AOC显示器一台，我的显示器坏了！', '2012-09-23', 4),
	(2, 1, 'F1_5', 'sherry', '2012-10-12', 1, 'james', '领用公司打印机一台', '2012-10-12', 2),
	(3, 3, 'F-01', 'sherry', '2013-01-03', 1, 'sqe_ole', '用用就好！！！', '2013-01-31', 4),
	(4, 1, 'F-02', 'sherry', '2013-01-04', 1, 'wendy', '可以', '2013-01-05', 2),
	(5, 0, 'f01', '', '2013-03-27', 1, 'sqe_ole', '213', '2013-03-27', 6),
	(6, 0, 'f02', '', '2013-03-27', 2, 'james', '12', '2013-03-27', 3),
	(8, 0, 'FunCode', '', '2013-03-28', 2, 'sqe_ole', 'sdfasfd', '2013-03-28', 3),
	(9, 0, 'FunCode', '', '2013-03-14', 1, 'sqe_ole', '121', '2013-03-30', 3),
	(10, 0, 'FunCode', '', '2013-03-13', 1, 'sqe_ole', 'dsf', '2013-03-16', 3),
	(11, 0, 'FunCode', '', '2013-03-20', 1, 'sqe_ole', '1', '2013-03-23', 3),
	(12, 0, 'FunCode', '', '2013-03-23', 1, 'sqe_ole', 'sdf', '2013-03-23', 3),
	(13, 0, 'FunCode', '', '2013-03-02', 1, 'sqe_ole', '1', '2013-03-15', 3);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.category: ~8 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `name`, `node`, `parentid`) VALUES
	(1, '人事部资料', '1', NULL),
	(2, 'IT部资料', '2', NULL),
	(3, '财务部资料', '3', NULL),
	(4, '财务账单', '3.1', 3),
	(5, 'GOM开发规范', '2.1', 2),
	(6, '开发文档', '2.2', 2),
	(7, '新进员工', '1.1', 1),
	(8, 'IT人员名单', '2.3', 2);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Dumping structure for table gom.config
CREATE TABLE IF NOT EXISTS `config` (
  `_key` varchar(45) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.config: ~30 rows (approximately)
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` (`_key`, `name`, `value`) VALUES
	('basis', '基础参数', NULL),
	('basis.adminIT', 'IT管理员', 'admin'),
	('basis.company.cn', '公司中文名称', '上海实名信息科技有限公司'),
	('basis.company.en', '公司英文名称', 'SQE SERVICE'),
	('basis.fax', '公司传真', '+8621-50499037'),
	('basis.jobNo.prefix', '工号前缀', 'SQE'),
	('basis.login.out', '登出时间', '17:30'),
	('basis.login.time', '上班时间', '8:30'),
	('basis.logs.path', '日志路径', '/usr/local/tomcat6/logs/'),
	('basis.mail.host', '邮件服务主机', 'smtp.126.com'),
	('basis.mail.pwd', '系统邮件账号密码', 'sqe321'),
	('basis.mail.user', '系统邮件账号', 'gom_admin@126.com'),
	('basis.tel', '公司电话', '+8621-50499035'),
	('basis.version', '系统版本', '3.0'),
	('basis.web', '公司网站', 'http://www.sqeservice.com'),
	('departure', '离职流程节点参数', NULL),
	('departure.fieldwork.days', '实习生离职提前天数', '7'),
	('departure.financial', '离职财务核算专员', 'test2'),
	('departure.HR', '离职审核人事专员', 'sherry'),
	('departure.qualified.days', '正式员工离职申请提前天数', '30'),
	('departure.training.days', '试用期员工离职提前天数', '15'),
	('entrant', '入职流程节点参数', NULL),
	('entrant.HR', '入职资料审核人事专员', 'admin'),
	('fileUpload', '文件上传参数组', NULL),
	('fileUpload.rootPath', '上传根目录', 'E:/workspace/gom/src/main/webapp/uploads/'),
	('fileUpload.typesAllows', '允许上传文件类型', 'jpg,gif,png,pdf,doc,docx,xls,xlsx,swf,flv'),
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.departure: ~3 rows (approximately)
/*!40000 ALTER TABLE `departure` DISABLE KEYS */;
INSERT INTO `departure` (`id`, `handover`, `reason`, `recipient`, `recipientDpt`, `recipientJobNo`, `recipientPst`, `salaryDate`, `state`, `toMailAddr`, `user_departure_fk`) VALUES
	(1, '111', '合同到期，回家去了！', 'sqe_ole', 'IT部', 'SQE12001', '员工', '2012-09-28', 3, 'sqe_wendy@sqeservice.com;sqe_james@sqeservice.com;sqe_ole@sqeservice.com;sqe_wendy@sqeservice.com', 2),
	(2, '可以  同意', '回家过年', 'sherry', '人事部', 'SQE12002', '助理', '2013-01-07', 3, 'sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com', 5),
	(7, 'dfsfd', 'sad', 'sherry', '人事部', 'SQE12002', '助理', '2013-03-22', 5, 'sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;gom-admin@sqeservice.com', 4);
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.education: ~11 rows (approximately)
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` (`id`, `ed`, `endDate`, `idScan`, `idno`, `major`, `school`, `startDate`, `user_education_fk`) VALUES
	(1, '本科', '2010-09-04', '', '430265', '计算机', '上海交通大学', '2010-09-03', 3),
	(2, '大专', '2011-10-15', '', '432652', '开车', '新东方学校', '2007-08-17', 4),
	(3, '本科', '2012-09-01', '', '430265', '计算机', '上海交通大学', '2007-09-01', 3),
	(4, '本科', '1997-11-19', '4576f5c0bc5e4bedbb6b194c9bb8fc52.jpg', '430265', '计算机', '上海交通大学', '1997-09-09', 4),
	(5, '大专', '2010-09-04', '', '432652', '会计', '新东方学校', '2010-09-03', 5),
	(6, '大专', '2012-09-01', '', '432652', '计算机', '新东方学校', '2010-09-03', 6),
	(19, '本科', '2013-03-16', 'ab2938b5f6dc4bbe82301f18175ffef9.jpg', '432652', '计算机', '湖南城市学院', '2013-03-10', 5),
	(20, '大专', '2012-09-01', '', '432652', '计算机', '新东方学校', '2010-09-03', 6),
	(21, '本科', '2013-03-16', 'ab2938b5f6dc4bbe82301f18175ffef9.jpg', '432652', '计算机', '湖南城市学院', '2013-03-10', 5),
	(22, '中学', '2003-05-17', '', '430668', '中学', '阳光晨学院', '2000-03-01', 4),
	(23, '大专', '2013-05-25', '', '232333', '计算机', '上海成人学院', '2013-03-01', 11);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.experience: ~17 rows (approximately)
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience` (`id`, `createDate`, `gain`, `student`, `resource_how_fk`, `training_experience_fk`) VALUES
	(1, '2012-09-27', '对于软件开发的规范这个课程，我从中了解到很多的开发知识，知道如何在一个开发道路上成功的走下去。。。', 'james', NULL, 1),
	(2, '2012-09-27', '1、检查一下打印机与电脑是不是已连接上（一次连接上后，以后就不需要看有没有连接了）。\n2、连接上后，开机、放纸；\n3、打印所需要打印的东西；\n4、OK！', 'james', 4, NULL),
	(3, '2012-12-31', '1.转账需要携带兴业银行凭证，凭证上面需要盖章（公司章与法人章，盖章需清晰否则无法扫描），凭证上需要写清楚转账的金额与用途，携带回单提取卡。\n2.兴业银行地址：东方路710号  电话：58303977  周一～周五  上午9:00-12:00，下午13:00-16:30  \n3.将转账凭证交给柜台工作人员。之后工作人员会返给一张小票。\n4.将回单提取卡靠在银行回单提取的机器的感应部位。\n5.抽屉中会出现相关的单据，拿回单据，推还抽屉，方可离开。\n6.兴业银行有客户经理电话：\n7.银行余额对账单、贷记凭证、空白凭证领用单需盖公司财务章、法人章\n8.领取空白凭证领用单时多领，以防盖错或不清晰', 'sherry', 6, NULL),
	(4, '2012-12-31', '1.转账需要携带兴业银行凭证，凭证上面需要盖章（公司章与法人章，盖章需清晰否则无法扫描），凭证上需要写清楚转账的金额与用途，携带回单提取卡。\n2.兴业银行地址：东方路710号  电话：58303977  周一～周五  上午9:00-12:00，下午13:00-16:30  \n3.将转账凭证交给柜台工作人员。之后工作人员会返给一张小票。\n4.将回单提取卡靠在银行回单提取的机器的感应部位。\n5.抽屉中会出现相关的单据，拿回单据，推还抽屉，方可离开。\n6.兴业银行有客户经理电话：\n7.银行余额对账单、贷记凭证、空白凭证领用单需盖公司财务章、法人章\n8.领取空白凭证领用单时多领，以防盖错或不清晰', 'wendy', 6, NULL),
	(5, '2013-01-04', '我在这次培训中感到 非常......', 'wendy', NULL, 1),
	(6, '2013-01-04', '我的心得', 'wendy', NULL, 2),
	(7, '2013-01-04', '收到中药后清点数量、询问Roger成品中药的数量。\n2.	用信封将计算出来的总金额装好并密封，把信封放在中药袋里面，封口。\n3.	电话联系：021-58404191，询问工作人员收药到煎药的流程，估算时间。\n4.	邮件/电话询问Roger并告知相关情况取决一种合适的方式。\na、	亲自送过去，对方当天可以收件。\nb、	如果时间允许邮寄过去。\n5.	地址：上海市浦东新区乳山路79号 收件人：养和堂乳山路店 联系方式：021-58404191\n6.	多煮包，多付费，多煮分数问Roger\n7.	询问中药什么时候煮什么时候煮好，寄回后告知Roger 此事', 'wendy', 7, NULL),
	(8, '2013-01-05', 'sfd', 'sqe_ole', 6, NULL),
	(9, '2013-01-05', '', 'sqe_ole', 6, NULL),
	(10, '2013-02-21', 'dsf添加新的。。。。。。。。OH NO<br />', 'sqe_ole', 6, NULL),
	(11, '2013-02-21', 's', 'sqe_ole', 6, NULL),
	(12, '2013-03-14', 'dfsadsaf', 'sqe_ole', NULL, 1),
	(13, '2013-03-14', 'dfsadsaf', 'sqe_ole', NULL, 1),
	(16, '2013-03-23', '<strong>我做了一些关于PPT的东西。<br />\n</strong>', 'sqe_ole', 11, NULL),
	(17, '2013-03-23', '我还做了很多。', 'sqe_ole', 12, NULL),
	(18, '2013-03-23', '式', 'sqe_ole', 6, NULL),
	(19, '2013-03-29', 'fgtfgf<br />', 'sqe_ole', 6, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.fixedtask: ~6 rows (approximately)
/*!40000 ALTER TABLE `fixedtask` DISABLE KEYS */;
INSERT INTO `fixedtask` (`id`, `createDate`, `des`, `expectedEnd`, `expectedStart`, `frequency`, `hours`, `period`, `state`, `taskTitle`, `updateDate`) VALUES
	(1, '2012-09-27 16:48:52', '编写工作文档，每天的工作内容和工作安排！', '04:00:00', '03:00:00', 0, 1, NULL, 4, '编写工作文档', '2013-01-23 11:31:46'),
	(2, '2012-09-28 16:31:00', '打扫办公室和大厅', '05:30:00', '05:00:00', 0, 1, NULL, 3, '打扫办公室', '2013-03-14 10:33:13'),
	(3, '2012-12-31 17:01:32', '整理黄老师每月工作时间计算费用', '16:00:00', '14:00:00', 2, 2, 1, 3, '应收应付款', NULL),
	(4, '2013-01-04 15:50:48', '整理应收应付款', '16:00:00', '14:00:00', 2, 2, 21, 4, '应收应付款', '2013-01-23 11:18:26'),
	(5, '2013-01-23 11:32:31', '编写工作文档，将项目功能和方法记录！', '11:00:00', '10:00:00', 0, 2, NULL, 3, '编写工作文档', '2013-03-14 10:26:33'),
	(6, '2013-02-23 12:56:17', '国际化国际化', '02:00:00', '11:00:00', 0, 2.5, NULL, 3, '国际化', '2013-02-23 12:56:39');
/*!40000 ALTER TABLE `fixedtask` ENABLE KEYS */;


-- Dumping structure for table gom.guser
CREATE TABLE IF NOT EXISTS `guser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(19) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `bank` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `cell` varchar(17) NOT NULL,
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
  `phone` varchar(16) DEFAULT NULL,
  `portrait` varchar(36) DEFAULT NULL,
  `privateMail` varchar(35) DEFAULT NULL,
  `pwd` varchar(32) NOT NULL,
  `telExt` varchar(5) DEFAULT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  `generic` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ename` (`ename`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.guser: ~14 rows (approximately)
/*!40000 ALTER TABLE `guser` DISABLE KEYS */;
INSERT INTO `guser` (`id`, `accountNo`, `active`, `bank`, `birthday`, `cell`, `censusType`, `cname`, `documents`, `email`, `emailPwd`, `ename`, `entryDate`, `exitDate`, `fullDate`, `gender`, `height`, `idScan`, `idcard`, `jobNo`, `locked`, `marriage`, `nation`, `phone`, `portrait`, `privateMail`, `pwd`, `telExt`, `type`, `generic`) VALUES
	(0, NULL, b'00000000', NULL, NULL, '(86)138-1745-1225', 1, '基础树占用ID', 0, 'gom-admin@sqeservice.com', 'service11', 'b', '2013-01-23', NULL, '2013-01-31', 0, '169', '', '430922198910135531', 'SQE00000', b'10000000', 0, '漢族', '021-50597791', '', 'gom-admin@sqeservice.com', '905dcb52b6585ac391ffcf8162cd6c92', '16', 0, b'00000000'),
	(1, '6227556322215698', b'10000000', '中国建设银行', '1987-10-01', '(86)138-1741-3430', 0, '管理员', 0, 'gom-admin@sqeservice.com', 'service11', 'admin', '2012-09-26', NULL, '2012-09-26', 0, '168', 'ddfa24dd456b436a9c3ae5cf8da7083a.jpg', '430922198910135531', 'SQE12001', b'00000000', 0, '汉族', '0737-21321321', '', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '17', 2, b'00000000'),
	(2, '6226555488855445', b'10000000', '中国建设银行', '1989-09-01', '(86)138-1741-3430', 1, '肖霞', 0, 'sqe_sherry@sqeservice.com', 'service11', 'sherry', '2012-09-26', NULL, '2012-09-26', 1, '163', '298f06ea5a184396bbbb9665dfde646b.jpg', '430902198710015513', 'SQE12002', b'00000000', 0, '汉族', '86(21)1760-1860', '26cc787823cc49b4ba6c7e409670aaf1.jpg', 'sherry@126.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', 2, b'10000000'),
	(3, '6226555488855445', b'10000000', '中国建设银行', '1985-09-04', '(86)138-1741-3430', 1, '张伟', 0, 'sqe_james@sqeservice.com', 'junwei', 'james', '2012-09-27', NULL, '2012-09-27', 0, '190', '386da0087bbc4760beafa487bfbabbbe.jpg', '430922198910135531', 'SQE12003', b'00000000', 1, '汉族', '86(21)1760-1860', '', 'james@sqeservice.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', 2, b'10000000'),
	(4, '6226555488855445', b'10000000', '中国建设银行', '1994-09-01', '(86)138-1741-3430', 1, '欧阳智成', 1, 'sqegom2@126.com', 'service2', 'sqe_ole', '2013-01-23', '2013-04-19', '2013-01-24', 0, '163', 'ab2938b5f6dc4bbe82301f18175ffef9.jpg', '430922198910135531', 'SQE12004', b'00000000', 1, '汉族', '86(733)1750-1222', '949d804ae8e0456e8bbeb702fc054f69.jpg', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '15', 2, b'10000000'),
	(5, '6226555488855445', b'10000000', '中国建设银行', '1988-09-02', '(86)138-1741-3430', 1, '陶文秀', 0, 'sqe_wendy@sqeservice.com', 'service11', 'wendy', '2012-09-26', NULL, '2012-09-30', 1, '165', '9428c329e22046cf8c923322f8f2b538.jpg', '430922198910135531', 'SQE12005', b'00000000', 0, '汉族', '86(21)1760-1860', 'd3d192026d1344368bd0ef23209194a4.jpg', 'sqe_wendy@sqeservice.com', '905dcb52b6585ac391ffcf8162cd6c99', '17', 0, b'10000000'),
	(6, '6226555488855445', b'10000000', '中国建设银行', '1964-09-01', '(86)138-1741-3430', 1, '黄宗明', 0, 'sqegom2@126.com', 'service2', 'roger', '2013-01-23', NULL, '2013-01-24', 0, '187', 'eeb98e721acb4aeab81cf017f442be69.jpg', '430922198910135531', 'SQE12006', b'00000000', 0, '蒙古族', '021-50499065', '8bd7e0e3a5e6419eb22b889f132d5197.jpg', 'roger_cn@126.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', 2, b'00000000'),
	(7, '62267722656522211', b'10000000', '中国建设银行', '1995-01-04', '(86)138-1741-3430', 1, '黄江林', 0, 'sqegom1@126.com', 'service1', 'jason', '2013-01-23', NULL, '2013-01-31', 0, '169', '', '430922198910135531', 'SQE13007', b'00000000', 0, '漢族', '86(21)1760-1860', '', 'sqe_jason@126.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', 0, b'10000000'),
	(11, '4223322266555555', b'00000000', '建设银行', '1995-03-01', '(86)135-1365-3255', 0, '光城', 0, NULL, NULL, 'ssah', NULL, NULL, NULL, 0, '167', '', '430922198910135531', 'SQE13009', b'00000000', 0, '汉族', '86(21)2555-2112', '', 'sqe_ole@sqeservice.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', 0, NULL),
	(12, '46221122222254411', b'00000000', '中国银行', '1995-03-01', '(86)138-1760-1860', 0, '欧阳智成', 1, NULL, NULL, 'oole', NULL, NULL, NULL, 0, '168', '', '430922198910135531', 'SQE13010', b'00000000', 0, '汉族', '86(21)1760-1860', '949d804ae8e0456e8bbeb702fc054f69.jpg', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', 0, NULL),
	(13, '62256652223322333', b'00000000', '中国银行', '1995-03-14', '(86)138-1760-1123', 1, '张进国', 1, NULL, NULL, 'yyes', NULL, NULL, NULL, 0, '168', '', '430922198910135531', 'SQE13011', b'00000000', 0, '汉族', '86(21)1760-2231', '', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', NULL, NULL),
	(15, '65563232211212121', b'00000000', '中国银行', '1995-03-14', '(86)138-1760-1144', 0, '张数', 2, NULL, NULL, 'uuoe', NULL, NULL, NULL, 0, '168', '', '430922198910135531', 'SQE13012', b'00000000', 0, '汉族', '86(21)1760-2231', '', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', NULL, NULL),
	(17, '65411222212411111', b'00000000', '中国银行', '1995-03-14', '(86)138-1760-1121', 0, '肖夺', 1, NULL, NULL, 'eeqr', NULL, NULL, NULL, 0, '168', '', '430922198910135531', 'SQE13013', b'00000000', 1, '汉族', '86(21)1760-2231', '', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', NULL, NULL),
	(18, '34343432434343434', b'00000000', '中国银行', '1995-03-07', '(86)138-1760-1132', 1, '肖小妹', 1, NULL, NULL, 'eeqr2', NULL, NULL, NULL, 1, '168', '', '430922198910135531', 'SQE13014', b'00000000', 1, '汉族', '86(21)1760-2231', '', 'ou8zz@sina.com', '905dcb52b6585ac391ffcf8162cd6c99', '16', NULL, NULL);
/*!40000 ALTER TABLE `guser` ENABLE KEYS */;


-- Dumping structure for table gom.holidays
CREATE TABLE IF NOT EXISTS `holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `days` int(10) DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `name` varchar(15) NOT NULL,
  `startDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.holidays: ~3 rows (approximately)
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` (`id`, `days`, `endDate`, `name`, `startDate`) VALUES
	(1, 7, '2013-01-07', '春节', '2013-01-01'),
	(2, 3, '2013-05-07', '端午', '2013-05-05'),
	(3, 7, '2013-10-07', '国庆节', '2013-10-01');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;


-- Dumping structure for function gom.insert_attendance
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `insert_attendance`(userId INT, date_range INT, in_range INT, jobNo VARCHAR(20), ename VARCHAR(15)) RETURNS int(11)
BEGIN
DECLARE workday INT;
DECLARE workhours INT;
DECLARE leaveday INT;
DECLARE late INT;
DECLARE compensatory INT;
DECLARE tempDate DATE DEFAULT DATE_SUB(CURRENT_DATE, INTERVAL in_range DAY);

SELECT COUNT(*) INTO workday FROM login AS l WHERE l.user_id=userId AND DATE(l.loginTime)<=CURRENT_DATE AND DATE(l.loginTime)>=tempDate;
SELECT SUM(t.actualHours) INTO workhours FROM task AS t WHERE t.executor=ename AND t.state=5 AND DATE(t.actualEnd)<=CURRENT_DATE AND DATE(t.actualEnd)>=tempDate;
SELECT SUM(le.days) INTO leaveday FROM leaves AS le WHERE le.user_leave_id=userId AND DATE(le.applyDate)<=CURRENT_DATE AND DATE(le.applyDate)>=tempDate;
SELECT SUM(s.data) INTO late FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=5 AND s.user_summarys_fk=userId AND s.dated<=CURRENT_DATE AND s.dated>=tempDate;
SELECT SUM(s.data) INTO compensatory FROM summary s WHERE s.user_summarys_fk=userId AND s.dateMark=2 AND s.dated<=CURRENT_DATE AND s.dated>=tempDate;

INSERT INTO attendance_tb VALUES(jobNo, ename, date_range, workday, workhours, leaveday, late, compensatory, tempDate);
RETURN 1;
END//
DELIMITER ;


-- Dumping structure for function gom.insert_data
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `insert_data`(in_range INT, in_date DATE, in_item INT, quantity INT, userId INT) RETURNS int(11)
BEGIN
DECLARE res INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE holiday INT DEFAULT 0;
DECLARE datum INT DEFAULT (SELECT c.datum FROM swotconfig AS c WHERE c.item=in_item AND c.date_range=in_range) + quantity;
DECLARE dated DATE;

IF in_range = 0 THEN
WHILE i<datum DO


CASE DAYOFWEEK(DATE_SUB(in_date, INTERVAL i DAY))
WHEN 7 THEN SET datum = datum + 1;	SET i = i + 1;	
WHEN 1 THEN SET datum = datum + 2;	SET i = i + 2; 
ELSE SET datum = datum;
END CASE;


IF (SELECT COUNT(*) FROM lieu AS l WHERE l.user_lieu_fk=userId AND l.dayoff=DATE_SUB(in_date, INTERVAL i DAY)) > 0 THEN
SET datum = datum + 1;	SET i = i + 1;
END IF;


SELECT h.days INTO holiday FROM holidays AS h WHERE h.endDate=DATE_SUB(in_date, INTERVAL i DAY);
IF holiday > 0 THEN
SET datum = datum + holiday;	SET i = i + holiday;
SET holiday = 0;
END IF;

SET dated = DATE_SUB(in_date, INTERVAL i DAY);
SET res = sum_item(in_range, dated, i, userId, in_item);
INSERT INTO statistics VALUES(CASE WHEN res>0 THEN res ELSE 0 END, in_item, dated);
SET i = i + 1;
END WHILE; 

ELSE

WHILE 0<datum DO
SET datum = datum - 1;

CASE in_range
WHEN 1 THEN SET dated = DATE_SUB(in_date, INTERVAL datum WEEK);
WHEN 2 THEN SET dated = DATE_SUB(in_date, INTERVAL datum MONTH);
WHEN 3 THEN SET dated = DATE_SUB(in_date, INTERVAL datum QUARTER);
WHEN 4 THEN SET dated = DATE_SUB(in_date, INTERVAL datum YEAR);
ELSE SET dated = DATE_SUB(in_date, INTERVAL datum DAY);
END CASE;

SET res = sum_item(in_range, in_date, datum, userId, in_item);
INSERT INTO statistics VALUES(CASE WHEN res>0 THEN res ELSE 0 END, in_item, dated);
END WHILE;

END IF;
RETURN 1;
END//
DELIMITER ;


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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.leaves: ~11 rows (approximately)
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` (`id`, `agent`, `agentCname`, `agentDpt`, `agentJobNo`, `agentPst`, `applyDate`, `contact`, `days`, `endDate`, `event`, `handOver`, `recipient`, `relationAddr`, `startDate`, `state`, `type`, `user_leave_id`) VALUES
	(2, 'wendy', '小红', '人事部', 'SQE12005', '助理', '2012-09-27 14:30:01', '联系电话：021-50196553', 1, '2012-09-28 14:29:16', '我家里今天搬家！', '我的工作文档放在我的电脑D盘work文件夹里面！', 'james', 'sqe_sherry@sqeservice.com;sqe_wendy@sqeservice.com;sqe_james@sqeservice.com;sqe_wendy@sqeservice.com', '2012-09-27 14:29:15', 5, 0, 2),
	(3, 'sherry', '肖霞', '人事部', 'SQE12002', '助理', '2013-01-02 11:30:00', '13761940115', 1, '2013-01-03 14:00:06', '个人事务', '1、关电脑空调\r\n2、接听电话', 'sherry', 'sqe_wendy@sqeservice.com;sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com', '2013-01-02 14:00:06', 5, 0, 5),
	(4, 'wendy', '陶文秀', '人事部', 'SQE12005', '助理', '2013-01-04 13:44:05', '13761940115', 1, '2013-01-06 13:42:21', '感冒', '1、接听电话\r\n2、收快递', 'wendy', 'sqe_sherry@sqeservice.com;sqe_sherry@sqeservice.com;sqe_wendy@sqeservice.com', '2013-01-05 13:42:21', 5, 1, 2),
	(5, 'wendy', '陶文秀', '人事部', 'SQE12005', '助理', '2013-01-04 14:13:17', '13761940115', 1, '2013-01-06 14:13:15', '感冒', '1、接听电话\r\n2、收快递', 'wendy', 'sqe_sherry@sqeservice.com;sqe_wendy@sqeservice.com', '2013-01-05 14:13:15', 3, 1, 2),
	(6, 'sherry', '肖霞', '人事部', 'SQE12002', '助理', '2013-01-16 15:00:45', '13378311526', 2, '2013-01-19 14:58:01', '私事', '1.接听来电\r\n2.整理各项资料\r\n3.签收各快递', 'sherry', 'sqe_wendy@sqeservice.com', '2013-01-17 14:58:01', 3, 0, 5),
	(7, 'wendy', '陶文秀', '人事部', 'SQE12005', '员工', '2013-02-23 10:53:09', '18621577368', 3, '2013-02-25 10:52:43', '我要去帮忙', '没多少工作，测试而已', 'sherry', 'sqe_ole@sqeservice.com;sqe_wendy@sqeservice.com;sqe_sherry@sqeservice.com', '2013-02-23 10:52:41', 5, 0, 4),
	(8, 'james', '张伟', 'IT部', 'SQE12003', '主管', '2013-03-16 11:47:42', '333', 2, '2013-03-23 11:47:26', '333', '33333', 'james', 'sqegom1@126.com', '2013-03-16 11:47:24', 5, 0, 4),
	(9, 'james', '张伟', 'IT部', 'SQE12003', '主管', '2013-03-16 13:26:46', '1', 1, '2013-03-16 13:26:36', '1', '1', 'james', 'sqegom1@126.com', '2013-03-16 13:26:35', 5, 0, 4),
	(10, 'james', '张伟', 'IT部', 'SQE12003', '主管', '2013-03-16 13:29:02', '1', 1, '2013-03-16 13:28:52', '1', '1', 'james', 'sqegom1@126.com', '2013-03-16 13:28:51', 5, 0, 4),
	(11, 'sherry', '肖霞', '人事部', 'SQE12002', '助理', '2013-03-16 13:54:42', '1', 1, '2013-03-16 13:54:13', '1', '1', 'sherry', 'sqegom1@126.com', '2013-03-16 13:54:12', 5, 0, 4),
	(12, 'sherry', '肖霞', '人事部', 'SQE12002', '助理', '2013-03-16 13:56:14', '111', 1, '2013-03-16 13:55:54', '11', '11', 'sherry', 'sqegom1@126.com', '2013-03-16 13:55:52', 5, 0, 4);
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;


-- Dumping structure for table gom.lieu
CREATE TABLE IF NOT EXISTS `lieu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dayoff` date DEFAULT NULL,
  `explainr` varchar(30) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `workedon` date DEFAULT NULL,
  `explanation` varchar(30) DEFAULT NULL,
  `holidays_lieu_fk` int(10) unsigned DEFAULT NULL,
  `user_lieu_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK24230D18D88431` (`user_lieu_fk`),
  KEY `FK24230DF8E7C5B0` (`holidays_lieu_fk`),
  CONSTRAINT `FK24230D18D88431` FOREIGN KEY (`user_lieu_fk`) REFERENCES `guser` (`id`),
  CONSTRAINT `FK24230DF8E7C5B0` FOREIGN KEY (`holidays_lieu_fk`) REFERENCES `holidays` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.lieu: ~16 rows (approximately)
/*!40000 ALTER TABLE `lieu` DISABLE KEYS */;
INSERT INTO `lieu` (`id`, `dayoff`, `explainr`, `type`, `workedon`, `explanation`, `holidays_lieu_fk`, `user_lieu_fk`) VALUES
	(1, '2012-12-14', NULL, 1, '2012-12-23', '', 2, NULL),
	(2, '2012-12-21', NULL, 0, '2012-12-22', '2012-12-25 TO 2012-12-16', NULL, 4),
	(3, '2012-12-12', NULL, 1, '2012-12-14', '2012-12-12 TO 2012-12-14', 2, 4),
	(4, '2012-12-08', NULL, 1, '2012-12-14', '2012-12-08 TO 2012-12-14', 1, 4),
	(5, '2012-12-06', NULL, 1, '2012-12-15', '', 2, NULL),
	(6, '2013-02-09', NULL, 1, '2013-02-20', '2013-02-09 TO 2013-02-20', 1, NULL),
	(7, '2013-02-09', NULL, 1, '2013-02-20', '2013-02-09 TO 2013-02-20', 1, NULL),
	(8, '2013-03-06', NULL, 0, '2013-03-07', '2013-03-06 TO 2013-03-07', NULL, 4),
	(9, '2013-03-06', NULL, 0, '2013-03-08', '2013-03-06 TO 2013-03-08', NULL, 4),
	(10, '2013-03-05', NULL, 1, '2013-03-06', '2013-03-05 TO 2013-03-06', 1, 4),
	(11, '2013-03-02', NULL, 1, '2013-03-23', '2013-03-02 TO 2013-03-23', 1, 4),
	(12, '2013-03-02', NULL, 1, '2013-03-23', '2013-03-02 TO 2013-03-23', 1, 4),
	(13, '2013-03-16', NULL, 1, '2013-03-17', '2013-03-16 TO 2013-03-17', 2, 4),
	(14, '2013-03-08', NULL, 0, '2013-03-17', '2013-03-08 TO 2013-03-17', NULL, 4),
	(15, '2013-03-13', NULL, 0, '2013-03-16', '2013-03-13 TO 2013-03-16', NULL, 4),
	(16, '2013-03-05', NULL, 0, '2013-03-07', '2013-03-05 TO 2013-03-07', NULL, 4);
/*!40000 ALTER TABLE `lieu` ENABLE KEYS */;


-- Dumping structure for table gom.login
CREATE TABLE IF NOT EXISTS `login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `loginIP` varchar(15) NOT NULL,
  `loginOut` datetime DEFAULT NULL,
  `loginTake` varchar(500) NOT NULL,
  `loginTime` datetime DEFAULT NULL,
  `unlockTime` time DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `reportMark` bit(1) DEFAULT NULL,
  `dateMark` tinyint(4) DEFAULT NULL,
  `des` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK462FF49AB101B5D` (`user_id`),
  CONSTRAINT `FK462FF49AB101B5D` FOREIGN KEY (`user_id`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.login: ~253 rows (approximately)
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`id`, `loginIP`, `loginOut`, `loginTake`, `loginTime`, `unlockTime`, `user_id`, `reportMark`, `dateMark`, `des`) VALUES
	(46, '127.0.0.1', '2012-12-27 19:10:14', '13:43', '2012-11-22 13:43:33', NULL, 4, b'10000000', NULL, NULL),
	(107, '127.0.0.1', NULL, '11:47,11:47,11:47,14:54,14:55,14:56,15:02,15:05,16:25', '2012-12-25 16:25:39', NULL, 1, b'10000000', NULL, NULL),
	(108, '127.0.0.1', '2012-12-27 19:10:14', '14:55,16:10,16:18,16:20,16:21,16:22,16:23,16:26,17:01,17:05,17:58,18:00', '2012-12-25 18:00:52', NULL, 4, b'10000000', NULL, NULL),
	(109, '127.0.0.1', NULL, '14:55,15:12,16:20,17:02,18:00', '2012-12-25 18:00:22', NULL, 3, b'10000000', NULL, NULL),
	(110, '127.0.0.1', '2012-12-28 10:29:51', '15:12,17:02,17:05,17:25', '2012-12-25 17:25:27', NULL, 2, b'10000000', NULL, NULL),
	(112, '127.0.0.1', '2012-12-28 10:29:51', '11:57,11:59,12:03,16:06,16:07,16:20,16:20,17:07,17:24,17:26,17:32', '2012-12-26 17:32:35', NULL, 2, b'10000000', NULL, NULL),
	(113, '127.0.0.1', NULL, '11:58,12:05,12:16,12:17,12:21,16:04,16:06', '2012-12-26 16:06:16', NULL, 3, b'10000000', NULL, NULL),
	(114, '127.0.0.1', '2012-12-27 19:10:14', '16:06,16:07,17:26,18:31', '2012-12-26 18:31:51', NULL, 4, b'10000000', NULL, NULL),
	(115, '127.0.0.1', NULL, '16:07,17:24', '2012-12-26 17:24:16', NULL, 5, b'10000000', NULL, NULL),
	(116, '127.0.0.1', NULL, '16:41', '2012-12-26 16:41:50', NULL, 1, b'10000000', NULL, NULL),
	(118, '127.0.0.1', '2012-12-27 19:10:14', '09:44,09:45,09:45,10:18,10:32,14:53,15:55,17:15,19:10,19:10,19:11,19:12', '2012-12-27 08:44:00', NULL, 4, b'10000000', NULL, NULL),
	(119, '127.0.0.1', '2012-12-28 10:29:51', '10:20,10:32,11:06,11:18,11:24,11:48,11:52,12:11,14:53,15:00,15:01,15:55,16:00,16:38,16:47,16:48,17:15,17:18', '2012-12-27 10:20:17', NULL, 2, b'10000000', NULL, NULL),
	(120, '127.0.0.1', NULL, '11:16,11:22,11:49,14:57', '2012-12-27 11:16:32', NULL, 1, b'10000000', NULL, NULL),
	(121, '127.0.0.1', NULL, '15:06,15:35,16:48', '2012-12-27 15:06:30', NULL, 5, b'10000000', NULL, NULL),
	(126, '127.0.0.1', '2012-12-28 18:23:55', '10:59,11:01,11:02,11:03,11:18,11:18,11:59,12:49,13:51,14:05,14:06,14:23,14:37,15:10,15:17,15:32,15:56,15:59,15:59,16:39,16:44,16:56,18:23', '2012-12-03 00:59:28', NULL, 4, b'10000000', NULL, NULL),
	(127, '127.0.0.1', NULL, '14:30,14:36,14:38,15:59,16:40,16:56', '2012-12-28 14:30:13', NULL, 2, b'10000000', NULL, NULL),
	(128, '127.0.0.1', NULL, '14:32,14:34', '2012-12-28 14:32:52', NULL, 1, b'10000000', NULL, NULL),
	(129, '127.0.0.1', NULL, '14:37,14:38,15:06,15:12,15:32,15:33,15:58,16:39,16:45,16:56,16:56,16:56', '2012-12-28 14:37:56', NULL, 3, b'10000000', NULL, NULL),
	(130, '127.0.0.1', NULL, '16:56', '2012-12-28 16:56:06', NULL, 5, b'10000000', NULL, NULL),
	(131, '127.0.0.1', '2012-12-29 19:55:32', '08:39,09:12,10:02,10:27,10:46,12:00,13:59,14:02,14:20,14:58,15:03,15:05,17:25,17:26,19:55,13:19,13:26,13:29,13:33,14:30,14:46,14:55,14:58,16:47,17:06,17:22,17:24', '2012-12-31 08:35:25', NULL, 4, b'10000000', NULL, NULL),
	(133, '127.0.0.1', NULL, '09:11', '2012-12-29 09:11:43', NULL, 5, b'10000000', NULL, NULL),
	(134, '127.0.0.1', NULL, '10:12,17:26,17:26', '2012-12-29 10:12:27', NULL, 2, b'10000000', NULL, NULL),
	(135, '127.0.0.1', NULL, '10:12,10:43,10:45', '2012-12-29 10:12:43', NULL, 3, b'10000000', NULL, NULL),
	(143, '127.0.0.1', NULL, '17:09', '2012-12-29 17:09:09', NULL, 1, b'10000000', NULL, NULL),
	(144, '192.168.123.166', '2012-12-31 17:29:53', '09:42,15:02,15:09,16:08,16:11,16:15,16:56,17:02,17:29', '2012-12-31 09:42:58', NULL, 5, b'10000000', NULL, NULL),
	(145, '127.0.0.1', NULL, '13:19', '2012-12-31 13:19:26', NULL, 1, b'10000000', NULL, NULL),
	(146, '127.0.0.1', NULL, '13:19,13:20,14:54,14:57,15:00,17:10,17:11,17:12,17:14,17:17,17:22', '2012-12-31 13:19:43', NULL, 3, b'10000000', NULL, NULL),
	(147, '127.0.0.1', NULL, '13:28,13:32,15:00,15:08,16:16,16:46,16:47,16:55', '2012-12-31 13:28:09', NULL, 2, b'10000000', NULL, NULL),
	(151, '192.168.123.166', '2013-01-02 17:32:13', '10:04,10:09,10:48,11:13,11:42,11:44,13:01,13:10,14:39,14:46,16:42,17:32', '2013-01-02 10:04:26', NULL, 5, b'10000000', NULL, NULL),
	(152, '127.0.0.1', '2013-01-02 18:35:18', '10:21,10:34,10:50,10:53,10:55,10:57,11:02,11:03,11:03,11:04,13:03,13:05,13:21,13:23,14:59,17:49,17:51,17:52,18:35', '2013-01-02 08:52:29', NULL, 4, b'10000000', NULL, NULL),
	(153, '127.0.0.1', NULL, '11:30,17:50', '2013-01-02 11:30:44', NULL, 2, b'10000000', NULL, NULL),
	(154, '127.0.0.1', '2013-01-03 17:31:25', '08:31,09:02,09:58,14:47,14:48,14:56,15:18,15:55,16:09,16:14,16:32,17:03,17:17,17:20', '2013-01-03 08:31:04', NULL, 4, b'10000000', NULL, NULL),
	(155, '192.168.123.166', '2013-01-03 17:35:08', '08:51,15:07,15:28,15:37,15:57,15:58,16:04,16:51,17:35', '2013-01-03 08:51:41', NULL, 5, b'10000000', NULL, NULL),
	(156, '127.0.0.1', NULL, '15:36,17:18', '2013-01-03 15:36:32', NULL, 1, b'10000000', NULL, NULL),
	(157, '127.0.0.1', NULL, '15:55,16:14', '2013-01-03 15:55:10', NULL, 3, b'10000000', NULL, NULL),
	(158, '192.168.123.166', NULL, '16:02', '2013-01-03 16:02:19', NULL, 2, b'10000000', NULL, NULL),
	(159, '127.0.0.1', '2013-01-04 17:44:30', '08:32,14:20,14:40,15:23,15:24,15:24,15:25,15:29,15:30,15:50,15:53,15:54,16:01,17:26,17:33,17:33,17:33,17:38,17:39,17:44', '2013-01-04 08:32:04', NULL, 4, b'10000000', NULL, NULL),
	(160, '192.168.123.166', '2013-01-04 17:34:32', '08:34,11:39,13:20,13:28,13:30,13:36,13:37,13:44,14:02,14:10,14:11,14:13,14:14,14:17,14:42,14:58,15:02,15:22,15:23,15:23,15:25,15:33,15:50,15:53,16:02,17:34', '2013-01-04 08:34:04', NULL, 5, b'10000000', NULL, NULL),
	(161, '127.0.0.1', NULL, '09:32,15:30,15:50,15:50,15:53', '2013-01-04 09:32:32', NULL, 1, b'10000000', NULL, NULL),
	(162, '127.0.0.1', NULL, '13:32,13:32,13:36,13:38,13:44,14:03,14:12,14:14,14:29,14:31,14:36,15:23,15:54,17:33', '2013-01-04 13:32:09', NULL, 2, b'10000000', NULL, NULL),
	(163, '127.0.0.1', NULL, '14:08,15:23,15:24,15:26,15:29,15:30,15:47,15:54', '2013-01-04 14:08:02', NULL, 3, b'10000000', NULL, NULL),
	(164, '127.0.0.1', '2013-01-05 20:11:16', '08:31,09:04,09:07,09:09,09:21,09:23,09:23,09:41,10:04,10:06,10:37,10:40,10:42,10:48,11:20,13:31,13:31,13:32,13:43,13:44,13:45,13:47,13:48,13:49,13:50,13:51,13:52,13:52,13:53,13:54,13:55,14:14,16:32,16:48,16:53,16:53,16:53,16:53,16:55,16:57,17:03,18:08,18:49,18:52,18:58,19:02,19:03,19:04,19:04,19:10,19:11,19:13,19:14,19:15,19:16,20:11', '2013-01-05 08:31:04', NULL, 4, b'10000000', 0, NULL),
	(165, '127.0.0.1', '2013-01-05 17:36:04', '08:43,08:48,08:48,08:50,16:03,16:06,16:15,16:16,16:17,16:19,16:21,16:33,16:35,16:36,16:48,16:53,16:53,17:04,17:06,17:35,18:49', '2013-01-05 08:43:58', NULL, 5, b'10000000', 0, NULL),
	(166, '127.0.0.1', '2013-01-05 10:41:59', '09:22,09:25,09:34,09:41,09:41,09:42,09:43,10:01,10:35,10:38,10:41,11:26,16:40,17:03,17:04', '2013-01-05 09:22:18', NULL, 1, b'10000000', 0, NULL),
	(167, '127.0.0.1', NULL, '16:05,16:16,16:23,16:35,16:39,16:48,16:53,17:07,18:49,18:53,19:04', '2013-01-05 16:05:12', NULL, 2, b'10000000', 2, NULL),
	(168, '127.0.0.1', NULL, '18:51', '2013-01-05 18:51:45', NULL, 3, b'10000000', 0, NULL),
	(169, '127.0.0.1', '2013-01-07 17:42:43', '08:31,09:32,15:31,15:35,15:56,16:11,16:11,16:13,16:20,17:40,17:40,17:42', '2013-01-07 08:31:53', NULL, 4, b'10000000', 0, NULL),
	(170, '192.168.123.166', '2013-01-07 17:36:56', '08:31,08:38,15:47,17:12,17:36', '2013-01-07 08:31:57', NULL, 5, b'10000000', 0, NULL),
	(171, '192.168.123.166', '2013-01-07 09:39:08', '09:36,09:39,16:19,16:27,17:20,17:21', '2013-01-07 09:36:10', NULL, 1, b'10000000', 0, NULL),
	(172, '127.0.0.1', NULL, '09:36,16:07,17:41', '2013-01-07 09:36:17', NULL, 3, b'10000000', 0, NULL),
	(173, '127.0.0.1', NULL, '16:11,16:12,16:22,16:25,17:20,17:40', '2013-01-07 16:11:36', NULL, 2, b'10000000', 0, NULL),
	(174, '127.0.0.1', '2013-01-08 17:38:28', '08:31,11:35,17:37,17:38', '2013-01-08 08:31:00', NULL, 4, b'10000000', 0, NULL),
	(175, '192.168.123.119', '2013-01-08 17:32:28', '08:33,10:19,17:32', '2013-01-08 08:33:40', NULL, 5, b'10000000', 0, NULL),
	(176, '192.168.123.119', NULL, '09:52,15:21', '2013-01-08 09:52:18', NULL, 1, b'10000000', 0, NULL),
	(177, '127.0.0.1', NULL, '09:53,09:57,10:59,11:34,15:29,16:10,17:37', '2013-01-08 09:53:55', NULL, 3, b'10000000', 0, NULL),
	(178, '127.0.0.1', NULL, '11:35,17:38', '2013-01-08 11:35:30', NULL, 2, b'10000000', 0, NULL),
	(179, '127.0.0.1', '2013-01-09 18:22:16', '08:32,15:11,15:53,15:54,16:02,16:04,16:07,16:07,16:09,16:09,16:11,16:11,16:16,16:17,16:19,16:19,16:21,16:22,16:23,16:24,16:24,16:26,16:27,16:28,16:29,16:31,16:31,16:32,16:33,16:34,16:50,16:54,16:56,16:59,17:02,17:03,17:04,17:05,17:09,17:10,17:12,17:18,17:18,17:19,18:01,18:02,18:03,18:04,18:06,18:08,18:10,18:11,18:12,18:22', '2013-01-09 08:32:36', NULL, 4, b'10000000', 0, NULL),
	(180, '192.168.123.119', '2013-01-09 17:42:51', '08:33,17:42', '2013-01-09 08:33:56', NULL, 5, b'10000000', 0, NULL),
	(181, '127.0.0.1', NULL, '16:09,16:10,16:25,16:30,16:32', '2013-01-09 16:09:04', NULL, 1, b'10000000', 0, NULL),
	(182, '127.0.0.1', NULL, '18:11,18:13', '2013-01-09 18:11:42', NULL, 3, b'10000000', 0, NULL),
	(183, '127.0.0.1', NULL, '18:13', '2013-01-09 18:13:24', NULL, 2, b'10000000', 0, NULL),
	(184, '127.0.0.1', '2013-01-10 17:36:07', '08:30,09:13,09:15,10:03,10:13,10:21,10:37,10:38,10:40,10:40,10:42,10:44,11:10,11:11,11:12,11:14,11:21,11:24,11:27,11:39,11:41,11:45,11:46,13:56,14:05,14:07,14:08,14:10,14:12,14:16,14:23,14:25,14:29,14:31,16:05,17:24,17:26,17:35,17:35', '2013-01-10 08:30:19', NULL, 4, b'10000000', 0, NULL),
	(185, '192.168.123.119', '2013-01-10 17:41:26', '08:38,17:41', '2013-01-10 08:38:51', NULL, 5, b'10000000', 0, NULL),
	(186, '127.0.0.1', NULL, '16:52', '2013-01-10 16:52:33', NULL, 1, b'10000000', 0, NULL),
	(187, '127.0.0.1', NULL, '17:35', '2013-01-10 17:35:43', NULL, 3, b'10000000', 0, NULL),
	(188, '127.0.0.1', '2013-01-11 18:34:56', '08:27,09:11,09:13,09:14,10:39,10:58,11:04,11:10,11:12,14:22,14:24,14:52,14:54,18:34', '2013-01-11 08:27:13', NULL, 4, b'10000000', 0, NULL),
	(189, '192.168.123.119', '2013-01-11 17:30:48', '08:32,11:04,17:30', '2013-01-11 08:32:33', NULL, 5, b'10000000', 0, NULL),
	(190, '127.0.0.1', '2013-01-12 20:18:56', '09:15,09:16,08:35,10:50,12:05,12:55,13:04,14:01,14:48,15:23,15:23,15:24,15:43,15:44,15:46,16:44,16:57,17:24,17:36,18:08,18:10,18:18,18:37,18:38,20:12,20:14', '2013-01-12 09:15:49', NULL, 4, b'10000000', 0, NULL),
	(191, '127.0.0.1', NULL, '10:52,10:52,10:58,11:01,11:08,11:13,14:31,14:40', '2013-01-11 10:52:01', NULL, 2, b'10000000', 0, NULL),
	(192, '127.0.0.1', NULL, '10:52,10:58,11:13,14:22', '2013-01-11 10:52:07', NULL, 3, b'10000000', 0, NULL),
	(193, '127.0.0.1', NULL, '10:58,14:54', '2013-01-11 10:58:32', NULL, 1, b'10000000', 0, NULL),
	(194, '127.0.0.1', '2013-01-12 17:44:08', '08:34,13:59,14:10,15:25,15:28,16:04,16:09,16:12,16:44,17:43,17:44', '2013-01-12 08:34:12', NULL, 5, b'10000000', 0, NULL),
	(195, '127.0.0.1', '2013-01-12 16:56:50', '11:46,12:39,14:37,14:48,14:51,15:05,15:46,16:46,17:24', '2013-01-12 11:46:15', NULL, 1, b'10000000', 0, NULL),
	(196, '127.0.0.1', NULL, '15:47,17:22,17:24,20:13', '2013-01-12 15:47:00', NULL, 3, b'10000000', 0, NULL),
	(197, '127.0.0.1', '2013-01-14 17:57:42', '08:32,11:09,11:24,12:11,12:44,12:51,12:55,13:15,13:25,13:26,13:33,14:11,17:11,17:14,17:43,17:52,17:54', '2013-01-14 08:32:30', NULL, 4, b'10000000', 0, NULL),
	(198, '192.168.123.119', '2013-01-14 17:39:36', '08:45,17:39', '2013-01-14 08:45:50', NULL, 5, b'10000000', 0, NULL),
	(199, '127.0.0.1', NULL, '11:09,16:55', '2013-01-14 11:09:23', NULL, 1, b'10000000', 0, NULL),
	(200, '127.0.0.1', NULL, '17:53', '2013-01-14 17:53:42', NULL, 2, b'10000000', 0, NULL),
	(201, '127.0.0.1', '2013-01-15 18:16:59', '08:30,11:24,11:46,15:17,16:50,17:01,17:43,17:47,17:47,17:57,18:00,18:10,18:16', '2013-01-15 08:30:47', NULL, 4, b'10000000', 0, NULL),
	(202, '127.0.0.1', NULL, '08:37', '2013-01-15 08:37:10', NULL, 5, b'10000000', 0, NULL),
	(203, '127.0.0.1', NULL, '18:12', '2013-01-15 18:12:12', NULL, 3, b'10000000', 0, NULL),
	(204, '127.0.0.1', '2013-01-15 18:16:20', '18:12', '2013-01-15 18:12:21', NULL, 2, b'10000000', 0, NULL),
	(205, '127.0.0.1', '2013-01-16 17:53:50', '08:33,11:53,15:23,17:53', '2013-01-16 08:33:20', NULL, 4, b'10000000', 0, NULL),
	(207, '192.168.123.119', NULL, '14:25', '2013-01-16 14:25:50', NULL, 5, b'10000000', 0, NULL),
	(208, '127.0.0.1', '2013-01-17 18:24:41', '08:30,14:39,14:49,15:50,15:59,16:41,16:45,17:04,17:06,17:10,17:18,17:18,17:29,17:35,18:23,18:24', '2013-01-17 08:30:51', NULL, 4, b'10000000', 0, NULL),
	(209, '192.168.123.119', '2013-01-17 17:49:35', '08:39,17:49', '2013-01-17 08:39:12', NULL, 5, b'10000000', 0, NULL),
	(210, '127.0.0.1', NULL, '17:35', '2013-01-17 17:35:43', NULL, 2, b'10000000', 0, NULL),
	(211, '127.0.0.1', '2013-01-18 17:36:34', '08:29,09:31,10:38,10:48,13:04,16:51,16:59,17:36,17:36', '2013-01-18 08:29:10', NULL, 4, b'10000000', 0, NULL),
	(212, '192.168.123.119', NULL, '08:38', '2013-01-18 08:38:32', NULL, 5, b'10000000', 0, NULL),
	(213, '127.0.0.1', NULL, '10:37,17:35', '2013-01-18 10:37:52', NULL, 2, b'10000000', 0, NULL),
	(214, '127.0.0.1', NULL, '10:37', '2013-01-18 10:37:59', NULL, 3, b'10000000', 0, NULL),
	(215, '127.0.0.1', '2013-01-19 20:08:59', '08:38,10:16,10:22,13:57,13:59,16:33,17:13,17:15,17:32,19:18,19:30,19:53,19:54,20:08', '2013-01-19 08:38:58', NULL, 4, b'10000000', 0, NULL),
	(216, '127.0.0.1', '2013-01-19 16:46:48', '08:39,10:55,11:25,11:33,11:39,16:35,16:46,19:52', '2013-01-19 08:39:02', NULL, 5, b'10000000', 0, NULL),
	(217, '127.0.0.1', NULL, '11:15,11:32,16:33,17:24,17:32,17:39,17:43,18:05,19:19,19:28', '2013-01-19 11:15:28', NULL, 1, b'10000000', 0, NULL),
	(218, '127.0.0.1', NULL, '11:33', '2013-01-19 11:33:20', NULL, 3, b'10000000', 0, NULL),
	(219, '127.0.0.1', NULL, '16:42,19:53,19:53', '2013-01-19 16:42:21', NULL, 2, b'10000000', 0, NULL),
	(220, '127.0.0.1', NULL, '08:30,10:13,13:42,14:26,14:27,15:55,17:02,17:09,17:23', '2013-01-21 08:30:35', NULL, 4, b'10000000', 0, NULL),
	(221, '127.0.0.1', NULL, '14:18', '2013-01-21 14:18:49', NULL, 1, b'10000000', 0, NULL),
	(222, '192.168.123.119', NULL, '17:35', '2013-01-21 17:35:07', NULL, 2, b'10000000', 0, NULL),
	(223, '192.168.123.119', '2013-01-21 17:39:57', '17:39', '2013-01-21 17:39:54', NULL, 5, b'10000000', 0, NULL),
	(224, '127.0.0.1', '2013-01-22 17:37:58', '08:37,08:43,10:38,10:45,11:37,11:49,11:49,11:51,12:16,17:31,17:34,17:35', '2013-01-22 08:37:43', NULL, 4, b'10000000', 0, NULL),
	(225, '127.0.0.1', NULL, '08:43', '2013-01-22 08:43:03', NULL, 1, b'10000000', 0, NULL),
	(226, '127.0.0.1', NULL, '17:35', '2013-01-22 17:35:01', NULL, 2, b'10000000', 0, NULL),
	(227, '127.0.0.1', '2013-01-23 17:34:30', '08:33,10:29,11:11,11:13,11:32,11:39,11:55,11:58,16:32,16:32,17:31,17:32,17:34', '2013-01-23 08:33:05', NULL, 4, b'10000000', 0, NULL),
	(228, '192.168.123.119', NULL, '08:36,16:32,17:30', '2013-01-23 08:36:09', NULL, 5, b'10000000', 0, NULL),
	(229, '127.0.0.1', NULL, '10:38,11:40,11:42,16:30,16:32,16:45,16:46', '2013-01-23 10:38:46', NULL, 2, b'10000000', 0, NULL),
	(230, '127.0.0.1', NULL, '10:38,10:58,11:03,11:14,16:31,16:42,16:45,16:49', '2013-01-23 10:38:58', NULL, 3, b'10000000', 0, NULL),
	(231, '127.0.0.1', NULL, '11:33,16:32,16:46,16:49', '2013-01-23 11:33:31', NULL, 1, b'10000000', 0, NULL),
	(233, '127.0.0.1', NULL, '09:14,09:15,09:24', '2013-01-24 09:14:28', NULL, 2, b'10000000', 0, NULL),
	(234, '127.0.0.1', NULL, '09:14,09:19,16:12', '2013-01-24 09:14:31', NULL, 5, b'10000000', 0, NULL),
	(236, '127.0.0.1', NULL, '11:41,13:37,15:30,15:32', '2013-01-24 11:41:45', NULL, 3, b'10000000', 0, NULL),
	(240, '127.0.0.1', '2013-01-24 17:59:46', '15:18,15:20,15:23,15:29,17:13,17:25,17:44', '2013-01-24 15:18:45', NULL, 4, b'10000000', 0, NULL),
	(241, '127.0.0.1', '2013-01-25 17:32:50', '08:34,09:07,09:59,10:01,10:42,10:53,11:18,11:29,11:38,16:22,16:33,16:35,17:32', '2013-01-25 08:34:57', NULL, 4, b'10000000', 0, NULL),
	(242, '127.0.0.1', NULL, '09:53,10:00', '2013-01-25 09:53:06', NULL, 1, b'10000000', 0, NULL),
	(243, '192.168.123.119', NULL, '16:35,16:42,16:44,16:45,16:49,16:53', '2013-01-25 16:35:02', NULL, 2, b'10000000', 0, NULL),
	(244, '192.168.123.119', '2013-01-25 17:51:53', '16:40,16:41,16:45,16:48,16:49,16:58,17:51', '2013-01-25 16:40:14', NULL, 5, b'10000000', 0, NULL),
	(245, '192.168.123.119', NULL, '08:37', '2013-01-26 08:37:13', NULL, 5, b'10000000', 0, NULL),
	(259, '127.0.0.1', NULL, '16:10,16:16,16:17,16:20,16:31,16:32,16:32,16:36,16:51,16:55,17:36', '2013-02-18 16:10:04', NULL, 1, b'10000000', 0, NULL),
	(260, '127.0.0.1', '2013-02-18 17:57:15', '08:32,17:51,17:54', '2013-02-18 08:32:41', NULL, 4, b'10000000', 0, NULL),
	(261, '127.0.0.1', NULL, '17:53', '2013-02-18 17:53:20', NULL, 2, b'10000000', 0, NULL),
	(262, '127.0.0.1', '2013-02-19 17:31:02', '08:45,17:27,17:28', '2013-02-19 08:45:52', NULL, 4, b'10000000', 0, NULL),
	(263, '127.0.0.1', NULL, '08:51,09:42', '2000-02-19 08:51:12', NULL, 2, b'10000000', 0, NULL),
	(264, '192.168.123.154', '2013-02-19 17:29:54', '09:48,16:16,16:17,16:18,16:26,16:28,16:38,17:06,17:11,17:28,17:29,17:29', '2013-02-19 09:48:02', NULL, 2, b'10000000', 0, NULL),
	(265, '192.168.123.154', NULL, '12:54,12:58,14:02', '2013-02-19 12:54:32', NULL, 1, b'10000000', 0, NULL),
	(266, '127.0.0.1', NULL, '16:22,16:28,17:06', '2013-02-19 16:22:48', NULL, 5, b'10000000', 0, NULL),
	(267, '127.0.0.1', NULL, '16:38,16:48,16:49,17:10,17:28', '2013-02-19 16:38:42', NULL, 3, b'10000000', 0, NULL),
	(268, '192.168.123.154', NULL, '08:32', '2013-02-20 08:32:11', NULL, 2, b'10000000', 0, NULL),
	(269, '127.0.0.1', '2013-02-20 19:44:08', '08:40,08:49,14:21,14:24,14:30,14:30,14:31,14:32,14:32,14:32,14:33,14:35,14:35,14:45,14:46,14:47,14:47,14:47,14:48,14:53,15:16,15:30,15:43,15:50,16:27,16:29,16:31,16:44,18:44,18:52,18:54,19:44', '2013-02-20 08:40:57', NULL, 4, b'10000000', 0, NULL),
	(270, '127.0.0.1', NULL, '15:22,16:45', '2013-02-20 15:22:44', NULL, 3, b'10000000', 0, NULL),
	(271, '127.0.0.1', '2013-02-21 17:32:49', '08:26,08:41,08:52,08:54,09:01,09:02,09:02,09:03,09:30,09:31,09:47,09:48,10:12,11:02,14:22,14:22,16:25,16:31,17:00,17:00,17:01,17:05,17:07,17:15,17:32', '2013-02-21 08:26:33', NULL, 4, b'10000000', 0, NULL),
	(272, '127.0.0.1', NULL, '14:32,16:43,17:10', '2013-02-21 14:32:48', NULL, 3, b'10000000', 0, NULL),
	(273, '127.0.0.1', '2013-02-22 18:21:56', '08:31,16:03,16:13,16:14,16:57,18:21', '2013-02-22 08:31:30', NULL, 4, b'10000000', 0, NULL),
	(274, '127.0.0.1', NULL, '16:31,16:32,16:39,16:40', '2013-02-22 16:31:00', NULL, 3, b'10000000', 0, NULL),
	(275, '127.0.0.1', NULL, '16:31', '2013-02-22 16:31:08', NULL, 1, b'10000000', 0, NULL),
	(276, '127.0.0.1', '2013-02-23 20:58:17', '08:27,10:12,10:16,10:17,10:20,10:26,10:47,10:54,10:58,11:01,11:04,11:08,11:11,11:51,12:26,12:57,14:14,14:14,14:30,14:31,15:52,16:21,16:29,16:55,16:58,16:59,17:02,17:32,17:33,18:39,20:17,20:58', '2013-02-23 08:27:10', NULL, 4, b'10000000', 0, NULL),
	(277, '127.0.0.1', '2013-02-23 17:32:53', '08:33,10:54,11:45,12:49,12:57,14:51,17:30,17:32', '2013-02-23 08:33:30', NULL, 2, b'10000000', 0, NULL),
	(278, '127.0.0.1', NULL, '10:15,10:19,15:10,16:34,18:17,19:03', '2013-02-23 10:15:46', NULL, 1, b'10000000', 0, NULL),
	(279, '127.0.0.1', NULL, '10:54,11:22,18:34', '2013-02-23 10:54:00', NULL, 5, b'10000000', 0, NULL),
	(280, '127.0.0.1', NULL, '11:20,11:20,11:22,12:32,13:02,16:21,16:43', '2013-02-23 11:20:54', NULL, 3, b'10000000', 0, NULL),
	(281, '127.0.0.1', NULL, '09:33,10:07,10:16,10:34,10:35', '2013-02-24 09:33:36', NULL, 4, b'10000000', 0, NULL),
	(282, '127.0.0.1', '2013-02-25 18:22:30', '08:27,16:10,16:11,16:13,16:23,17:01,17:37,18:22', '2013-02-25 08:27:38', NULL, 4, b'10000000', 0, NULL),
	(283, '192.168.123.154', '2013-02-25 18:02:10', '09:00,18:02', '2013-02-25 09:00:56', NULL, 2, b'10000000', 0, NULL),
	(284, '127.0.0.1', NULL, '16:11', '2013-02-25 16:11:52', NULL, 1, b'10000000', 0, NULL),
	(285, '127.0.0.1', '2013-02-26 18:25:54', '08:29,09:54,10:40,10:53,10:59,11:13,11:28,11:48,12:04,12:30,12:30,14:30,16:08,16:36,18:25', '2013-02-26 08:29:23', NULL, 4, b'10000000', 0, NULL),
	(286, '192.168.123.154', NULL, '11:13,15:12,15:32', '2013-02-26 11:13:51', NULL, 1, b'10000000', 0, NULL),
	(287, '127.0.0.1', NULL, '16:14', '2013-02-26 16:14:11', NULL, 3, b'10000000', 0, NULL),
	(288, '192.168.123.154', '2013-02-26 17:39:28', '17:34', '2013-02-26 17:34:42', NULL, 2, b'10000000', 0, NULL),
	(289, '127.0.0.1', '2013-02-27 18:20:37', '08:29,09:17,09:18,09:38,11:19,15:31,16:04,16:23,17:21,18:20', '2013-02-27 08:29:40', NULL, 4, b'10000000', 0, NULL),
	(290, '192.168.123.171', '2013-02-27 17:34:54', '08:35,17:33', '2013-02-27 08:35:08', NULL, 2, b'10000000', 0, NULL),
	(291, '127.0.0.1', '2013-02-28 17:39:06', '08:26,10:34,16:44,17:39', '2013-02-28 08:26:22', NULL, 4, b'10000000', 0, NULL),
	(292, '127.0.0.1', NULL, '08:35', '2013-02-28 08:35:03', NULL, 2, b'10000000', 0, NULL),
	(293, '127.0.0.1', '2013-03-01 18:25:38', '08:36,08:45,10:04,10:12,10:20,10:33,10:34,10:39,11:02,12:10,12:16,12:17,14:08,14:38,14:46,15:59,16:01,16:23,16:24,16:26,16:27,16:30,16:32,16:35,16:38,16:38,17:33,17:39,17:46,17:49,17:55,17:57,18:02,18:07,18:07,18:09,18:20', '2013-03-01 08:36:08', NULL, 4, b'10000000', 0, NULL),
	(294, '127.0.0.1', '2013-03-02 20:29:57', '08:29,09:03,09:36,09:40,09:50,09:57,10:07,10:12,10:16,10:32,10:54,11:25,12:15,13:09,13:11,13:18,13:31,13:36,13:48,14:08,15:27,15:48,16:12,17:08,17:32,17:32,18:23,18:25,18:27,18:44,20:29', '2013-03-02 08:29:59', NULL, 4, b'10000000', 0, NULL),
	(295, '127.0.0.1', NULL, '14:08,15:43,15:57,17:20', '2013-03-02 14:08:50', NULL, 1, b'10000000', 0, NULL),
	(297, '127.0.0.1', NULL, '17:20', '2013-03-02 17:20:24', NULL, 3, b'10000000', 0, NULL),
	(298, '127.0.0.1', '2013-03-04 17:30:12', '08:30,17:30', '2013-03-04 08:30:31', NULL, 4, b'10000000', 0, NULL),
	(299, '127.0.0.1', NULL, '15:29,15:35,15:36', '2013-03-04 15:29:05', NULL, 1, b'10000000', 0, NULL),
	(300, '127.0.0.1', NULL, '15:36', '2013-03-04 15:36:29', NULL, 3, b'10000000', 0, NULL),
	(305, '127.0.0.1', '2013-03-05 17:53:13', '08:30,10:32,10:32,12:01,12:04,12:06,12:12,12:13,12:14,14:21,14:56,14:59,15:33,16:04,16:24,16:25,16:27,16:31,16:38,16:40,16:42,17:08,17:09,17:14,17:29,17:31,17:32,17:53', '2013-03-05 08:30:31', NULL, 4, b'10000000', 0, NULL),
	(307, '127.0.0.1', NULL, '11:12', '2013-03-05 11:12:46', NULL, 3, b'10000000', 0, NULL),
	(308, '127.0.0.1', NULL, '11:16', '2013-03-05 11:16:27', NULL, 7, b'10000000', 0, NULL),
	(309, '127.0.0.1', '2013-03-06 17:33:48', '08:30,15:44,17:33', '2013-03-06 08:30:45', NULL, 4, b'10000000', 0, NULL),
	(310, '127.0.0.1', '2013-03-07 18:08:54', '08:37,09:56,10:09,10:33,17:02,18:08', '2013-03-07 08:37:15', NULL, 4, b'10000000', 0, NULL),
	(311, '127.0.0.1', NULL, '08:37', '2013-03-07 08:37:16', NULL, 3, b'10000000', 0, NULL),
	(312, '127.0.0.1', '2013-03-08 18:05:06', '08:29,09:37,16:53,18:05', '2013-03-08 08:29:40', NULL, 4, b'10000000', 0, NULL),
	(313, '127.0.0.1', '2013-03-09 11:54:08', '08:36,09:09,09:46,10:24,10:25,10:40,10:46,11:00,11:01,11:01,11:21,11:33,11:33,11:35,11:35,11:36,11:37,11:37,11:43,12:28,12:33,12:35,13:37,15:14,15:14,17:06,17:51,17:57,18:01,18:14,18:49,18:57,18:57,19:01,19:08,19:15', '2013-03-09 08:36:26', NULL, 4, b'10000000', 0, NULL),
	(314, '127.0.0.1', '2013-03-09 11:34:53', '11:34,12:33,19:04,19:09,19:15,19:16', '2013-03-09 11:34:17', NULL, 2, b'10000000', 0, NULL),
	(315, '127.0.0.1', NULL, '12:33,12:42,13:58,13:59', '2013-03-09 12:33:15', NULL, 3, b'00000000', 0, NULL),
	(316, '127.0.0.1', NULL, '13:58,13:59,15:37,17:14,18:01', '2013-03-09 13:58:57', NULL, 1, b'10000000', 0, NULL),
	(317, '127.0.0.1', NULL, '14:03', '2013-03-09 14:03:16', NULL, 6, b'00000000', 0, NULL),
	(318, '127.0.0.1', '2013-03-09 19:16:37', '18:01,19:16,19:16', '2013-03-09 18:01:43', NULL, 5, b'00000000', 0, NULL),
	(319, '127.0.0.1', '2013-03-11 17:41:49', '08:28,15:16,15:21,16:11,17:17,17:21,17:24,17:41,17:41,17:46', '2013-03-11 08:28:12', NULL, 4, b'10000000', 0, NULL),
	(320, '127.0.0.1', NULL, '08:28,15:18,15:27', '2013-03-11 08:28:40', NULL, 2, b'00000000', 0, NULL),
	(321, '127.0.0.1', NULL, '15:18,15:27,16:34', '2013-03-11 15:18:43', NULL, 5, b'00000000', 0, NULL),
	(322, '127.0.0.1', '2013-03-11 17:21:26', '15:19,15:27,15:37,16:11,16:14,16:19,16:21,16:22,16:25,16:31,16:34,16:40,16:45,16:45,16:45,16:46,16:53,17:13,17:14,17:14,17:15,17:15,17:19,17:21,17:23', '2013-03-11 15:19:29', NULL, 1, b'10000000', 0, NULL),
	(323, '127.0.0.1', NULL, '15:27,17:20', '2013-03-11 15:27:39', NULL, 3, b'00000000', 0, NULL),
	(324, '127.0.0.1', '2013-03-12 17:38:09', '08:33,09:19,09:23,10:01,10:58,11:01,12:11,12:16,13:42,13:56,13:56,13:58,14:26,14:28,14:29,14:29,14:30,14:30,16:19,17:01,17:03,17:24,17:28,17:32,17:33,17:38', '2013-03-12 08:33:01', NULL, 4, b'10000000', 0, NULL),
	(325, '127.0.0.1', NULL, '09:38,09:53,10:11,11:01,11:29,11:43,12:10,12:17,13:55', '2013-03-12 09:38:52', NULL, 1, b'10000000', 0, NULL),
	(326, '127.0.0.1', NULL, '17:32,17:32', '2013-03-12 17:32:19', NULL, 3, b'00000000', 0, NULL),
	(327, '127.0.0.1', '2013-03-13 17:34:38', '08:32,10:15,10:15,10:22,10:23,10:26,10:43,11:31,15:41,15:41,15:42,16:03,16:04,17:34', '2013-03-13 08:32:08', NULL, 4, b'10000000', 0, NULL),
	(328, '127.0.0.1', NULL, '15:41', '2013-03-13 15:41:47', NULL, 1, b'10000000', 0, NULL),
	(329, '127.0.0.1', '2013-03-13 17:34:31', '17:34', '2013-03-13 17:34:27', NULL, 2, b'10000000', 0, NULL),
	(330, '127.0.0.1', '2013-03-14 17:33:14', '08:27,10:24,11:37,11:40,15:11,17:03,17:03,17:25,17:33', '2013-03-14 08:27:32', NULL, 4, b'10000000', 0, NULL),
	(331, '127.0.0.1', '2013-03-15 17:31:28', '08:29,10:01,10:13,10:18,10:25,10:46,10:46,17:17,17:30', '2013-03-15 08:29:36', NULL, 4, b'10000000', 0, NULL),
	(332, '127.0.0.1', NULL, '11:32,11:43,17:18', '2013-03-15 11:32:42', NULL, 1, b'10000000', 0, NULL),
	(335, '127.0.0.1', NULL, '11:44', '2013-03-15 11:44:24', NULL, 5, b'00000000', 0, NULL),
	(336, '127.0.0.1', NULL, '17:18', '2013-03-15 17:18:15', NULL, 3, b'00000000', 0, NULL),
	(340, '127.0.0.1', NULL, '08:32,11:36', '2013-03-16 08:32:39', NULL, 2, b'00000000', 0, NULL),
	(341, '127.0.0.1', NULL, '08:32', '2013-03-16 08:32:46', NULL, 5, b'00000000', 0, NULL),
	(342, '127.0.0.1', NULL, '08:39', '2013-03-16 08:39:41', NULL, 7, b'00000000', 0, NULL),
	(346, '127.0.0.1', '2013-03-16 20:13:09', '08:29,10:21,10:35,10:35,10:41,10:58,11:38,11:44,12:30,12:43,13:15,13:21,13:41,13:48,13:53,14:53,14:56,15:01,15:46,15:47,20:13', '2013-03-16 08:29:48', NULL, 4, b'10000000', 0, NULL),
	(347, '127.0.0.1', NULL, '09:04,09:09,09:24,10:05', '2013-03-16 09:04:57', NULL, 3, b'00000000', 0, NULL),
	(348, '127.0.0.1', NULL, '11:39,14:56,18:49', '2013-03-16 11:39:10', NULL, 1, b'10000000', 0, NULL),
	(349, '127.0.0.1', '2013-03-18 17:49:19', '08:30,08:30,08:33,08:33,08:35,09:20,09:26,17:41', '2013-03-18 08:30:26', NULL, 4, b'10000000', 0, NULL),
	(350, '127.0.0.1', NULL, '08:35', '2013-03-18 08:35:52', NULL, 5, b'00000000', 0, NULL),
	(352, '127.0.0.1', '2013-03-19 17:41:17', '08:27,10:25,11:07,11:08,11:09,11:15,11:19,11:31,11:32,11:33,11:35,11:38,14:06,14:47,16:40,17:28,17:41', '2013-03-19 08:31:57', NULL, 4, b'10000000', 0, NULL),
	(353, '127.0.0.1', '2013-03-19 10:25:17', '10:22', '2013-03-19 10:22:58', NULL, 1, b'10000000', 0, NULL),
	(354, '127.0.0.1', '2013-03-20 17:32:06', '08:30,08:42,10:28,11:14,11:43,11:56,16:36,16:49,17:03,17:03,17:16,17:16,17:17,17:29,17:32', '2013-03-20 08:30:07', NULL, 4, b'00000000', 0, NULL),
	(355, '127.0.0.1', '2013-03-20 17:16:40', '11:56,17:13,17:16', '2013-03-20 11:56:43', NULL, 3, b'00000000', 0, NULL),
	(356, '127.0.0.1', '2013-03-20 17:03:21', '17:00', '2013-03-20 17:00:18', NULL, 1, b'10000000', 0, NULL),
	(357, '127.0.0.1', '2013-03-21 17:39:21', '08:30,09:24,09:47,09:48,10:33,10:43,10:45,10:47,10:48,10:49,10:50,10:58,11:06,11:06,11:09,11:32,11:40,12:06,16:22,16:30,16:40,17:26,17:26,17:39', '2013-03-21 08:30:02', NULL, 4, b'10000000', 0, NULL),
	(358, '127.0.0.1', '2013-03-21 16:30:04', '10:42,10:51,11:32,11:34,11:35,11:36,11:46,11:54,11:54,11:55,11:56,15:07,15:23,15:25,15:28,15:41,15:44,15:45,15:45,15:45,15:48,15:48,16:22,16:22,16:23,16:23,16:23,16:26,16:29', '2013-03-21 10:42:09', NULL, 2, b'00000000', 0, NULL),
	(359, '127.0.0.1', '2013-03-21 16:30:38', '11:54,11:55,11:56,12:05,12:06,15:23,15:25,15:38,15:41,15:44,15:45,15:46,15:48,16:22,16:23,16:25,16:27,16:29,16:30', '2013-03-21 11:54:14', NULL, 1, b'10000000', 0, NULL),
	(360, '127.0.0.1', '2013-03-21 16:30:54', '16:22,16:26,16:30,16:30', '2013-03-21 16:22:19', NULL, 5, b'00000000', 0, NULL),
	(361, '127.0.0.1', '2013-03-22 17:34:27', '08:29,09:01,09:02,09:04,10:38,10:41,17:24,17:26', '2013-03-22 08:29:42', NULL, 4, b'10000000', 0, NULL),
	(362, '127.0.0.1', NULL, '08:29', '2013-03-22 08:29:46', NULL, 5, b'00000000', 0, NULL),
	(363, '127.0.0.1', '2013-03-22 17:26:01', '17:25', '2013-03-22 17:25:42', NULL, 3, b'00000000', 0, NULL),
	(364, '127.0.0.1', '2013-03-23 18:01:53', '08:27,12:25,12:26,12:26,12:27,12:27,12:27,12:28,12:28,12:28,12:28,12:30,12:32,12:32,12:32,12:33,12:34,12:42,12:42,12:43,12:51,12:56,12:56,12:57,12:57,12:57,12:57,13:00,13:00,13:00,13:00,13:00,13:01,13:02,13:21,13:42,15:22,16:08,16:12,16:13,16:24,16:47,16:59,17:13,17:15,17:17,17:59,18:00,18:00', '2013-03-23 08:27:19', NULL, 4, b'10000000', 0, NULL),
	(365, '127.0.0.1', NULL, '12:26,12:28', '2013-03-23 12:26:01', NULL, 2, b'00000000', 0, NULL),
	(366, '127.0.0.1', NULL, '12:28,16:32', '2013-03-23 12:28:21', NULL, 1, b'10000000', 0, NULL),
	(367, '127.0.0.1', '2013-03-23 18:00:47', '12:30,16:19,16:25,16:27,17:58,17:58,17:58,17:59', '2013-03-23 12:30:09', NULL, 3, b'00000000', 0, NULL),
	(368, '127.0.0.1', '2013-03-25 18:29:52', '08:26,08:29,08:30,08:30,08:34,08:54,08:54,08:54,09:07,09:16,09:25,09:37,09:38,09:42,10:25,10:26,11:06,13:15,13:24,13:26,13:26,13:26,13:27,13:27,13:27,13:28,13:29,13:30,13:32,13:34,13:34,13:35,13:35,13:35,13:35,13:35,13:37,13:40,13:50,13:50,13:51,13:52,13:52,13:53,13:55,13:58,14:01,14:12,14:17,14:20,14:20,15:07,15:40,15:43,15:56,16:04,16:43,16:44,17:03,17:27,18:29', '2013-03-25 08:26:18', NULL, 4, b'10000000', 0, NULL),
	(369, '127.0.0.1', '2013-03-25 10:24:49', '08:32,08:32,10:24,10:24', '2013-03-25 08:32:44', NULL, 5, b'00000000', 0, NULL),
	(370, '127.0.0.1', '2013-03-25 17:03:29', '08:41,10:24,10:25,10:25,10:26,10:26,10:27,11:10,11:30,11:32,14:51,15:09,15:21,15:21,15:40,15:41,15:41,15:43,16:13,16:17,16:18,16:46,16:52', '2013-03-25 08:41:00', NULL, 1, b'10000000', 0, NULL),
	(371, '127.0.0.1', NULL, '11:07,14:42,15:15,17:07,17:28', '2013-03-25 11:07:15', NULL, 3, b'00000000', 0, NULL),
	(372, '127.0.0.1', '2013-03-26 16:32:49', '08:29,09:19,16:19,16:32,16:32', '2013-03-26 08:29:29', NULL, 5, b'00000000', 0, NULL),
	(373, '127.0.0.1', NULL, '08:40', '2013-03-26 08:40:36', NULL, 1, b'10000000', 0, NULL),
	(374, '127.0.0.1', '2013-03-26 17:35:54', '08:29,09:19,16:19,16:32,16:32,17:33', '2013-03-26 08:29:29', NULL, 4, b'10000000', 0, NULL),
	(375, '127.0.0.1', NULL, '17:32,17:32', '2013-03-26 17:32:31', NULL, 3, b'00000000', 0, NULL),
	(376, '127.0.0.1', '2013-03-27 17:38:39', '08:31,15:08,15:26,15:49,16:24,16:37,16:42,16:44,16:49,17:38', '2013-03-27 08:31:29', NULL, 4, b'10000000', 0, NULL),
	(377, '127.0.0.1', '2013-03-27 16:46:38', '08:33,15:18,15:45,15:50,16:31,16:46,16:46,16:49,16:54', '2013-03-27 08:33:51', NULL, 1, b'10000000', 0, NULL),
	(378, '127.0.0.1', '2013-03-27 17:38:32', '15:16,15:30,15:42,16:44,16:49,17:38', '2013-03-27 15:16:28', NULL, 3, b'00000000', 0, NULL),
	(379, '127.0.0.1', '2013-03-28 17:31:32', '08:31,09:23,11:27,13:53,16:08,17:08,17:31', '2013-03-28 08:31:14', NULL, 4, b'10000000', 0, NULL),
	(380, '127.0.0.1', '2013-03-28 17:08:52', '09:23,17:08', '2013-03-28 09:23:51', NULL, 1, b'10000000', 0, NULL),
	(381, '127.0.0.1', '2013-03-28 17:08:30', '17:08', '2013-03-28 17:08:24', NULL, 3, b'00000000', 0, NULL),
	(382, '127.0.0.1', '2013-03-28 17:31:29', '17:09', '2013-03-28 17:09:56', NULL, 2, b'00000000', 0, NULL),
	(383, '127.0.0.1', '2013-03-29 17:33:15', '08:34,09:14,09:26,10:03,14:15,14:59,17:26,17:33', '2013-03-29 08:34:09', NULL, 4, b'10000000', 0, NULL),
	(384, '127.0.0.1', NULL, '09:17,14:59,15:03,17:28', '2013-03-29 09:17:41', NULL, 3, b'00000000', 0, NULL),
	(385, '127.0.0.1', NULL, '08:29,08:30', '2013-03-30 08:29:37', NULL, 17, b'00000000', 0, NULL),
	(386, '127.0.0.1', NULL, '08:30', '2013-03-30 08:30:26', NULL, 17, b'00000000', 0, NULL),
	(387, '127.0.0.1', '2013-03-30 19:32:50', '08:31,10:28,10:34,11:06,13:02,13:21,13:35,17:17,17:18,17:18,17:19,17:19,17:20,17:20,17:21,17:21,17:34,17:35,17:35,17:39,17:39,17:40,17:40,17:40,17:41,17:41,17:43,17:45,17:47,18:12,18:15,18:18,18:21,18:22,18:22,18:25,18:37,18:38,18:53,18:54,18:54,19:00,19:02,19:14,19:27', '2013-03-30 08:31:04', NULL, 4, b'10000000', 0, NULL),
	(388, '127.0.0.1', '2013-03-30 19:14:12', '13:16,13:16,13:27,13:27,13:33,13:44,14:51,14:55,15:00,15:20,17:21,18:16,18:16,18:18,18:19,18:20,18:27,18:30,18:34,18:46,18:53,18:54,19:02,19:02', '2013-03-30 13:16:13', NULL, 1, b'10000000', 0, NULL),
	(389, '127.0.0.1', NULL, '13:35', '2013-03-30 13:35:58', NULL, 3, b'00000000', 0, NULL),
	(390, '127.0.0.1', '2013-04-01 17:48:44', '08:32,11:27,11:29,11:29,14:01,14:01,15:05,15:11,15:25,15:30,15:38,15:51,15:53,15:57,16:05,16:31,16:37,17:39,17:48', '2013-04-01 08:32:14', NULL, 4, b'10000000', 0, NULL),
	(391, '127.0.0.1', '2013-04-01 15:53:44', '11:44,11:47,11:47,11:47,14:01,14:10,14:58,15:22,15:26,15:50,15:52,15:57,15:57', '2013-04-01 11:44:49', NULL, 1, b'10000000', 0, NULL),
	(392, '127.0.0.1', NULL, '17:20', '2013-04-01 17:20:46', NULL, 3, b'00000000', 0, NULL),
	(393, '127.0.0.1', '2013-04-02 17:34:17', '08:30,10:50,16:01,16:12,16:29,16:50,17:13,17:13,17:14,17:14,17:18,17:19,17:20,17:20,17:20,17:21,17:21,17:28,17:28,17:28,17:34', '2013-04-02 08:30:40', NULL, 4, b'10000000', 0, NULL),
	(394, '127.0.0.1', '2013-04-03 17:49:02', '08:32,12:53,12:55,13:20,13:42,13:58,14:07,14:07,14:34,14:42,14:44,14:46,14:53,14:56,14:57,14:59,15:33,15:33,15:38,15:40,15:41,15:41,15:43,15:45,16:32,16:36,16:37,16:37,17:17,17:17,17:17,17:27,17:28', '2013-04-03 08:32:51', NULL, 4, b'10000000', 0, NULL),
	(395, '127.0.0.1', NULL, '17:27', '2013-04-03 17:27:57', NULL, 3, b'00000000', 0, NULL),
	(396, '127.0.0.1', '2013-04-05 17:44:19', '08:29,08:36,08:37,08:42,08:42,08:42,08:43,08:47,08:47,10:07,10:07,10:10,10:10,10:10,10:10,10:17,10:17,10:18,13:00,13:00,13:01,13:03,13:04,13:07,13:10,13:11,13:21,13:22', '2013-04-05 08:29:47', NULL, 4, b'10000000', 0, NULL),
	(397, '127.0.0.1', NULL, '08:42', '2013-04-05 08:42:16', NULL, 3, b'00000000', 0, NULL),
	(398, '127.0.0.1', '2013-04-05 13:00:38', '10:36', '2013-04-05 10:36:50', NULL, 1, b'10000000', 0, NULL),
	(399, '127.0.0.1', '2013-04-06 12:19:45', '08:30,15:28', '2013-04-06 08:30:08', NULL, 4, b'00000000', 0, NULL),
	(400, '127.0.0.1', '2013-04-08 18:20:39', '08:31,10:26,10:29,16:04,17:06,17:06,17:06,18:09,18:12', '2013-04-08 08:31:10', NULL, 4, b'10000000', 0, NULL),
	(401, '127.0.0.1', '2013-04-08 18:18:40', '18:12', '2013-04-08 18:12:57', NULL, 3, b'00000000', 0, NULL),
	(402, '127.0.0.1', '2013-04-09 18:07:27', '08:35', '2013-04-09 08:35:35', NULL, 4, b'10000000', 0, NULL),
	(403, '127.0.0.1', '2013-04-10 18:31:33', '08:32,12:00,12:00,12:01,12:06,12:22,12:38,14:51,14:51,14:53,16:45,16:46,16:50,16:55,18:31', '2013-04-10 08:32:21', NULL, 4, b'10000000', 0, NULL),
	(404, '127.0.0.1', NULL, '13:45', '2013-04-10 13:45:42', NULL, 1, b'10000000', 0, NULL),
	(405, '127.0.0.1', NULL, '15:35,15:35,15:37', '2013-04-10 15:35:26', NULL, 3, b'00000000', 0, NULL),
	(406, '127.0.0.1', NULL, '08:30,08:30,09:07', '2010-04-11 08:30:14', NULL, 4, b'00000000', 0, NULL),
	(407, '127.0.0.1', '2013-04-11 13:17:55', '10:11,10:17,10:17,10:18,10:18,10:20,10:20,10:21,10:22,10:22,10:26,10:26,10:26,10:26,11:03,11:04,11:09,11:10,11:10,11:13,11:17,11:20,11:24,11:25,11:25,11:26,11:27,11:28,11:28,11:28,11:29,11:29,11:29,11:29,11:30,11:30,11:31,11:31,11:31,11:52,11:54,11:58,12:01,12:10,12:11,12:16,13:18,16:32', '2013-04-11 08:28:47', NULL, 4, b'00000000', 0, NULL),
	(408, '127.0.0.1', '2013-04-11 11:51:55', '11:20,11:24,11:26,11:33,11:33', '2013-04-11 11:20:18', NULL, 1, b'10000000', 0, NULL),
	(409, '127.0.0.1', '2013-04-11 16:32:17', '15:29,15:29,16:25', '2013-04-11 15:29:17', NULL, 3, b'00000000', 0, NULL);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;


-- Dumping structure for table gom.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dated` datetime NOT NULL,
  `level` varchar(10) NOT NULL,
  `logger` varchar(50) NOT NULL,
  `message` varchar(2000) NOT NULL,
  `type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.logs: ~6 rows (approximately)
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`id`, `dated`, `level`, `logger`, `message`, `type`) VALUES
	(1, '2012-11-06 15:59:58', '2', '缺陷修正', '<p>\r\n	<strong><span style="color:#003399;">缺陷修正</span></strong> \r\n</p>\r\n<ol>\r\n	<li>\r\n		当服务器忙时，提示用户服务器忙，请稍后再访问，而不是看到一个出错页面\r\n	</li>\r\n	<li>\r\n		首页的登入选项卡中要可查阅具体日期的登陆信息\r\n	</li>\r\n	<li>\r\n		退出系统的弹出层中显示的收件人必须是系统中未禁用及未注销的人员\r\n	</li>\r\n	<li>\r\n		登入系统时用户名与注册时的大小写完全一样才能正常登入\r\n	</li>\r\n	<li>\r\n		职务代理人应不能用户自己选择，应直接从个人资料中读取，如职务代理人以被系统注销将显示未红色，并在用户点击确认按钮时提示用户连接至个人资料中修改\r\n	</li>\r\n</ol>\r\n<br />', 3),
	(2, '2012-11-06 16:00:53', '1', '改进功能', '<p>\r\n	<span style="color:#003399;"><strong>改进功能</strong></span>\r\n</p>\r\n<ol>\r\n	<li>\r\n		登入系统时，能提示用户及时更新与已注销掉的用户相关连的模块信息\r\n	</li>\r\n	<li>\r\n		登入首页时的统计要能按时间及人员搜索信息，普通人员能看到自己的及报告给他的人员及以下人员的统计信息，管理员可看到所有人的统计信息\r\n	</li>\r\n	<li>\r\n		管理责任中功能代码的说明列，以数字显示说明条数，点击时弹出具体信息层查看编辑\r\n	</li>\r\n	<li>\r\n		管理责任中编辑页面可切换FCODE，进行查看\r\n	</li>\r\n</ol>\r\n<br />', 1),
	(3, '2012-11-06 16:01:01', '1', '新增功能', '<p>\r\n	<strong><span style="color:#003399;">新增功能</span></strong> \r\n</p>\r\n<ol>\r\n	<li>\r\n		首页中以广播的形式展现GOM系统版本更新日志<br />\r\n	</li>\r\n	<li>\r\n		贡献中增加搜索条件：按日期、已完成、未完成查询<br />\r\n	</li>\r\n	<li>\r\n		在系统左导航最上方增加“首页”导航，首页中分为：出勤、需要做、PI（不生效）、日报、周报、月报、总经理周报（不是总经理的不生效）、登陆选项卡页面\r\n	</li>\r\n	<li>\r\n		工作指令中的编辑页面中固定项目号(PRXXXXXX),固定版本号(VXX),固定文件号(PXXXXXX）\r\n	</li>\r\n	<li>\r\n		工作指令可按日期，已完成，未完成，全部这些条件搜索\r\n	</li>\r\n	<li>\r\n		如何做中总表增加创建日期，期间（1-12个月，内定为3各月），计划日期（自动算取）说明显示内容可固定并以省略号表示其它内容\r\n	</li>\r\n	<li>\r\n		将Email设置放入后台的操作指南之后，由部门主管设置\r\n	</li>\r\n	<li>\r\n		人力训练中增加训练类型：内训（内定），外训\r\n	</li>\r\n	<li>\r\n		用户管理中增加搜索条件：未注销，已注销（红色），全部，默认显示未注销用户，按工号排序资产管理中增加挑选转交人员功能，勾选人员转交后此资产将显示在转交人员中，此时这条数据将显示已转交状态\r\n	</li>\r\n	<li>\r\n		增加广播周期（每三天、每几天，礼拜几，内定为每天），状态（作废，正常）\r\n	</li>\r\n</ol>', 1),
	(4, '2012-11-08 09:05:23', '1', '日志乱码', '<p style="text-align:left;">\r\n	<strong><span style="color:#006600;">日志乱码</span></strong><strong><span style="color:#006600;"> </span></strong>      \r\n</p>\r\n<p style="color:#000000;font-family:Helvetica, Tahoma, Arial, sans-serif;font-size:14px;font-style:normal;font-weight:normal;text-align:left;text-indent:0px;background-color:#FFFFFF;">\r\n	<span style="color:#009900;font-size:12px;">         <span style="color:#000000;">手头的项目用LOG4J做日志的输出处理，可不知怎么了，最近输出的日志内容里面居然出现了乱码——问号，而且比较郁闷的是，从另一个类的属性里面读出的中文确可以正常显示，试了各种办法，如给日志增加一项ENCODE为GBK，UTF-8，均不能解决此问题，突然想到会不会是JAVA源文件的问题了？？？</span></span> \r\n</p>\r\n<p style="color:#000000;font-family:Helvetica, Tahoma, Arial, sans-serif;font-size:14px;font-style:normal;font-weight:normal;text-align:left;text-indent:0px;background-color:#FFFFFF;">\r\n	<span style="color:#000000;font-size:12px;">想到前此因为在MYECLIPSE里面看中文是乱码，我曾经调整过CONTENT TYPES(即window->preferences->general->content types)，更改过text的编码格式，即default encode，检查之下，果然如此，于是我把默认的JAVA SOURCES源下的GBK给删除了，然后重新编译，乱码问题解决，呵呵，放在此处，供有心之人在遇到此类问题的时候提个醒.</span> \r\n</p>\r\n<br />', 3),
	(46, '2013-03-11 17:18:41', '3', '系统通知', '系统通知：中午测试GOM时的日志<br />', 3),
	(47, '2013-03-16 14:54:22', '1', '130316更新记录', '<p>\r\n	<strong><span style="color:#009900;">130316更新记录</span></strong>\r\n</p>\r\n<p>\r\n	添加404和500警告页面。\r\n</p>\r\n修改重复提交登录，注册，文件管理等等采用Session分配随便验证码为令牌方式提交，保证只允许一次有效提交，防止多重提交产生错误。<br />\r\n修改用户离职提交报邮箱验证错误没有提示。<br />\r\n修正离职后接收人部门显示groupID的错误。<br />\r\n修改在请假时接收人部门选择错误问题。<br />\r\n<br />\r\n<br />', 2);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;


-- Dumping structure for table gom.meeting
CREATE TABLE IF NOT EXISTS `meeting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(2000) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.meeting: ~11 rows (approximately)
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` (`id`, `content`, `endDate`, `explains`, `host`, `isTrace`, `locale`, `notes`, `number`, `participants`, `time`, `title`, `traceDate`) VALUES
	(36, NULL, NULL, '工作会议工作会议', 'sherry', NULL, '会议室', 'sqe_ole', '001', 'sherry', '2012-11-15 18:31:31', '工作会议', NULL),
	(37, NULL, NULL, '工作会议工作会议', 'sherry', NULL, '会议室', 'sqe_ole', '002', 'sherry', '2012-12-17 18:31:31', '工作会议', NULL),
	(38, NULL, NULL, '就GOM测试问题进行讨论', 'sherry', NULL, '办公室', 'sherry', '003', 'sherry,wendy', '2013-01-02 14:00:45', '讨论GOM', NULL),
	(39, 'fdssdfsdfsdfdf&lt;br /&gt;', '2013-03-27', '测试', 'admin', b'10000000', '公司', 'sherry', '001', 'sherry,wendy,admin,james,sqe_ole', '2009-01-04 00:55:17', '测试', '2013-03-27'),
	(48, NULL, NULL, 'sdaf', 'sqe_ole', NULL, 'asdf', 'sqe_ole', '001', 'sqe_ole', '2013-03-29 14:59:47', 'TEST', NULL),
	(49, NULL, NULL, 'dsfa', 'sqe_ole', NULL, '111', 'sqe_ole', '1111', 'sqe_ole', '2013-03-29 15:03:53', '111', NULL),
	(50, NULL, NULL, 'dsfa', 'sqe_ole', NULL, '111', 'sqe_ole', '1111', 'sqe_ole', '2013-03-29 15:03:53', '111', NULL),
	(51, NULL, NULL, 'dsfa', 'sqe_ole', NULL, '111', 'sqe_ole', '1111', 'sqe_ole', '2013-03-29 15:03:53', '111', NULL),
	(52, NULL, NULL, 'dsfa', 'sqe_ole', NULL, '111', 'sqe_ole', '1111', 'sqe_ole', '2013-03-29 15:03:53', '111', NULL),
	(53, NULL, NULL, 'dsfa', 'sqe_ole', NULL, '111', 'sqe_ole', '1111', 'sqe_ole', '2013-03-29 15:03:53', '111', NULL),
	(54, NULL, NULL, 'dsfa', 'sqe_ole', NULL, '111', 'sqe_ole', '1111', 'sqe_ole', '2013-03-29 15:03:53', '111', NULL);
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;


-- Dumping structure for table gom.motto
CREATE TABLE IF NOT EXISTS `motto` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mottoText` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.motto: ~1 rows (approximately)
/*!40000 ALTER TABLE `motto` DISABLE KEYS */;
INSERT INTO `motto` (`id`, `mottoText`) VALUES
	(1, '<ul>\r\n	<li class="MsoNormal">\r\n		态度决定一切<span>,</span>细节决定成败\r\n	</li>\r\n	<li class="MsoNormal">\r\n		一个成功的公司：\r\n	</li>\r\n	<ul>\r\n		<li class="MsoNormal">\r\n			所有问题的发现，都是公司的重大资产\r\n		</li>\r\n		<li class="MsoNormal">\r\n			不要让它成为历史，我们要将学习的经验留下来\r\n		</li>\r\n		<li class="MsoNormal">\r\n			个人跟公司都因这些经验而成长\r\n		</li>\r\n	</ul>\r\n	<li>\r\n		一个失败的公司：\r\n	</li>\r\n	<ul>\r\n		<li class="MsoNormal">\r\n			问题没被解决\r\n		</li>\r\n		<li class="MsoNormal">\r\n			问题一再发生\r\n		</li>\r\n		<li class="MsoNormal">\r\n			个人成长但是团队失败\r\n		</li>\r\n	</ul>\r\n	<li class="MsoNormal">\r\n		最好的伙伴关系就是为共同优势而有的互信与互重关系，进而创造超越任何一方独自能够达到的成果\r\n	</li>\r\n	<li class="MsoNormal">\r\n		先问自己能贡献给团队什么，再问团队能给你什么\r\n	</li>\r\n	<li class="MsoNormal">\r\n		成功来自于团队创意得到纪律般的执行力\r\n	</li>\r\n	<li class="MsoNormal">\r\n		要用心及大脑做事，不要用体力及时间来做事。前者客户满意，后者自己都不满意\r\n	</li>\r\n	<li class="MsoNormal">\r\n		合格的人讲方法<span>,</span>不合格的人讲疏忽\r\n	</li>\r\n	<li class="MsoNormal">\r\n		日日清，过程监控，结果导向\r\n	</li>\r\n	<li class="MsoNormal">\r\n		以诚做事，用情做人，以理服人，以义交友，我们以<span>\'</span>诚情理义<span>\'</span>服务我们的客户双赢\r\n	</li>\r\n</ul>\r\n<hr />');
/*!40000 ALTER TABLE `motto` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.process: ~32 rows (approximately)
/*!40000 ALTER TABLE `process` DISABLE KEYS */;
INSERT INTO `process` (`id`, `actor`, `assignType`, `icon`, `nodeCode`, `nodeName`, `nodeOrder`, `type`) VALUES
	(1, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Apply', '申请人', 1, 3),
	(2, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '直接主管', 2, 3),
	(3, 'sherry', 0, '253534dc6b794874aa048d57ec62544c.jpg', 'Personnel', '离职审核人事专员', 3, 3),
	(4, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Receiver', '工作接收人', 4, 3),
	(5, 'sherry', 0, '253534dc6b794874aa048d57ec62544c.jpg', 'Financial', '离职财务结算专员', 5, 3),
	(6, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Adjustment', '工作接收人责任调整', 6, 3),
	(7, 'basis.adminIT', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Technology', 'IT管理员', 7, 3),
	(8, 'departure.ftl', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Email', '发送邮件', 8, 3),
	(9, 'Close', 4, '50edc203b1ad41239836ab524ae840d2.jpg', 'End', '流程结束', 9, 3),
	(10, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'newEntry', '新职员', 1, 2),
	(11, 'entrant.HR', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Personnel', '人事审核资料', 2, 2),
	(12, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '主管分配职责', 3, 2),
	(13, 'basis.adminIT', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Technology', 'IT管理员开通帐号', 4, 2),
	(14, 'entrant.ftl', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Email', '发送入职邮件', 5, 2),
	(15, 'Close', 4, '50edc203b1ad41239836ab524ae840d2.jpg', 'End', '流程结束', 6, 2),
	(16, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Apply', '申请人', 1, 0),
	(17, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Agent', '代理人', 2, 0),
	(18, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '直接主管', 3, 0),
	(19, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Manager', '上级管理者', 4, 0),
	(20, 'leave.ftl', 4, '253534dc6b794874aa048d57ec62544c.jpg', 'Email', '发送邮件', 5, 0),
	(21, 'Close', 4, '50edc203b1ad41239836ab524ae840d2.jpg', 'End', '流程结束', 6, 0),
	(22, 'wendy,sherry', 1, '253534dc6b794874aa048d57ec62544c.jpg', 'AddTask', '添加工作', 1, 1),
	(23, 'wendy,sherry', 1, '253534dc6b794874aa048d57ec62544c.jpg', 'Allocation', '分配工作', 2, 1),
	(24, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Executor', '执行者', 3, 1),
	(25, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Help', '需要帮忙', 4, 1),
	(26, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '审核者', 5, 1),
	(27, 'Close', 4, '50edc203b1ad41239836ab524ae840d2.jpg', 'End', '结束', 6, 1),
	(28, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Submit', '异常提交', 1, 4),
	(29, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Director', '直接主管', 2, 4),
	(30, '', 3, '253534dc6b794874aa048d57ec62544c.jpg', 'Indirect', '间接主管', 3, 4),
	(31, '', 3, 'email.png', 'Email', '发送邮件', 4, 4),
	(32, 'Close', 4, '50edc203b1ad41239836ab524ae840d2.jpg', 'End', '流程结束', 5, 4);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.product: ~2 rows (approximately)
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `explains`, `num`, `outputDate`, `productName`, `productType`, `unit`, `version`) VALUES
	(2, 'GOM（General Operation Management）日常操作管理系统实现办公自动化，更好的为企业用户提供服务。公司管理者或项目成员可透过本系统来了解组织及项目内部的运转及绩效表现。对于管理责任的分配及交接，以动态管理模式来记录现行的管理及其可能的缺陷。系统提供了个性化的工作界面，方便用户设置个人信息幷根据自身的业务分工设置工作日程，合理安排时间，避免工作的无条理和盲目性。', 1, '2012-09-20', 'GOM', 0, '个', 'v3.0'),
	(4, '用于日常工作', 1, '2013-01-08', '新GOM ', 0, '套', '01');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.project: ~4 rows (approximately)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`id`, `actualEnd`, `actualTime`, `des`, `director`, `endDate`, `expectedTime`, `projectName`, `projectNo`, `startDate`, `state`, `type`, `updateDate`, `version`, `parentid`, `project_product_fk`) VALUES
	(1, NULL, NULL, 'GOM（General Operation Management）日常操作管理系统实现办公自动化，更好的为企业用户提供服务。公司管理者或项目成员可透过本系统来了解组织及项目内部的运转及绩效表现。对于管理责任的分配及交接，以动态管理模式来记录现行的管理及其可能的缺陷。系统提供了个性化的工作界面，方便用户设置个人信息幷根据自身的业务分工设置工作日程，合理安排时间，避免工作的无条理和盲目性。', 'admin', '2012-09-30', '240', 'GOM', '01', '2012-09-01', 3, 0, '2012-09-27', 'v3.0', NULL, 2),
	(2, NULL, NULL, '主要做GOM登录Login部分', 'admin', '2012-09-06', '56', '登录模块', '011', '2012-09-01', 3, 1, '2012-09-27', 'v3.0', 1, NULL),
	(4, NULL, NULL, '用于日常工作', 'sherry', '2013-01-09', '12', '新GOM', '02', '2013-01-08', 3, 0, '2013-04-11', '01', NULL, 4),
	(5, NULL, NULL, 'gom测试', 'sherry', '2013-02-23', '100', 'GOM测试', '001', '2013-02-20', 3, 1, '2013-04-08', 'v3.0', 4, NULL);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


-- Dumping structure for table gom.reportconfig
CREATE TABLE IF NOT EXISTS `reportconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `assets` bit(1) DEFAULT NULL,
  `daily` bit(1) DEFAULT NULL,
  `devote` bit(1) DEFAULT NULL,
  `doing` bit(1) DEFAULT NULL,
  `help` bit(1) DEFAULT NULL,
  `how` bit(1) DEFAULT NULL,
  `login` bit(1) DEFAULT NULL,
  `perMonth` bit(1) DEFAULT NULL,
  `quarterly` bit(1) DEFAULT NULL,
  `repos` bit(1) DEFAULT NULL,
  `summary` bit(1) DEFAULT NULL,
  `task` bit(1) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `weekDevote` bit(1) DEFAULT NULL,
  `weekly` bit(1) DEFAULT NULL,
  `user_report_fk` int(10) unsigned DEFAULT NULL,
  `cc` varchar(500) DEFAULT NULL,
  `receiver` varchar(500) DEFAULT NULL,
  `send` bit(1) DEFAULT NULL,
  `sendTime` varchar(30) DEFAULT NULL,
  `ccename` varchar(150) DEFAULT NULL,
  `ename` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK122C61B6FC2DB18A` (`user_report_fk`),
  CONSTRAINT `FK122C61B6FC2DB18A` FOREIGN KEY (`user_report_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.reportconfig: ~24 rows (approximately)
/*!40000 ALTER TABLE `reportconfig` DISABLE KEYS */;
INSERT INTO `reportconfig` (`id`, `assets`, `daily`, `devote`, `doing`, `help`, `how`, `login`, `perMonth`, `quarterly`, `repos`, `summary`, `task`, `type`, `weekDevote`, `weekly`, `user_report_fk`, `cc`, `receiver`, `send`, `sendTime`, `ccename`, `ename`) VALUES
	(1, b'10000000', b'10000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', 0, b'10000000', b'00000000', 1, 'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,roger@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', 'gom-admin@sqeservice.com', b'00000000', NULL, 'sherry,wendy,roger,james,sqe_ole', 'admin'),
	(2, b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', 1, b'10000000', b'10000000', 1, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(3, b'10000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', 2, b'00000000', b'00000000', 1, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(4, b'10000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 3, b'00000000', b'00000000', 1, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(5, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'10000000', b'00000000', b'00000000', 4, b'00000000', b'00000000', 1, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(6, b'10000000', b'10000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'10000000', b'10000000', b'00000000', b'00000000', b'00000000', 3, b'10000000', b'10000000', 3, 'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', 'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', b'10000000', NULL, 'admin,james,sqe_ole', 'admin,james,sqe_ole'),
	(7, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 1, b'00000000', b'10000000', 3, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(8, b'00000000', b'10000000', b'00000000', b'10000000', b'00000000', b'10000000', b'00000000', b'10000000', b'10000000', b'00000000', b'00000000', b'00000000', 4, b'00000000', b'10000000', 3, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(9, b'00000000', b'10000000', b'00000000', b'10000000', b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', 0, b'10000000', b'10000000', 3, 'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,roger@sqeservice.com,sqe_ole@sqeservice.com', 'sqe_james@sqeservice.com', b'10000000', NULL, 'sherry,wendy,roger,sqe_ole', 'james'),
	(10, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', 2, b'00000000', b'10000000', 3, NULL, NULL, b'00000000', NULL, NULL, NULL),
	(11, b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', 0, b'10000000', b'10000000', 4, 'sqegom2@126.com,sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,sqe_james@sqeservice.com', 'sqe_ole@sqeservice.com', b'10000000', NULL, 'roger,sherry,wendy,james', 'sqe_ole'),
	(12, b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', b'00000000', b'10000000', b'10000000', b'10000000', 1, b'10000000', b'10000000', 4, '', 'sqe_ole@sqeservice.com', b'10000000', '1', '', 'sqe_ole'),
	(13, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', 2, b'00000000', b'00000000', 4, '', 'sqe_ole@sqeservice.com', b'10000000', '1', '', 'sqe_ole'),
	(14, b'10000000', b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', 3, b'10000000', b'00000000', 4, '', 'sqe_ole@sqeservice.com', b'10000000', '30', '', 'sqe_ole'),
	(15, b'10000000', b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', 4, b'10000000', b'00000000', 4, '', 'sqe_ole@sqeservice.com', b'10000000', '', '', 'sqe_ole'),
	(16, b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', b'00000000', b'10000000', b'10000000', b'10000000', 0, b'10000000', b'00000000', 2, 'sqe_wendy@sqeservice.com,roger@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', 'sqe_sherry@sqeservice.com', b'10000000', NULL, 'wendy,roger,james,sqe_ole', 'sherry'),
	(17, b'00000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'00000000', b'00000000', b'10000000', b'10000000', b'10000000', 1, b'10000000', b'00000000', 2, 'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', 'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com', b'00000000', NULL, 'admin,james,sqe_ole', 'sherry,wendy'),
	(18, b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', 2, b'00000000', b'00000000', 2, '', '', b'00000000', NULL, '', ''),
	(19, b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', 3, b'00000000', b'00000000', 2, '', '', b'00000000', NULL, '', ''),
	(20, b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'10000000', b'00000000', b'00000000', b'00000000', 4, b'00000000', b'00000000', 2, '', '', b'00000000', NULL, '', ''),
	(21, b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', b'10000000', 0, b'10000000', b'10000000', 5, 'roger@sqeservice.com,sqe_sherry@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', 'sqe_wendy@sqeservice.com', b'10000000', NULL, 'roger,sherry,james,sqe_ole', 'wendy'),
	(22, b'10000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 4, b'00000000', b'00000000', 5, 'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com', 'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com', b'10000000', NULL, 'admin,james,sqe_ole', 'sherry,wendy'),
	(27, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 5, b'00000000', b'00000000', 4, 'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,sqe_james@sqeservice.com,sqegom2@126.com,sqegom1@126.com,sqegom2@126.com', 'sqe_ole@sqeservice.com', b'10000000', NULL, 'sherry,wendy,james,sqe_ole,jason,roger', 'sqe_ole'),
	(28, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 5, b'00000000', b'00000000', 3, '', 'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com', b'00000000', NULL, '', 'sherry,wendy');
/*!40000 ALTER TABLE `reportconfig` ENABLE KEYS */;


-- Dumping structure for table gom.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` float DEFAULT NULL,
  `dated` date DEFAULT NULL,
  `item` tinyint(4) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `user_reports_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK413E51BF76962D87` (`user_reports_fk`),
  CONSTRAINT `FK413E51BF76962D87` FOREIGN KEY (`user_reports_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;


-- Dumping structure for table gom.resource
CREATE TABLE IF NOT EXISTS `resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attachment` varchar(36) NOT NULL,
  `createDate` date DEFAULT NULL,
  `des` varchar(500) NOT NULL,
  `downloadDate` date DEFAULT NULL,
  `isValid` bit(1) DEFAULT NULL,
  `level` varchar(15) DEFAULT NULL,
  `maintainDpt` varchar(20) NOT NULL,
  `resourceType` tinyint(4) unsigned DEFAULT NULL,
  `responsibility` int(10) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.resource: ~22 rows (approximately)
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource` (`id`, `attachment`, `createDate`, `des`, `downloadDate`, `isValid`, `level`, `maintainDpt`, `resourceType`, `responsibility`, `score`, `swot`, `title`, `updateDate`, `uploadDate`, `uploadEname`, `version`, `category_resource_fk`, `number`) VALUES
	(5, '4f0cf60a607d415b8c961443c9821e6b.jpg', '2012-11-15', '人事人员', NULL, b'10000000', NULL, 'IT部', 0, 0, 0, NULL, '人事人员', '2013-02-22', '2013-02-22', 'james', 'V-1.2', 1, NULL),
	(6, '', '2012-12-31', '', NULL, b'10000000', NULL, '人事部', 4, 0, 10, '', '兴业银行转帐', NULL, '2012-12-31', 'sherry', 'V-1.0', 1, '0001'),
	(7, '18adda11164b4f218ad47dd5ebdf1566.jpg', '2013-01-02', '1.收到中药后清点数量、询问Roger成品中药的数量。\n2.用信封将计算出来的总金额装好并密封，把信封放在中药袋里面，封口。\n3.电话联系：021-58404191，询问工作人员收药到煎药的流程，估算时间。\n4.邮件/电话询问Roger并告知相关情况取决一种合适的方式。\na、亲自送过去，对方当天可以收件。\nb、如果时间允许邮寄过去。\n5.地址：上海市浦东新区乳山路79号 收件人：养和堂乳山路店 联系方式：021-58404191\n6.多煮包，多付费，多煮分数问Roger\n7.询问中药什么时候煮什么时候煮好，寄回后告知Roger 此事', NULL, b'10000000', NULL, '人事部', 4, 0, 10, '', '代煎中药', '2013-01-02', '2013-01-02', 'wendy', 'V-1.1', 1, '0002'),
	(8, '09c5cc801e574d2f9b7618da9f4e6b1d.doc', '2013-01-04', 'wendy心得最近添加于2013-01-04', NULL, b'10000000', NULL, 'IT部', 3, 0, 0, NULL, 'wendy最近心得', '2013-02-22', '2013-02-22', 'james', 'V-1.8', NULL, NULL),
	(9, '', '2013-01-07', '空白凭证领用方法\n1.从银行取回空白凭证领用单\n2.到公司盖“法人章”和“财务章”于领用单位预留印鉴“两章需挨着\n3.在”领用人名称“填写公司名字\n4.在”帐号“处填写公司在该银行的帐号\n5.”凭证名称“处填写领用凭证的名称\n6.”经领人身份证件号码“填写办理人的身份证号码\n7.”经领人签收“处写办理人姓名\n8.办理人需带个人身份证\n9.带公司”三联章“公司全称，帐号，开户银行”', NULL, b'10000000', NULL, '人事部', 4, 0, 10, '', '空白凭证领用方法', NULL, '2013-01-07', 'wendy', 'V-1.0', 1, '0002'),
	(10, '', '2013-01-08', '办理兴业银行转账事物', NULL, b'10000000', NULL, 'IT部', 4, 0, 10, '', '兴业银行转账', NULL, '2013-01-08', 'james', 'V-1.0', 1, '01'),
	(11, '', '2013-01-25', '1.字体的选择应当一致，标题和内容选择不同大小或者字体，这样看起来就更加清晰、有条理。\n2.PPT内容尽量文字简练，少而精\n3.多用图片进行描述说明\n4.每张PPT最好有题目标识\n5.如果有需要将英文翻译成中文时。\na、MSN询问Roger确认之后再打上去。\nb、直接不要填写。\n6.如果遇到图中有文字的部分，则需要打字上去。\n7.内容可以等比缩小放在PPT中。', NULL, b'10000000', NULL, '人事部', 4, 0, 10, '', '关于制作PPT需要注意的事项', NULL, '2013-01-25', 'wendy', 'V-1.0', 7, '0003'),
	(12, '', '2013-01-25', '1、每个月21号将roger的应收应付款整理并核对，模板在共享文件-SQE人员-SQE12-Roger相关文件- Roger资料安排- DQS-每月应收应付款明细。\n2、整理好后将表格复制粘贴到邮件中，发给Roger，抄送相关负责人。\n3、应收应付款计算时间由上个月的21日到这个月的20日算作一个月。\n4、及时查看邮件Roger确认后新建转发给Elaine\n5、	Elaine确认没有问题后开税。\n6、确认无误后将抵税的发票与税单联寄给DQS公司\n7、填写快递海航天天快递。收件人：丁一君 电话号码：62895083-19 地址：延安中路841号东方海外大厦1702B\n8、邮件告知收件人快递单号。抄送给Roger。\n9、隔天确认快递是否收到。\n10、每个月初需要将整理好的资料寄给记账公司包含（转账的小票、税控卡、工资单、抵税发票、发票记账联）地址：上海市闵行区碧泉路36弄1号楼金宵大楼301室，王叶佩：021-54178031-8019.', NULL, b'10000000', NULL, '人事部', 4, 0, 10, '', '关于财务方面的需要注意的事项', NULL, '2013-01-25', 'wendy', 'V-1.0', 7, '0004'),
	(13, '', '2013-01-25', '1、将资料的基本信息填进去，邮件发送给相关负责人,模板在共享文件-SQE人员-SQE12-Roger相关文件- Roger资料安排-Audit。\n2、邮件中写明：此资料需要对方核对后确认无误打印一份盖章；将此资料扫描后邮件发给本公司确认；再得到本公司确认后将资料再次打印两份盖章。最后将打印并盖章后的三份资料寄到本公司。\n3、邮件中不能体现本公司的logo需要将此标志删除。\n4、邮件发送完毕后电话联系该负责人，并告知此事。\n5、收到寄回的资料后将此信息填入到总表中，总表中体现了资料发出的时间与收到资料的时间。\n6、总表在每月3日以附件的形式发送。\n7、每个CCAA资料word档需要名称：CCAA_公司名_审核的起始时间 _审核的天数。\n8、邮件称呼名不能写的太小，对顾客要有起码的尊重。', NULL, b'10000000', NULL, 'IT部', 4, 0, 10, '', '关于CCAA资料需要注意的事项', '2013-03-13', '2013-01-25', 'sqe_ole', 'V-1.1', 7, '0005'),
	(14, 'ec7455cd7dc04bedb3f9f994585577f7.flv', '2013-02-25', '视频1  教程', NULL, b'10000000', NULL, 'IT部', 5, 0, 0, '', '视频1  教程', NULL, '2013-02-25', 'sqe_ole', 'V-1.0', 5, '2132'),
	(15, '8a7181e7c20344dda276471a84588ce8.flv', '2013-02-25', '视频2  教程', NULL, b'10000000', NULL, 'IT部', 5, 0, 0, '', '视频2 教程', NULL, '2013-02-25', 'sqe_ole', 'V-1.0', 7, '2133'),
	(16, 'ec7455cd7dc04bedb3f9f99458557727.flv', '2013-02-26', '新视频3新视频3', NULL, b'10000000', NULL, 'IT部', 5, 0, 0, '', '新视频3', '2013-02-26', '2013-02-26', 'sqe_ole', 'V-1.1', 7, '2321'),
	(17, '8a7181e7c20344dda276471a84588ce8.flv', '2013-02-26', '新视频4', NULL, b'10000000', NULL, 'IT部', 5, 0, 0, '', '新视频4', '2013-02-26', '2013-02-26', 'sqe_ole', 'V-1.2', 7, '2322'),
	(18, 'ec7455cd7dc04bedb3f9f99458557727.flv', '2013-02-26', '视频5', NULL, b'10000000', NULL, 'IT部', 5, 0, 0, '', '视频5', '2013-02-26', '2013-02-26', 'sqe_ole', 'V-1.3', 7, '2313'),
	(19, '8baa469e4d98493d88706698af6a6c62.doc', '2013-03-14', 'sqe_ole心得最近添加于2013-03-14', NULL, b'10000000', NULL, '', 3, 0, 0, NULL, 'sqe_ole最近心得', NULL, '2013-03-14', 'sqe_ole', 'V-1.0', NULL, NULL),
	(20, 'e46f3eaaeb7340d4a95d6b46b439d2a1.doc', '2013-03-14', 'sherry最近心得最近添加于2013-03-14', NULL, b'10000000', NULL, 'IT部', 3, 0, 0, NULL, 'sherry最近心得', '2013-03-15', '2013-03-15', 'sqe_ole', 'V-1.3', NULL, NULL),
	(21, '', '2013-03-15', '管理管理管理', NULL, b'10000000', NULL, 'IT部', 1, 0, 0, NULL, '管理', NULL, '2013-03-15', 'sqe_ole', 'V-1.0', 8, '0021'),
	(22, '508fc4830db44965ac27d3e268f6e03b.doc', '2013-03-15', '11月份账单', NULL, b'10000000', NULL, 'IT部', 3, 0, 0, NULL, '11月份账单', '2013-03-15', '2013-03-15', 'sqe_ole', 'V-1.7', 4, '00123'),
	(23, '', '2013-03-15', '', NULL, b'10000000', NULL, 'IT部', 3, 0, 0, NULL, '添加任务', NULL, '2013-03-15', 'sqe_ole', 'V-1.0', 7, '0021'),
	(24, '', '2013-03-15', 'MySql文档', NULL, b'10000000', NULL, 'IT部', 2, 0, 0, NULL, 'MySql文档', NULL, '2013-03-15', 'sqe_ole', 'V-1.0', 7, '00052'),
	(25, '', '2013-03-15', 'J2EE文档API', NULL, b'10000000', NULL, 'IT部', 3, 0, 0, NULL, 'J2EE文档API', NULL, '2013-03-15', 'sqe_ole', 'V-1.0', 6, '00212'),
	(26, '', '2013-03-26', '你来进一步了解一下系统！', NULL, b'10000000', NULL, 'IT部', 0, 0, 0, NULL, '新来名字', NULL, '2013-03-26', 'sqe_ole', 'V-1.0', 7, '0021');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.responsibility: ~24 rows (approximately)
/*!40000 ALTER TABLE `responsibility` DISABLE KEYS */;
INSERT INTO `responsibility` (`id`, `explanation`, `funcode`, `name`, `parentid`) VALUES
	(7, '负责公司项目的立项、需要设计、资源分配等', 'F2_0', '项目管理', NULL),
	(8, '跟踪项目成员的最新进度', 'F2_1', '开发进度追踪', 7),
	(9, '所有项目的需求分析设计文档', 'F2_2', '需求分析设计文档', 7),
	(10, '确定分歧问题，定案解决思路', 'F2_3', '项目研讨定案', 7),
	(11, '根据需求档编写开发文档', 'F2_4', '编写开发文档', 7),
	(12, '为项目成员解决技术难点', 'F2_5', '技术疑难解决', 7),
	(13, '负责公司账务、税费、日常收支等 管理', 'F3_0', '账务、税费收支管理', NULL),
	(14, '公司所涉及的税收、应缴税款', 'F3_1', '税费统计结算', 13),
	(15, '员工薪酬统计，奖金结算', 'F3_2', '薪酬奖金统计', 13),
	(16, '公司内部的日常', 'F3_3', '日常收支', 13),
	(17, '员工的差旅收支结算', 'F3_4', '差旅结算', 13),
	(18, '所有公司往来账务统计、结算、收支', 'F3_5', '业务帐务', 13),
	(19, 'UI图片的PS、DW设计制作', 'F4_0', 'UI设计制作', NULL),
	(20, '按需求制作UI版面', 'F4_1', 'UI版面制作', 19),
	(21, '按W3C业界标准优化或整合图片', 'F4_2', 'WEB图片优化', 19),
	(22, '按W3C标准优化页面布局', 'F4_3', 'CSS样式优化', 19),
	(23, '按需求PS或其他工具制作UI图片', 'F4_4', 'UI图片制作', 19),
	(24, '所涉及的界面图片设计', 'F4_5', 'UI图片或版面设计', 19),
	(25, '所有涉及开发编码的程序开发工作', 'F1_0', '程序开发', NULL),
	(26, '对需求分析并编写开发文档', 'F1_1', '文档编写', 25),
	(27, '程序的测试（包括单元、集成，压力等所有测试）', 'F1_2', '程序测试', 25),
	(28, '功能的代码编写实现', 'F1_3', '编码开发', 25),
	(29, '对编写程序的再修改或变更', 'F1_4', '程序DEBUG', 25),
	(30, '最终用户UI的白盒测试', 'F1_5', '页面测试', 25);
/*!40000 ALTER TABLE `responsibility` ENABLE KEYS */;


-- Dumping structure for table gom.signature
CREATE TABLE IF NOT EXISTS `signature` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stext` varchar(2000) DEFAULT NULL,
  `user_signature_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB76FB8981942EAEE` (`user_signature_fk`),
  CONSTRAINT `FKB76FB8981942EAEE` FOREIGN KEY (`user_signature_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.signature: ~5 rows (approximately)
/*!40000 ALTER TABLE `signature` DISABLE KEYS */;
INSERT INTO `signature` (`id`, `stext`, `user_signature_fk`) VALUES
	(1, '<div class="signiture">\r\n	<h3>\r\n		Best Regards\r\n	</h3>\r\n	<h3>\r\n		admin(管理员)\r\n	</h3>\r\n	<table class="ke-zeroborder" border="0" cellspacing="0" cellpadding="0" width="519">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan="2" width="119">\r\n					<img alt="LOGO" src="http://localhost:88/gom/images/sqe_logo.png" width="119" height="45" />\r\n				</td>\r\n				<td width="240">\r\n					<b>TEL:</b> +8621-50499035 ext. 17\r\n				</td>\r\n				<td width="160">\r\n					<b>FAX:</b> +8621-50499037\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td>\r\n					<b>EMAIL:</b> gom-admin@sqeservice.com\r\n				</td>\r\n				<td>\r\n					<b>WEB:</b><a href="http://www.sqeservice.com">www.sqeservice.com</a>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p>\r\n		GOM_v3.0 Copyright&copy;2005-2013 上海实名信息科技有限公司 SQE SERVICE 版权所有\r\n	</p>\r\n</div>', 1),
	(2, '', 2),
	(3, '', 3),
	(4, '<div class="signiture">\r\n	<h3>\r\n		Best Regards\r\n	</h3>\r\n	<h3>\r\n		sqe_ole(欧阳智成)\r\n	</h3>\r\n	<table class="ke-zeroborder" border="0" cellpadding="0" cellspacing="0" width="519">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan="2" width="119">\r\n					<img src="http://localhost:88/gom/images/sqe_logo.png" alt="LOGO" height="45" width="119" />\r\n				</td>\r\n				<td width="240">\r\n					<b>TEL:</b> +8621-50499035 ext. 15\r\n				</td>\r\n				<td width="160">\r\n					<b>FAX:</b> +8621-50499037\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td>\r\n					<b>EMAIL:</b> sqegom2@126.com\r\n				</td>\r\n				<td>\r\n					<b>WEB:</b><a href="http://http://www.sqeservice.com">http://www.sqeservice.com</a>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p>\r\n		GOM_v3.0 Copyright&copy;2005-2013 上海实名信息科技有限公司 SQE SERVICE 版权所有\r\n	</p>\r\n</div>', 4),
	(5, '<div class="signiture">\r\n	<h3>\r\n		Best Regards\r\n	</h3>\r\n	<h3>\r\n		wendy(陶文秀)\r\n	</h3>\r\n	<table class="ke-zeroborder" border="0" cellpadding="0" cellspacing="0" width="519">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan="2" width="119">\r\n					<img src="http://localhost:88/gom/images/sqe_logo.png" alt="LOGO" height="45" width="119" />\r\n				</td>\r\n				<td width="240">\r\n					<b>TEL:</b> +8621-50499035 ext. 17\r\n				</td>\r\n				<td width="160">\r\n					<b>FAX:</b> +8621-50499037\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td>\r\n					<b>EMAIL:</b> sqe_wendy@sqeservice.com\r\n				</td>\r\n				<td>\r\n					<b>WEB:</b><a href="http://www.sqeservice.com">www.sqeservice.com</a>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p>\r\n		GOM_v3.0 Copyright&copy;2005-2013 上海实名信息科技有限公司 SQE SERVICE 版权所有\r\n	</p>\r\n</div>', 5);
/*!40000 ALTER TABLE `signature` ENABLE KEYS */;


-- Dumping structure for table gom.statistics
CREATE TABLE IF NOT EXISTS `statistics` (
  `data` float DEFAULT NULL,
  `item` tinyint(4) DEFAULT NULL,
  `dated` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.statistics: ~0 rows (approximately)
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;


-- Dumping structure for table gom.summary
CREATE TABLE IF NOT EXISTS `summary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` float DEFAULT NULL,
  `dateMark` tinyint(4) DEFAULT NULL,
  `dated` date DEFAULT NULL,
  `config_summarys_fk` int(10) unsigned DEFAULT NULL,
  `user_summarys_fk` int(10) unsigned DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF47F3F86373AA707` (`config_summarys_fk`),
  KEY `FKF47F3F86FCA3B91` (`user_summarys_fk`),
  CONSTRAINT `FKF47F3F86373AA707` FOREIGN KEY (`config_summarys_fk`) REFERENCES `swotconfig` (`id`),
  CONSTRAINT `FKF47F3F86FCA3B91` FOREIGN KEY (`user_summarys_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=653 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.summary: ~621 rows (approximately)
/*!40000 ALTER TABLE `summary` DISABLE KEYS */;
INSERT INTO `summary` (`id`, `data`, `dateMark`, `dated`, `config_summarys_fk`, `user_summarys_fk`, `week`) VALUES
	(1, 20, 0, '2012-11-10', 3, 4, NULL),
	(2, 12, 0, '2012-11-11', 3, 4, NULL),
	(3, 27, 0, '2012-11-12', 3, 4, NULL),
	(4, 15, 0, '2012-11-13', 3, 4, NULL),
	(5, 17, 0, '2012-11-14', 3, 4, NULL),
	(6, 18, 2, '2012-11-15', 3, 4, NULL),
	(7, 20, 0, '2012-11-16', 3, 4, NULL),
	(8, 16, 0, '2012-11-17', 3, 4, NULL),
	(9, 20, 0, '2012-11-18', 3, 4, NULL),
	(10, 20, 0, '2012-11-19', 3, 4, NULL),
	(11, 17, 0, '2012-11-20', 3, 4, NULL),
	(12, 12, 0, '2012-11-21', 3, 4, NULL),
	(13, 20, 0, '2012-11-22', 3, 4, NULL),
	(14, 20, 0, '2012-11-23', 3, 4, NULL),
	(15, 18, 0, '2012-11-24', 3, 4, NULL),
	(16, 20, 0, '2012-11-25', 3, 4, NULL),
	(17, 8, 0, '2012-11-26', 3, 4, NULL),
	(23, 20, 0, '2012-11-26', 3, 4, NULL),
	(24, 48, 0, '2012-11-26', 3, 4, NULL),
	(25, 20, 0, '2012-11-27', 3, 4, NULL),
	(26, 20, 0, '2012-11-29', 3, 4, NULL),
	(27, 20, 0, '2012-11-30', 3, 4, NULL),
	(28, 5, 0, '2012-12-01', 3, 4, NULL),
	(29, 20, 0, '2012-12-02', 3, 4, NULL),
	(30, 12, 0, '2012-12-03', 3, 4, NULL),
	(31, 20, 0, '2012-12-04', 3, 4, NULL),
	(32, 20, 0, '2012-12-05', 3, 4, NULL),
	(33, 9, 0, '2012-12-06', 3, 4, NULL),
	(34, 20, 0, '2012-12-01', 1, 4, NULL),
	(35, 9, 0, '2012-12-02', 1, 4, NULL),
	(36, 20, 0, '2012-12-03', 1, 4, NULL),
	(37, 15, 0, '2012-12-04', 1, 4, NULL),
	(38, 20, 0, '2012-12-05', 1, 4, NULL),
	(39, 9, 0, '2012-12-06', 1, 4, NULL),
	(40, 20, 0, '2012-12-07', 1, 4, NULL),
	(41, 20, 0, '2011-12-08', 1, 4, NULL),
	(42, 9, 0, '2012-12-09', 1, 4, NULL),
	(43, 20, 0, '2012-12-10', 1, 4, NULL),
	(44, 20, 0, '2012-12-11', 1, 4, NULL),
	(45, 9, 0, '2012-12-12', 1, 4, NULL),
	(46, 20, 0, '2012-12-13', 1, 4, NULL),
	(47, 9, 0, '2012-12-14', 1, 4, NULL),
	(48, 9, 0, '2012-12-15', 1, 4, NULL),
	(49, 20, 0, '2012-12-16', 1, 4, NULL),
	(50, 16, 0, '2012-12-17', 1, 4, NULL),
	(51, 20, 0, '2012-12-18', 1, 4, NULL),
	(52, 12, 0, '2012-12-19', 1, 4, NULL),
	(53, 20, 0, '2012-12-20', 1, 4, NULL),
	(54, 20, 0, '2012-12-21', 1, 4, NULL),
	(55, 14, 0, '2012-12-22', 1, 4, NULL),
	(56, 15, 0, '2012-12-23', 1, 4, NULL),
	(68, 20, 0, '2012-12-24', 1, 4, NULL),
	(69, 12, 0, '2012-12-25', 1, 4, NULL),
	(70, 20, 0, '2012-12-26', 1, 4, NULL),
	(71, 20, 0, '2012-12-27', 1, 4, NULL),
	(72, 14, 0, '2012-12-28', 1, 4, NULL),
	(73, 20, 0, '2012-12-29', 1, 4, NULL),
	(74, 14, 0, '2012-12-30', 1, 4, NULL),
	(75, 20, 0, '2012-12-31', 1, 4, NULL),
	(76, 20, 0, '2013-01-01', 1, 4, NULL),
	(77, 14, 0, '2012-12-22', 3, 2, NULL),
	(78, 20, 0, '2013-01-02', 1, 4, NULL),
	(79, 14, 0, '2013-01-03', 1, 4, NULL),
	(80, 20, 0, '2013-01-04', 1, 4, NULL),
	(81, 20, 0, '2013-01-05', 1, 4, NULL),
	(82, 14, 0, '2013-01-01', 2, 4, NULL),
	(83, 20, 0, '2013-01-02', 2, 4, NULL),
	(84, 14, 0, '2013-01-03', 2, 4, NULL),
	(85, 20, 0, '2013-01-04', 2, 4, NULL),
	(86, 14, 0, '2013-01-05', 2, 4, NULL),
	(87, 20, 0, '2012-12-27', 2, 4, NULL),
	(88, 14, 0, '2012-12-28', 2, 4, NULL),
	(89, 20, 0, '2012-12-29', 2, 4, NULL),
	(90, 14, 0, '2012-12-22', 3, 5, NULL),
	(91, 20, 0, '2012-12-30', 2, 4, NULL),
	(92, 20, 0, '2012-12-31', 2, 4, NULL),
	(93, 14, 0, '2012-12-26', 2, 4, NULL),
	(94, 14, 0, '2012-12-25', 2, 4, NULL),
	(95, 20, 0, '2012-12-24', 2, 4, NULL),
	(96, 14, 0, '2012-12-23', 2, 4, NULL),
	(97, 20, 0, '2012-12-24', 3, 2, NULL),
	(98, 20, 0, '2012-12-24', 3, 2, NULL),
	(99, 20, 0, '2012-12-22', 2, 4, NULL),
	(100, 20, 0, '2012-12-24', 3, 3, NULL),
	(101, 20, 0, '2012-12-21', 2, 4, NULL),
	(102, 20, 0, '2012-12-25', 3, 3, NULL),
	(103, 14, 0, '2012-12-20', 2, 4, NULL),
	(104, 14, 0, '2012-12-19', 2, 4, NULL),
	(105, 20, 2, '2012-12-18', 2, 4, NULL),
	(106, 14, 0, '2012-12-17', 2, 4, NULL),
	(107, 20, 0, '2012-12-16', 2, 4, NULL),
	(108, 14, 0, '2012-12-15', 2, 4, NULL),
	(109, 20, 0, '2012-12-14', 2, 4, NULL),
	(110, 14, 0, '2012-12-12', 2, 4, NULL),
	(111, 20, 0, '2012-12-11', 2, 4, NULL),
	(112, 20, 0, '2012-12-08', 2, 4, NULL),
	(113, 14, 0, '2012-12-06', 2, 4, NULL),
	(114, 14, 0, '2012-12-05', 2, 4, NULL),
	(115, 20, 0, '2012-12-04', 2, 4, NULL),
	(116, 20, 0, '2012-12-03', 2, 4, NULL),
	(117, 20, 0, '2012-12-02', 2, 4, NULL),
	(118, 20, 0, '2012-12-01', 2, 4, NULL),
	(134, 20, 0, '2012-12-25', 3, 3, NULL),
	(135, 20, 0, '2012-12-25', 3, 2, NULL),
	(136, 12, 0, '2012-12-25', 3, 3, NULL),
	(137, 1, 0, '2012-12-25', 2, 3, NULL),
	(143, 20, 0, '2012-12-26', 3, 2, NULL),
	(144, 20, 0, '2012-12-26', 3, 3, NULL),
	(146, 12, 0, '2012-12-26', 3, 3, NULL),
	(147, 0.2, 0, '2012-12-26', 2, 3, NULL),
	(148, 12, 0, '2012-12-26', 3, 3, NULL),
	(149, 0.2, 0, '2012-12-26', 2, 3, NULL),
	(150, 1, 0, '2012-12-26', 3, 3, NULL),
	(151, 0, 0, '2012-12-26', 2, 3, NULL),
	(153, 20, 0, '2012-12-26', 3, 5, NULL),
	(157, 20, 0, '2012-12-27', 3, 2, NULL),
	(159, 20, 0, '2012-12-27', 3, 5, NULL),
	(161, 20, 0, '2012-12-28', 3, 2, NULL),
	(162, 1, 0, '2012-12-18', 7, 2, NULL),
	(168, 20, 0, '2012-12-28', 3, 2, NULL),
	(170, 20, 0, '2012-12-28', 3, 3, NULL),
	(171, 24, 0, '2012-12-28', 3, 3, NULL),
	(172, 20, 0, '2012-12-28', 2, 3, NULL),
	(173, 1, 0, '2012-12-28', 8, 3, NULL),
	(174, 2, 0, '2012-12-28', 3, 3, NULL),
	(175, 20, 0, '2012-12-28', 2, 3, NULL),
	(176, 11, 0, '2012-12-28', 3, 3, NULL),
	(177, 47.2, 0, '2012-12-28', 2, 3, NULL),
	(178, 23, 0, '2012-12-28', 3, 3, NULL),
	(179, 47.2, 0, '2012-12-28', 2, 3, NULL),
	(180, 12, 0, '2012-12-28', 3, 3, NULL),
	(181, 20, 0, '2012-12-28', 2, 3, NULL),
	(182, 1, 0, '2012-12-28', 8, 3, NULL),
	(183, 20, 0, '2012-12-28', 3, 5, NULL),
	(186, 20, 0, '2012-12-29', 3, 5, NULL),
	(187, 20, 0, '2012-12-29', 3, 2, NULL),
	(188, 20, 0, '2012-12-29', 3, 3, NULL),
	(189, 1, 0, '2012-12-29', 3, 3, NULL),
	(190, 18, 0, '2012-12-29', 2, 3, NULL),
	(193, 20, 0, '2012-12-31', 3, 5, NULL),
	(195, 20, 0, '2012-12-31', 3, 3, NULL),
	(196, 20, 0, '2012-12-31', 3, 2, NULL),
	(197, 1, 0, '2012-12-31', 3, 2, NULL),
	(198, 0, 0, '2012-12-31', 2, 2, NULL),
	(199, 12, 0, '2012-12-31', 3, 2, NULL),
	(200, 0.1, 0, '2012-12-31', 2, 2, NULL),
	(201, 1, 0, '2012-12-31', 8, 2, NULL),
	(202, 12, 0, '2012-12-31', 3, 3, NULL),
	(203, 1.3, 0, '2012-12-31', 2, 3, NULL),
	(204, 1, 0, '2012-12-31', 3, 2, NULL),
	(205, 0.2, 0, '2012-12-31', 2, 2, NULL),
	(206, 2, 0, '2012-12-31', 3, 2, NULL),
	(207, 0.2, 0, '2012-12-31', 2, 2, NULL),
	(208, 2, 0, '2012-12-31', 3, 3, NULL),
	(209, 0.2, 0, '2012-12-31', 2, 3, NULL),
	(210, 2, 0, '2012-12-31', 3, 3, NULL),
	(211, 0.2, 0, '2012-12-31', 2, 3, NULL),
	(212, 2, 0, '2012-12-31', 3, 3, NULL),
	(213, 0.3, 0, '2012-12-31', 2, 3, NULL),
	(214, 1, 0, '2012-12-25', 7, 5, NULL),
	(216, 20, 0, '2013-01-02', 3, 5, NULL),
	(226, 20, 0, '2013-01-02', 3, 2, NULL),
	(228, 1, NULL, '2013-01-02', 3, 2, NULL),
	(229, 0, NULL, '2013-01-02', 2, 2, NULL),
	(231, 20, NULL, '2013-01-03', 3, 5, NULL),
	(233, 20, NULL, '2013-01-03', 3, 3, NULL),
	(234, 20, NULL, '2013-01-03', 3, 2, NULL),
	(235, 23, NULL, '2013-01-03', 3, 3, NULL),
	(236, 20, NULL, '2013-01-03', 2, 3, NULL),
	(238, 20, NULL, '2013-01-04', 3, 5, NULL),
	(240, 20, NULL, '2013-01-04', 3, 2, NULL),
	(241, 1, NULL, '2013-01-04', 4, 2, NULL),
	(242, 20, NULL, '2013-01-04', 3, 3, NULL),
	(243, 1, NULL, '2013-01-04', 4, 5, NULL),
	(244, 12, NULL, '2013-01-04', 1, 2, NULL),
	(245, 47.7, NULL, '2013-01-04', 2, 2, NULL),
	(246, 12, NULL, '2013-01-04', 1, 2, NULL),
	(247, 47.7, NULL, '2013-01-04', 2, 2, NULL),
	(249, 1, NULL, '2013-01-05', 6, 5, NULL),
	(250, 1, NULL, '2013-01-05', 7, 5, NULL),
	(251, 1, NULL, '2013-01-05', 7, 5, NULL),
	(257, 1, NULL, '2013-01-05', 6, 1, NULL),
	(261, 1, NULL, '2013-01-05', 7, 1, NULL),
	(263, 1, NULL, '2013-01-05', 6, 2, NULL),
	(264, 1, NULL, '2013-01-05', 2, 5, NULL),
	(265, 0.3, NULL, '2013-01-05', 3, 5, NULL),
	(266, 1, NULL, '2013-01-05', 8, 5, NULL),
	(267, 1, NULL, '2013-01-05', 6, 3, NULL),
	(268, 12, NULL, '2013-01-05', 2, 2, NULL),
	(269, 0.1, NULL, '2013-01-05', 3, 2, NULL),
	(270, 1, NULL, '2013-01-05', 8, 2, NULL),
	(272, 1, NULL, '2013-01-07', 6, 5, NULL),
	(273, 1, NULL, '2013-01-07', 6, 1, NULL),
	(274, 1, NULL, '2013-01-07', 6, 3, NULL),
	(276, 1, NULL, '2013-01-07', 6, 2, NULL),
	(277, 4, NULL, '2013-01-07', 2, 3, NULL),
	(278, 1.5, NULL, '2013-01-07', 3, 3, NULL),
	(279, 12, NULL, '2013-01-07', 2, 3, NULL),
	(280, 1.5, NULL, '2013-01-07', 3, 3, NULL),
	(282, 1, NULL, '2013-01-08', 6, 5, NULL),
	(283, 1, NULL, '2013-01-08', 6, 1, NULL),
	(284, 1, NULL, '2013-01-08', 6, 3, NULL),
	(285, 1, NULL, '2013-01-08', 2, 3, NULL),
	(286, 86.2, NULL, '2013-01-08', 3, 3, NULL),
	(287, 1, NULL, '2013-01-08', 6, 2, NULL),
	(288, 12, NULL, '2013-01-08', 2, 2, NULL),
	(289, 96.1, NULL, '2013-01-08', 3, 2, NULL),
	(290, 12, NULL, '2013-01-08', 2, 2, NULL),
	(291, 70.6, NULL, '2013-01-08', 3, 2, NULL),
	(326, 1, NULL, '2013-01-09', 6, 3, NULL),
	(327, 12, NULL, '2013-01-09', 2, 3, NULL),
	(328, 0, NULL, '2013-01-09', 3, 3, NULL),
	(329, 1, NULL, '2013-01-09', 6, 2, NULL),
	(330, 1, NULL, '2013-01-10', 6, 5, NULL),
	(339, 1, NULL, '2012-12-24', 6, 4, NULL),
	(353, 1, NULL, '2012-12-27', 6, 4, NULL),
	(354, 1, NULL, '2012-12-28', 6, 4, NULL),
	(355, 1, NULL, '2013-01-02', 6, 4, NULL),
	(360, 1, NULL, '2013-01-10', 6, 1, NULL),
	(362, 1, NULL, '2013-01-10', 6, 3, NULL),
	(363, 12, NULL, '2013-01-10', 2, 3, NULL),
	(364, 0.1, NULL, '2013-01-10', 3, 3, NULL),
	(365, 1, NULL, '2013-01-11', 6, 5, NULL),
	(369, 1, NULL, '2013-01-12', 6, 4, NULL),
	(372, 1, NULL, '2013-01-11', 6, 2, NULL),
	(373, 1, NULL, '2013-01-11', 6, 3, NULL),
	(374, 1, NULL, '2013-01-11', 6, 1, NULL),
	(375, 1, NULL, '2013-01-12', 6, 5, NULL),
	(376, 1, NULL, '2013-01-12', 6, 1, NULL),
	(377, 1, NULL, '2013-01-12', 6, 3, NULL),
	(378, 12, NULL, '2013-01-12', 2, 3, NULL),
	(379, 34.6, NULL, '2013-01-12', 3, 3, NULL),
	(380, 34.6, NULL, '2013-01-12', 1, 3, NULL),
	(381, 1, NULL, '2013-01-12', 8, 3, NULL),
	(382, 1, NULL, '2013-01-14', 6, 4, NULL),
	(383, 1, NULL, '2013-01-14', 6, 5, NULL),
	(384, 1, NULL, '2013-01-14', 6, 1, NULL),
	(385, 1, NULL, '2013-01-14', 6, 2, NULL),
	(386, 12, NULL, '2013-01-14', 2, 2, NULL),
	(387, 0, NULL, '2013-01-14', 3, 2, NULL),
	(388, 0, NULL, '2013-01-14', 1, 2, NULL),
	(389, 1, NULL, '2013-01-15', 6, 5, NULL),
	(390, 1, NULL, '2013-01-15', 6, 3, NULL),
	(391, 1, NULL, '2013-01-15', 6, 2, NULL),
	(392, 21, NULL, '2013-01-15', 2, 2, NULL),
	(393, 24.3, NULL, '2013-01-15', 3, 2, NULL),
	(394, 24.3, NULL, '2013-01-15', 1, 2, NULL),
	(395, 1, NULL, '2013-01-16', 6, 4, NULL),
	(396, 1, NULL, '2013-01-16', 6, 5, NULL),
	(397, 1, NULL, '2013-01-17', 6, 5, NULL),
	(398, 1, NULL, '2013-01-17', 6, 2, NULL),
	(399, 23, NULL, '2013-01-17', 2, 2, NULL),
	(400, 71.7, NULL, '2013-01-17', 3, 2, NULL),
	(401, 71.7, NULL, '2013-01-17', 1, 2, NULL),
	(402, 1, NULL, '2013-01-18', 6, 5, NULL),
	(403, 1, NULL, '2013-01-18', 6, 2, NULL),
	(404, 1, NULL, '2013-01-18', 6, 3, NULL),
	(405, 23, NULL, '2013-01-18', 2, 2, NULL),
	(406, 95.7, NULL, '2013-01-18', 3, 2, NULL),
	(407, 95.7, NULL, '2013-01-18', 1, 2, NULL),
	(408, 1, NULL, '2013-01-19', 6, 4, NULL),
	(409, 1, NULL, '2013-01-19', 6, 5, NULL),
	(410, 1, NULL, '2013-01-19', 6, 1, NULL),
	(411, 1, NULL, '2013-01-19', 6, 3, NULL),
	(412, 1, NULL, '2013-01-19', 6, 2, NULL),
	(413, 3, NULL, '2013-01-19', 2, 2, NULL),
	(414, 45.5, NULL, '2013-01-19', 3, 2, NULL),
	(415, 46.5, NULL, '2013-01-19', 1, 2, NULL),
	(416, 1, NULL, '2013-01-19', 2, 2, NULL),
	(417, 46.5, NULL, '2013-01-19', 3, 2, NULL),
	(418, 46.5, NULL, '2013-01-19', 1, 2, NULL),
	(419, 4, NULL, '2013-01-19', 2, 2, NULL),
	(420, 33.7, NULL, '2013-01-19', 3, 2, NULL),
	(421, 36.7, NULL, '2013-01-19', 1, 2, NULL),
	(422, 1, NULL, '2013-01-19', 2, 2, NULL),
	(423, 0.1, NULL, '2013-01-19', 3, 2, NULL),
	(424, 0.1, NULL, '2013-01-19', 1, 2, NULL),
	(425, 1, NULL, '2013-01-19', 7, 5, NULL),
	(426, 12, NULL, '2013-01-19', 27, 2, NULL),
	(427, 0, NULL, '2013-01-19', 28, 2, NULL),
	(428, 0, NULL, '2013-01-19', 1, 2, NULL),
	(429, 1, NULL, '2013-01-21', 31, 1, NULL),
	(430, 1, NULL, '2013-01-21', 31, 2, NULL),
	(431, 4, NULL, '2013-01-21', 27, 2, NULL),
	(432, 46.6, NULL, '2013-01-21', 28, 2, NULL),
	(433, 46.6, NULL, '2013-01-21', 1, 2, NULL),
	(434, 1, NULL, '2013-01-21', 31, 5, NULL),
	(435, 1, NULL, '2013-01-22', 31, 4, NULL),
	(436, 1, NULL, '2013-01-22', 31, 1, NULL),
	(437, 1, NULL, '2013-01-22', 31, 2, NULL),
	(438, 12, NULL, '2013-01-22', 27, 2, NULL),
	(439, 191.7, NULL, '2013-01-22', 28, 2, NULL),
	(440, 191.7, NULL, '2013-01-22', 1, 2, NULL),
	(441, 1, NULL, '2013-01-23', 31, 4, NULL),
	(442, 1, NULL, '2013-01-23', 31, 5, NULL),
	(443, 1, NULL, '2013-01-23', 31, 2, NULL),
	(444, 1, NULL, '2013-01-23', 31, 3, NULL),
	(445, 17.7, NULL, '2013-01-23', 28, 4, NULL),
	(446, 17.7, NULL, '2013-01-23', 1, 4, NULL),
	(447, 12, NULL, '2013-01-23', 27, 4, NULL),
	(448, 2, NULL, '2013-01-23', 27, 4, NULL),
	(449, 1, NULL, '2013-01-23', 31, 1, NULL),
	(450, 0.4, NULL, '2013-01-23', 28, 4, NULL),
	(451, 0.4, NULL, '2013-01-23', 1, 4, NULL),
	(452, 1, NULL, '2013-01-24', 31, 2, NULL),
	(453, 1, NULL, '2013-01-24', 31, 5, NULL),
	(454, 1, NULL, '2013-01-24', 31, 3, NULL),
	(455, 1, NULL, '2013-01-24', 31, 4, NULL),
	(456, 1, NULL, '2013-01-25', 31, 4, NULL),
	(457, 1, NULL, '2013-01-25', 31, 1, NULL),
	(458, 1, NULL, '2013-01-25', 31, 2, NULL),
	(459, 53, NULL, '2013-01-25', 28, 4, NULL),
	(460, 53, NULL, '2013-01-25', 1, 4, NULL),
	(461, 1, NULL, '2013-01-25', 33, 4, NULL),
	(462, 53.4, NULL, '2013-01-25', 28, 4, NULL),
	(463, 53.4, NULL, '2013-01-25', 1, 4, NULL),
	(464, 1, NULL, '2013-01-25', 33, 4, NULL),
	(465, 1, NULL, '2013-01-25', 31, 5, NULL),
	(466, 0, NULL, '2013-01-25', 28, 5, NULL),
	(467, 0, NULL, '2013-01-25', 1, 5, NULL),
	(468, 55.7, NULL, '2013-01-25', 28, 5, NULL),
	(469, 55.7, NULL, '2013-01-25', 1, 5, NULL),
	(470, 47.4, NULL, '2013-01-25', 28, 5, NULL),
	(471, 47.4, NULL, '2013-01-25', 1, 5, NULL),
	(472, 1, NULL, '2013-01-26', 31, 5, NULL),
	(473, 1, NULL, '2013-02-18', 31, 1, NULL),
	(474, 1, NULL, '2013-02-18', 31, 4, NULL),
	(475, 1, NULL, '2013-02-18', 31, 2, NULL),
	(476, 60.7, NULL, '2013-02-18', 28, 4, NULL),
	(477, 60.7, NULL, '2013-02-18', 1, 4, NULL),
	(478, 1, NULL, '2013-02-18', 33, 4, NULL),
	(479, 60.3, NULL, '2013-02-18', 28, 4, NULL),
	(480, 63.3, NULL, '2013-02-18', 1, 4, NULL),
	(481, 1, NULL, '2013-02-18', 33, 4, NULL),
	(482, 0, NULL, '2013-02-18', 28, 4, NULL),
	(483, 0, NULL, '2013-02-18', 1, 4, NULL),
	(484, 1, NULL, '2013-02-19', 31, 4, NULL),
	(485, 1, NULL, '2013-02-19', 31, 2, NULL),
	(486, 1, NULL, '2013-02-19', 31, 2, NULL),
	(487, 1, NULL, '2013-02-19', 31, 1, NULL),
	(488, 1, NULL, '2013-02-19', 31, 5, NULL),
	(489, 0, NULL, '2013-02-19', 28, 2, NULL),
	(490, 0, NULL, '2013-02-19', 1, 2, NULL),
	(491, 1, NULL, '2013-02-19', 31, 3, NULL),
	(492, 20, NULL, '2013-02-19', 27, 2, NULL),
	(493, 2, NULL, '2013-02-19', 27, 2, NULL),
	(494, 4, NULL, '2013-02-19', 27, 2, NULL),
	(495, 653.9, NULL, '2013-02-19', 28, 4, NULL),
	(496, 653.9, NULL, '2013-02-19', 1, 4, NULL),
	(497, 1, NULL, '2013-02-19', 33, 4, NULL),
	(498, 1, NULL, '2013-02-19', 32, 2, NULL),
	(499, 1, NULL, '2013-02-20', 31, 2, NULL),
	(500, 1, NULL, '2013-02-20', 31, 4, NULL),
	(501, 1, NULL, '2013-02-20', 31, 3, NULL),
	(502, 1, NULL, '2013-02-21', 31, 3, NULL),
	(503, 1, NULL, '2013-02-22', 31, 4, NULL),
	(504, 1, NULL, '2013-02-22', 31, 3, NULL),
	(505, 1, NULL, '2013-02-22', 31, 1, NULL),
	(506, 1, NULL, '2013-02-23', 31, 2, NULL),
	(507, 1, NULL, '2013-02-23', 31, 1, NULL),
	(508, 1, NULL, '2013-02-23', 31, 5, NULL),
	(509, 3, NULL, '2013-02-23', 29, 2, NULL),
	(510, 1, NULL, '2013-02-23', 31, 3, NULL),
	(511, 1, NULL, '2013-02-24', 31, 4, NULL),
	(512, 1, NULL, '2013-02-25', 31, 2, NULL),
	(513, 1, NULL, '2013-02-25', 31, 1, NULL),
	(514, 1, NULL, '2013-02-26', 31, 1, NULL),
	(515, 1, NULL, '2013-02-26', 31, 3, NULL),
	(516, 1, NULL, '2013-02-26', 31, 2, NULL),
	(517, 1, NULL, '2013-02-27', 31, 2, NULL),
	(518, 1, NULL, '2013-02-28', 31, 2, NULL),
	(519, 1, NULL, '2013-03-01', 31, 4, NULL),
	(520, 1, NULL, '2013-03-02', 31, 1, NULL),
	(521, 1, NULL, '2013-03-02', 31, 3, NULL),
	(522, 1, NULL, '2013-03-04', 31, 1, NULL),
	(523, 1, NULL, '2013-03-04', 31, 3, NULL),
	(524, 1, NULL, '2013-03-05', 31, 3, NULL),
	(525, 1, NULL, '2013-03-05', 31, 7, NULL),
	(526, 1, NULL, '2013-03-07', 31, 4, NULL),
	(527, 1, NULL, '2013-03-07', 31, 4, NULL),
	(528, 1, NULL, '2013-03-07', 32, 4, NULL),
	(529, 1, NULL, '2013-03-09', 31, 4, NULL),
	(530, 1, NULL, '2013-03-09', 31, 2, NULL),
	(531, 1, NULL, '2013-03-09', 31, 3, NULL),
	(532, 23, NULL, '2013-03-09', 27, 4, NULL),
	(533, 2.5, NULL, '2013-03-09', 27, 4, NULL),
	(534, 22, NULL, '2013-03-09', 27, 4, NULL),
	(535, 23, NULL, '2013-03-09', 27, 4, NULL),
	(536, 23, NULL, '2013-03-09', 27, 4, NULL),
	(537, 1, NULL, '2013-03-09', 31, 1, NULL),
	(538, 1, NULL, '2013-03-09', 31, 6, NULL),
	(539, 1, NULL, '2013-03-09', 31, 5, NULL),
	(540, 1, NULL, '2013-03-11', 31, 5, NULL),
	(541, 1, NULL, '2013-03-11', 31, 1, NULL),
	(542, 1, NULL, '2013-03-11', 31, 3, NULL),
	(543, 1, NULL, '2013-03-12', 31, 4, NULL),
	(544, 1, NULL, '2013-03-12', 31, 1, NULL),
	(545, 1, NULL, '2013-03-12', 31, 3, NULL),
	(546, 0, NULL, '2013-03-12', 28, 4, NULL),
	(547, 0, NULL, '2013-03-12', 1, 4, NULL),
	(548, 0.1, NULL, '2013-03-12', 28, 4, NULL),
	(549, 0.1, NULL, '2013-03-12', 1, 4, NULL),
	(550, 0, NULL, '2013-03-12', 28, 4, NULL),
	(551, 0, NULL, '2013-03-12', 1, 4, NULL),
	(552, 1, NULL, '2013-03-13', 31, 4, NULL),
	(553, 1, NULL, '2013-03-13', 31, 1, NULL),
	(554, 1, NULL, '2013-03-13', 31, 2, NULL),
	(555, 1, NULL, '2013-03-15', 31, 1, NULL),
	(556, 1, NULL, '2013-03-15', 31, 5, NULL),
	(557, 1, NULL, '2013-03-15', 31, 3, NULL),
	(558, 1, NULL, '2013-03-16', 31, 2, NULL),
	(559, 1, NULL, '2013-03-16', 31, 5, NULL),
	(560, 1, NULL, '2013-03-16', 31, 7, NULL),
	(561, 1, NULL, '2013-03-16', 31, 4, NULL),
	(562, 1, NULL, '2013-03-16', 31, 3, NULL),
	(563, 1, NULL, '2013-03-16', 31, 1, NULL),
	(564, 1, NULL, '2013-03-18', 31, 5, NULL),
	(565, 1, NULL, '2013-03-19', 31, 4, NULL),
	(566, 1, NULL, '2013-03-19', 31, 4, NULL),
	(567, 1, NULL, '2013-03-19', 31, 1, NULL),
	(568, 1, NULL, '2013-03-20', 31, 3, NULL),
	(569, 1, NULL, '2013-03-20', 31, 1, NULL),
	(570, 1, NULL, '2013-03-21', 31, 2, NULL),
	(571, 1, NULL, '2013-03-21', 31, 1, NULL),
	(572, 1, NULL, '2013-03-21', 31, 5, NULL),
	(573, 1, NULL, '2013-03-22', 31, 3, NULL),
	(574, 239.9, NULL, '2013-03-22', 28, 4, NULL),
	(575, 239.9, NULL, '2013-03-22', 1, 4, NULL),
	(576, 1, NULL, '2013-03-22', 33, 4, NULL),
	(577, 1, NULL, '2013-03-23', 31, 2, NULL),
	(578, 1, NULL, '2013-03-23', 31, 1, NULL),
	(579, 1, NULL, '2013-03-23', 31, 3, NULL),
	(580, 24.5, NULL, '2013-03-23', 28, 4, NULL),
	(581, 24.5, NULL, '2013-03-23', 1, 4, NULL),
	(582, 1, NULL, '2013-03-23', 33, 4, NULL),
	(583, 1, NULL, '2013-03-25', 31, 5, NULL),
	(584, 1, NULL, '2013-03-25', 31, 1, NULL),
	(585, 1, NULL, '2013-03-25', 31, 3, NULL),
	(586, 0, NULL, '2013-03-25', 28, 4, NULL),
	(587, 0, NULL, '2013-03-25', 1, 4, NULL),
	(588, 0.4, NULL, '2013-03-25', 28, 4, NULL),
	(589, 0.4, NULL, '2013-03-25', 1, 4, NULL),
	(590, 0.4, NULL, '2013-03-25', 28, 4, NULL),
	(591, 0.4, NULL, '2013-03-25', 1, 4, NULL),
	(592, 1, NULL, '2013-03-26', 31, 1, NULL),
	(593, 1, NULL, '2013-03-26', 31, 4, NULL),
	(594, 1, NULL, '2013-03-26', 31, 3, NULL),
	(595, 24.5, NULL, '2013-03-26', 28, 4, NULL),
	(596, 24.5, NULL, '2013-03-26', 1, 4, NULL),
	(597, 24.5, NULL, '2013-03-26', 28, 4, NULL),
	(598, 24.5, NULL, '2013-03-26', 1, 4, NULL),
	(599, 1, NULL, '2013-03-27', 31, 4, NULL),
	(600, 1, NULL, '2013-03-27', 31, 1, NULL),
	(601, 1, NULL, '2013-03-27', 31, 3, NULL),
	(602, 24.1, NULL, '2013-03-27', 28, 4, NULL),
	(603, 24.1, NULL, '2013-03-27', 1, 4, NULL),
	(604, 1, NULL, '2013-03-28', 31, 4, NULL),
	(605, 1, NULL, '2013-03-28', 31, 1, NULL),
	(606, 1, NULL, '2013-03-28', 31, 3, NULL),
	(607, 1, NULL, '2013-03-28', 31, 2, NULL),
	(608, 290.6, NULL, '2013-03-28', 28, 4, NULL),
	(609, 290.6, NULL, '2013-03-28', 1, 4, NULL),
	(610, 289.9, NULL, '2013-03-28', 28, 4, NULL),
	(611, 289.9, NULL, '2013-03-28', 1, 4, NULL),
	(612, 289.5, NULL, '2013-03-28', 28, 4, NULL),
	(613, 289.5, NULL, '2013-03-28', 1, 4, NULL),
	(614, 1, NULL, '2013-03-29', 31, 4, NULL),
	(615, 1, NULL, '2013-03-29', 31, 3, NULL),
	(616, 63.8, NULL, '2013-03-29', 28, 4, NULL),
	(617, 63.8, NULL, '2013-03-29', 1, 4, NULL),
	(618, 96.4, NULL, '2013-03-29', 28, 4, NULL),
	(619, 96.4, NULL, '2013-03-29', 1, 4, NULL),
	(620, 96.4, NULL, '2013-03-29', 28, 4, NULL),
	(621, 96.4, NULL, '2013-03-29', 1, 4, NULL),
	(622, 1, NULL, '2013-03-30', 31, 4, NULL),
	(623, 1, NULL, '2013-03-30', 31, 1, NULL),
	(624, 1, NULL, '2013-03-30', 31, 3, NULL),
	(625, 1, NULL, '2013-04-01', 31, 4, NULL),
	(626, 1, NULL, '2013-04-01', 31, 1, NULL),
	(627, 1, NULL, '2013-04-01', 31, 3, NULL),
	(628, 1, NULL, '2013-04-03', 31, 4, NULL),
	(629, 1, NULL, '2013-04-03', 31, 3, NULL),
	(630, 120, NULL, '2013-04-03', 28, 4, NULL),
	(631, 120, NULL, '2013-04-03', 1, 4, NULL),
	(632, 120, NULL, '2013-04-03', 28, 4, NULL),
	(633, 120, NULL, '2013-04-03', 1, 4, NULL),
	(634, 120, NULL, '2013-04-03', 28, 4, NULL),
	(635, 120, NULL, '2013-04-03', 1, 4, NULL),
	(636, 1, NULL, '2013-04-05', 31, 3, NULL),
	(637, 1, NULL, '2013-04-05', 31, 1, NULL),
	(638, 1, NULL, '2013-04-06', 32, 4, NULL),
	(639, 1, NULL, '2013-04-08', 31, 4, NULL),
	(640, 1, NULL, '2013-04-08', 31, 3, NULL),
	(641, 0.1, NULL, '2013-04-08', 28, 4, NULL),
	(642, 0.1, NULL, '2013-04-08', 1, 4, NULL),
	(643, 0.1, NULL, '2013-04-08', 28, 4, NULL),
	(644, 0.1, NULL, '2013-04-08', 1, 4, NULL),
	(645, 1, NULL, '2013-04-09', 31, 4, NULL),
	(646, 1, NULL, '2013-04-10', 31, 4, NULL),
	(647, 1, NULL, '2013-04-10', 31, 1, NULL),
	(648, 1, NULL, '2013-04-10', 31, 3, NULL),
	(649, 1, NULL, '2013-04-11', 31, 4, NULL),
	(650, 1, NULL, '2013-04-11', 31, 1, NULL),
	(651, 1, NULL, '2013-04-11', 32, 4, NULL),
	(652, 1, NULL, '2013-04-11', 31, 3, NULL);
/*!40000 ALTER TABLE `summary` ENABLE KEYS */;


-- Dumping structure for function gom.sum_item
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `sum_item`(in_range INT, in_date DATE, in_var INT, in_userId INT, in_item INT) RETURNS int(11)
BEGIN
	DECLARE l_sum INT;
	CASE in_range
	  WHEN 0 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.user_summarys_fk=in_userId AND s.dated=in_date;
	  WHEN 1 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.user_summarys_fk=in_userId AND WEEKOFYEAR(s.dated)=WEEKOFYEAR(DATE_SUB(in_date, INTERVAL in_var WEEK));
	  WHEN 2 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.user_summarys_fk=in_userId AND DATE_FORMAT(s.dated, '%Y-%m')=DATE_FORMAT(DATE_SUB(in_date, INTERVAL in_var MONTH), '%Y-%m');
	  WHEN 3 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.user_summarys_fk=in_userId AND s.dated>DATE_SUB(in_date, INTERVAL in_var+1 QUARTER) AND s.dated<=DATE_SUB(in_date, INTERVAL in_var QUARTER);
	  WHEN 4 THEN SELECT sum(s.data) INTO l_sum FROM summary s LEFT JOIN swotconfig c ON s.config_summarys_fk=c.id WHERE c.item=in_item AND s.user_summarys_fk=in_userId AND YEAR(s.dated)=YEAR(DATE_SUB(in_date, INTERVAL in_var YEAR));
	END CASE;
	RETURN l_sum;
END//
DELIMITER ;


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
  `item` tinyint(4) DEFAULT NULL,
  `lower` float NOT NULL,
  `upper` float NOT NULL,
  `date_range` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.swotconfig: ~32 rows (approximately)
/*!40000 ALTER TABLE `swotconfig` DISABLE KEYS */;
INSERT INTO `swotconfig` (`id`, `centerline`, `colorO`, `colorS`, `colorT`, `colorW`, `continuousChange`, `continuousDistanceGtOne`, `continuousDistanceLtOne`, `continuousSameSide`, `continuousStaggered`, `datum`, `datumO`, `datumS`, `datumT`, `datumW`, `distanceCenter`, `distanceGtOne`, `distanceGtTwo`, `improveTarget`, `isContinuousChange`, `isContinuousDistanceGtOne`, `isContinuousDistanceLtOne`, `isContinuousSameSide`, `isContinuousStaggered`, `isDistanceCenter`, `isDistanceGtOne`, `isDistanceGtTwo`, `method`, `model`, `tolerance`, `item`, `lower`, `upper`, `date_range`) VALUES
	(1, 12, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 0, 0, 24, 0),
	(2, 35, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 1, 0, 70, 1),
	(3, 35, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 2, 0, 72, 1),
	(4, 2, 'yellow', 'green', 'blue', 'red', 25, 25, 25, 25, 25, 4, 0, 0, 0, 0, 25, 25, 25, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 3, 0, 4, 1),
	(5, 2, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 4, 0, 4, 1),
	(6, 1, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 5, 0, 3, 1),
	(7, 1, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 6, 0, 3, 1),
	(8, 1, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 7, 0, 3, 1),
	(9, 140, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 0, 0, 280, 2),
	(10, 600, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 0, 0, 1200, 4),
	(11, 140, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 1, 0, 280, 2),
	(12, 500, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 1, 0, 1000, 4),
	(13, 140, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 2, 0, 280, 2),
	(14, 600, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 2, 0, 1200, 4),
	(15, 6, 'yellow', 'green', 'blue', 'red', 25, 25, 25, 25, 25, 4, 0, 0, 0, 0, 25, 25, 25, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 3, 0, 12, 2),
	(16, 12, 'yellow', 'green', 'blue', 'red', 25, 25, 25, 25, 25, 4, 0, 0, 0, 0, 25, 25, 25, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 3, 0, 24, 4),
	(17, 12, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 4, 2, 24, 2),
	(18, 12, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 4, 2, 24, 4),
	(19, 6, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 5, 1, 12, 2),
	(20, 12, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 5, 1, 25, 4),
	(21, 3, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 6, 0, 6, 2),
	(22, 6, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 6, 0, 12, 4),
	(23, 5, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 7, 0, 10, 2),
	(24, 6, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 7, 0, 12, 4),
	(25, 35, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 0, 0, 70, 1),
	(27, 8, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 1, 0, 11, 0),
	(28, 6, 'yellow', 'green', 'blue', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 2, 0, 12, 0),
	(29, 2, 'yellow', 'green', 'blue', 'red', 25, 25, 25, 25, 25, 4, 0, 0, 0, 0, 25, 25, 25, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 3, 0, 4, 0),
	(30, 2, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 4, 0, 4, 0),
	(31, 1, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 5, 0, 3, 0),
	(32, 2, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 6, 0, 4, 0),
	(33, 2, 'blue', 'green', 'yellow', 'red', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, 0, b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', b'00000000', 0, 0, NULL, 7, 0, 4, 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.task: ~89 rows (approximately)
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` (`id`, `actualEnd`, `actualHours`, `actualStart`, `assignor`, `completedRate`, `createDate`, `des`, `executor`, `expectedEnd`, `expectedHours`, `expectedStart`, `occupyRate`, `state`, `taskTitle`, `taskType`, `task_fixed_fk`, `task_project_fk`, `task_respon_fk`, `needHelp`, `needState`, `delay`) VALUES
	(20, '2012-12-31 15:10:36', 0.2, '2012-12-31 14:58:52', 'sherry', '100', '2013-01-01 15:10:24', '编写工作文档，每天的工作内容和工作安排！', 'sqe_ole', '2013-01-01 14:58:00', 1, '2012-12-31 14:58:00', NULL, 5, '编写工作文档', 0, 1, NULL, 8, NULL, NULL, NULL),
	(21, '2012-12-31 14:57:09', 1, '2012-12-31 14:56:06', 'sherry', '99', '2013-01-01 15:10:35', '打扫办公室和大厅', 'sqe_ole', '2013-01-01 14:55:00', 1, '2012-12-31 09:55:00', NULL, 3, '打扫办公室', 0, 2, NULL, 8, NULL, NULL, NULL),
	(22, '2012-12-31 13:33:01', 0, '2012-12-31 13:27:24', 'sherry', '0', '2012-12-31 13:26:15', '日报调整工作完成比率', 'sqe_ole', '2012-12-31 13:26:00', 0, '2012-12-31 09:26:00', NULL, 9, '日报调整', 1, NULL, 2, 8, NULL, NULL, '在'),
	(23, '2012-12-31 13:28:33', 0, '2012-12-31 13:27:56', 'sherry', '100', '2012-12-31 13:27:56', '登录的时候排除管理员发送早报', 'sqe_ole', '2012-12-31 13:27:00', 1, '2012-12-31 13:27:56', NULL, 5, '登录排除', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, '2012-12-31 14:57:44', 1.3, '2012-12-31 13:37:01', 'james', '100', '2012-12-31 13:37:01', '添加预览登录信息', 'sqe_ole', '2013-01-02 13:36:00', 12, '2012-12-31 13:37:01', NULL, 5, '预览登录信息', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(25, '2013-01-19 16:42:58', 13.9, '2012-12-31 16:13:46', 'sherry', '100', '2012-12-31 16:13:46', '缴黄老师137电话费291元', 'wendy', '2012-12-31 16:14:00', 3, '2012-12-31 16:13:46', NULL, 5, '缴电话费', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, '2013-01-19 16:43:06', 13.9, '2012-12-31 16:15:28', 'sherry', '100', '2012-12-31 16:15:28', '应收应付款发票：31500元', 'wendy', '2013-01-02 10:00:00', 1, '2012-12-31 16:15:28', NULL, 5, '打印发票', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(27, NULL, NULL, '2012-12-31 16:35:14', 'sherry', '0', '2012-12-31 16:35:14', '检查新版GOM运行是否正常', 'sherry', '2013-01-02 00:00:00', 4, '2012-12-31 16:35:14', NULL, 3, '测试新版GOM', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(28, '2012-12-31 16:48:02', 0.2, '2012-12-31 16:37:06', 'sherry', '100', '2012-12-31 16:37:06', '发送资料确认PMF中客户资料的正确性', 'sherry', '2013-01-02 15:00:00', 2, '2012-12-31 16:37:06', NULL, 5, '确认客户名单', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(29, '2012-12-31 17:18:14', 0, '2012-12-31 17:06:23', 'james', '0', '2012-12-31 17:04:17', '休假功能添加一页', 'sqe_ole', '2013-01-01 17:06:00', 0, '2012-12-31 17:06:00', NULL, 9, '休假功能', 0, 3, NULL, 8, NULL, NULL, NULL),
	(31, '2012-12-31 17:20:56', 0.2, '2012-12-31 17:06:23', 'james', '100', '2012-12-31 17:17:58', NULL, 'sqe_ole', '2013-01-01 17:06:00', 2, '2012-12-31 17:06:00', NULL, 5, '应收应付款', 0, 3, NULL, 8, NULL, NULL, NULL),
	(32, '2012-12-31 17:21:47', 0.3, '2012-12-31 17:06:23', 'james', '100', '2012-12-31 17:20:49', NULL, 'sqe_ole', '2013-01-01 17:06:00', 2, '2012-12-31 17:06:00', NULL, 5, '应收应付款', 0, 3, NULL, 8, NULL, NULL, NULL),
	(34, '2013-01-08 11:35:13', 13.9, '2012-12-31 17:26:06', 'james', '100', '2012-12-31 17:26:06', '异常批量操作', 'sqe_ole', '2013-01-02 17:26:00', 1, '2012-12-31 17:26:06', NULL, 5, '异常批量', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(35, '2013-01-03 16:31:34', 71.1, '2012-12-31 17:26:35', 'james', '100', '2012-12-31 17:26:35', '出勤统计按个人和管理人员的权限来查看', 'sqe_ole', '2013-01-03 17:26:00', 23, '2012-12-31 17:26:35', NULL, 5, '出勤统计', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(36, '2013-01-21 17:36:31', 13.9, '2013-01-02 10:59:45', 'sherry', '100', '2013-01-02 10:59:45', '测试GOM是否正常', 'wendy', '2013-01-02 14:00:00', 4, '2013-01-02 10:59:45', NULL, 5, '测试GOM', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(37, '2013-01-25 16:54:39', 13.9, '2013-01-02 15:10:28', 'sherry', '100', '2013-01-02 15:10:28', '检测新版GOM能否正常使用', 'wendy', '2013-01-02 00:00:00', 4, '2013-01-02 15:10:28', NULL, 5, '检测GOM', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(38, '2013-01-04 17:33:36', 13.9, '2013-01-02 17:49:52', 'sherry', '100', '2013-01-02 17:49:52', '编写出勤存储过程', 'sqe_ole', '2013-01-03 17:49:00', 12, '2013-01-02 17:49:52', NULL, 5, '编写出勤存储过程', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(39, '2013-01-04 17:33:41', 13.9, '2013-01-02 17:50:16', 'sherry', '100', '2013-01-02 17:50:16', '出勤页面逻辑', 'sqe_ole', '2013-01-04 17:50:00', 12, '2013-01-02 17:50:16', NULL, 5, '出勤页面逻辑', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(40, '2013-01-02 17:50:54', 0, '2013-01-02 17:50:44', 'sherry', '100', '2013-01-02 17:50:44', '修改个人中心', 'sqe_ole', '2013-01-02 17:50:00', 1, '2013-01-02 17:50:44', NULL, 5, '修改个人中心', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(41, '2013-01-05 19:04:08', 0.1, '2013-01-05 18:58:43', 'sherry', '100', '2013-01-03 16:01:19', '添加湿器2222', 'sqe_ole', '2013-01-04 16:02:00', 12, '2013-01-03 16:02:00', NULL, 5, '添加湿器', 1, NULL, 2, 8, NULL, NULL, '没有看到'),
	(42, '2013-01-07 17:42:07', 1.5, '2013-01-07 16:13:22', 'james', '100', '2013-01-04 16:06:12', '对GOM逐一检测', 'sqe_ole', '2013-01-08 16:13:00', 4, '2013-01-07 16:13:00', NULL, 5, '检测GOM', 1, NULL, 2, 11, NULL, NULL, NULL),
	(43, '2013-01-08 17:38:10', 13.9, '2013-01-04 17:34:44', 'sherry', '100', '2013-01-04 17:34:44', '存储过程文档写完', 'sqe_ole', '2013-01-05 17:34:00', 12, '2013-01-04 17:34:44', NULL, 5, '存储过程文档', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(44, NULL, NULL, NULL, 'sherry', '0', '2013-01-05 15:28:46', '整理应收应付款', NULL, NULL, 2, '2013-01-05 15:28:46', NULL, 1, '应收应付款', 0, 4, NULL, NULL, NULL, NULL, NULL),
	(45, '2013-01-05 16:07:31', 0.3, '2013-01-05 15:51:56', 'wendy', '100', '2013-01-05 15:30:15', '威孚 公司差旅费57', 'wendy', '2013-01-05 15:00:00', 1, '2013-01-05 14:00:00', NULL, 5, '差旅费', 1, NULL, 2, 17, NULL, NULL, '资料错误'),
	(46, '2013-01-19 16:43:15', 13.9, '2013-01-05 15:59:45', 'sherry', '100', '2013-01-05 15:59:45', '购买空白凭证', 'wendy', '2013-01-06 00:00:00', 4, '2013-01-05 15:59:45', NULL, 5, '购买空白凭证', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(47, '2013-01-08 17:38:16', 13.9, '2013-01-05 18:59:20', 'sherry', '100', '2013-01-05 18:59:20', '排除调休日期请假天', 'sqe_ole', '2013-01-07 18:59:00', 12, '2013-01-05 18:59:20', NULL, 5, '排除调休', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(48, '2013-01-07 17:42:14', 1.5, '2013-01-07 16:12:23', 'james', '100', '2013-01-07 16:12:23', '编写异常文档', 'sqe_ole', '2013-01-08 16:12:00', 12, '2013-01-07 16:12:23', NULL, 5, '编写异常文档', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(49, NULL, NULL, '2013-01-08 17:37:45', 'james', '0', '2013-01-08 17:37:45', '编写异常文档', 'sqe_ole', '2013-01-09 17:37:00', 1, '2013-01-08 17:37:45', NULL, 3, '编写异常文档', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(50, '2013-01-09 18:11:49', 0, '2013-01-09 18:11:39', 'james', '100', '2013-01-09 18:11:39', '修改图表数据和多层', 'sqe_ole', '2013-01-10 18:11:00', 12, '2013-01-09 18:11:39', NULL, 5, '修改图表', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(51, '2013-01-23 11:15:10', 17.7, '2013-01-22 17:36:01', 'james', '100', '2013-01-09 18:12:14', 'X轴表日期,往前推25天', 'sqe_ole', '2013-01-25 17:35:00', 0, '2013-01-22 17:35:00', NULL, 5, 'X轴表日期,往前推25天', 1, NULL, 2, 8, NULL, NULL, NULL),
	(52, '2013-01-12 20:13:23', 13.9, '2013-01-11 09:39:17', 'james', '100', '2013-01-09 18:12:36', 'Y轴表实际数值', 'sqe_ole', '2013-01-12 18:13:00', 12, '2013-01-10 18:13:00', NULL, 5, 'Y轴表实际数值', 1, NULL, 2, 8, NULL, NULL, '改其它bug'),
	(53, '2013-01-10 17:35:49', 0.1, '2013-01-10 17:27:15', 'james', '100', '2013-01-09 18:12:53', 'SWOT只是判断颜色', 'sqe_ole', '2013-01-11 18:13:00', 12, '2013-01-10 18:13:00', NULL, 5, 'SWOT只是判断颜色', 1, NULL, 2, 8, NULL, NULL, NULL),
	(54, '2013-01-14 17:53:52', 0, '2013-01-14 17:52:28', 'sherry', '100', '2013-01-14 17:52:28', '报表发送图', 'sqe_ole', '2013-01-16 17:52:00', 12, '2013-01-14 17:52:28', NULL, 5, '报表发送图', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(55, '2013-01-22 17:35:09', 13.9, '2013-01-14 17:52:50', 'sherry', '100', '2013-01-14 17:52:50', '周报和月报等图形', 'sqe_ole', '2013-01-18 17:52:00', 12, '2013-01-14 17:52:50', NULL, 5, '周报和月报等图形', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(56, '2013-01-17 17:35:52', 13.9, '2013-01-14 17:53:07', 'sherry', '100', '2013-01-14 17:53:07', 'SWOT改成只返回颜色值，不需要返回计算值', 'sqe_ole', '2013-01-25 17:53:00', 23, '2013-01-14 17:53:07', NULL, 5, 'SWOT改成只返回颜色值', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(57, '2013-01-15 18:12:29', 24.3, '2013-01-14 17:53:21', 'sherry', '100', '2013-01-14 17:53:21', '判断SWOT基准至少几个，或全部都有SWOT值', 'sqe_ole', '2013-01-31 17:53:00', 21, '2013-01-14 17:53:21', NULL, 5, '判断SWOT基准至少几个', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(58, '2013-01-18 17:36:03', 13.9, '2013-01-14 17:53:35', 'sherry', '100', '2013-01-14 17:53:35', '周、月、季、年生成PDF文件.', 'sqe_ole', '2013-01-31 17:53:00', 23, '2013-01-14 17:53:35', NULL, 5, '生成PDF文件.', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(59, '2013-01-19 16:43:23', 0.1, '2013-01-19 16:40:21', 'sherry', '100', '2013-01-19 16:40:21', '整理上海兴亚电子元件有限公司(本社工厂)公司的差旅费', 'wendy', '2013-01-19 14:00:00', 1, '2013-01-19 16:40:21', NULL, 5, '差旅费', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(60, '2013-01-19 19:54:04', 0, '2013-01-19 19:53:53', 'sherry', '100', '2013-01-19 19:53:53', '修改Sowt配置添加上管线和下管线', 'sqe_ole', '2013-01-19 19:53:00', 12, '2013-01-19 19:53:53', NULL, 5, '修改Sowt配置', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(61, '2013-02-18 17:53:37', 13.9, '2013-01-24 17:14:10', 'sherry', '100', '2013-01-23 11:06:07', '图表pdf设置和邮件发送', 'sqe_ole', '2013-01-25 11:17:00', 0, '2013-01-23 11:17:00', NULL, 5, '图表pdf', 1, NULL, 2, 12, NULL, NULL, '工作上的'),
	(62, '2013-01-25 16:35:24', 13.9, '2013-01-23 11:13:54', 'sherry', '100', '2013-01-23 11:06:24', '设置图表数据', 'sqe_ole', '2013-01-24 11:06:00', 0, '2013-01-23 11:06:00', NULL, 5, '设置图表数据', 1, NULL, 2, 8, NULL, NULL, '完成了修改了一些问题'),
	(63, '2013-01-23 11:54:55', 0.4, '2013-01-23 11:33:08', 'sherry', '100', '2013-01-23 11:32:36', '编写工作文档，将项目功能和方法记录！', 'sqe_ole', '2013-01-24 11:32:00', 0, '2013-01-23 11:32:00', NULL, 5, '编写工作文档', 0, 5, NULL, 9, NULL, NULL, NULL),
	(64, '2013-01-25 16:35:19', 53, '2013-01-23 11:33:08', 'sherry', '100', '2013-01-23 11:42:22', NULL, 'sqe_ole', '2013-01-24 11:32:00', 0, '2013-01-23 11:32:00', NULL, 5, '编写工作文档', 0, 5, NULL, 9, NULL, NULL, '好的'),
	(65, '2013-01-25 16:55:37', 47.4, '2013-01-23 17:33:05', 'sherry', '100', '2013-01-23 17:33:05', '工作天数增加0.5天', 'wendy', '2013-01-23 17:00:00', 1, '2013-01-23 17:33:05', NULL, 5, '应收应付款', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(66, NULL, 0, '2013-01-23 17:35:06', 'sherry', '0', '2013-01-23 17:35:06', 'Akro Engineering Plastics (Suzhou) Co., Ltd.\nK.D.F. Distribution (Shanghai) Co., Ltd.\nMehler Engineered Products (Suzhou) Co., Ltd', 'wendy', '2013-01-23 16:00:00', 1, '2013-01-23 17:35:06', NULL, 3, '整理客户资料', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(67, NULL, 0, '2013-01-23 17:36:04', 'sherry', '0', '2013-01-23 17:36:04', '移动公司核对信息', 'wendy', '2013-01-23 17:00:00', 1, '2013-01-23 17:36:04', NULL, 3, '处理电话问题', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(68, '2013-02-18 17:53:43', 20, '2013-01-23 11:33:08', 'sherry', '100', '2013-01-25 16:35:19', NULL, 'sqe_ole', '2013-01-24 11:32:00', 0, '2013-01-23 11:32:00', NULL, 5, '编写工作文档', 0, 5, NULL, 9, NULL, NULL, '12'),
	(69, '2013-01-25 16:54:20', 0, '2013-01-25 16:52:26', 'sherry', '100', '2013-01-25 16:52:26', '兴业银行转账需注意事项：\n1.转账需要携带兴业银行凭证，凭证上面需要盖章（公司章与法人章），凭证上需要写清楚转账的金额与用途，携带回单提取卡。\n2、兴业银行地址：东方路710号  电话：58303977  周一～周五  上午9:00-12:00，下午13:00-16:30  \n3、将转账凭证交给柜台工作人员。之后工作人员会返给一张小票。\n4、将回单提取卡靠在银行回单提取的机器的感应部位。\n5、抽屉中会出现相关的单据，拿回单据，推还抽屉，方可离开。', 'wendy', '2013-01-25 17:30:00', 4, '2013-01-25 16:52:26', NULL, 5, '添加如何做', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(70, NULL, 0, '2013-01-25 16:53:24', 'sherry', '0', '2013-01-25 16:53:24', '检测新版GOM的异常情况', 'wendy', '2013-01-25 00:00:00', 4, '2013-01-25 16:53:24', NULL, 3, '检测新版GOM', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(71, '2013-02-18 17:53:47', 0, '2013-02-18 17:52:30', 'sherry', '100', '2013-02-18 17:52:30', '修改BUG', 'sqe_ole', '2013-02-19 17:52:00', 12, '2013-02-18 17:52:30', NULL, 5, '修改BUG', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(72, NULL, 0, '2013-02-18 17:52:46', 'sherry', '0', '2013-02-18 17:52:46', '添加附件添加附件', 'sqe_ole', '2013-02-19 17:52:00', 12, '2013-02-18 17:52:46', NULL, 3, '添加附件', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(73, NULL, 0, '2013-02-18 17:53:14', 'sherry', '0', '2013-02-18 17:53:14', '添加语言按纽', 'sqe_ole', '2013-02-20 17:53:00', 12, '2013-02-18 17:53:14', NULL, 3, '添加语言按纽', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(74, '2013-02-19 17:28:22', 13.9, '2013-01-23 11:33:08', 'sherry', '100', '2013-02-18 17:53:43', NULL, 'sqe_ole', '2013-01-24 11:32:00', 0, '2013-01-23 11:32:00', NULL, 5, '编写工作文档', 0, 5, NULL, 9, NULL, NULL, '11'),
	(75, NULL, 0, '2013-02-19 16:21:12', 'roger', '0', '2013-02-19 16:21:12', '根据员工信息画出组织图，并将每个人的信息写出来', 'sherry', '2013-02-19 16:00:00', 2, '2013-02-19 16:21:12', NULL, 3, '画组织图及详细信息', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(76, '2013-02-19 16:24:21', 0, '2013-02-19 16:22:43', 'wendy', '100', '2013-02-19 16:22:43', '画组织图及整理员工信息', 'sherry', '2013-02-19 16:23:00', 2, '2013-02-19 16:22:43', NULL, 5, '画组织图及整理员工信息', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(77, NULL, 0, '2013-02-19 16:58:32', 'wendy', '0', '2013-02-19 16:55:47', '测试测试测试', 'sherry', '2013-02-20 16:57:00', 0, '2013-02-20 16:57:00', NULL, 3, '测试测试', 1, NULL, 5, 12, NULL, NULL, NULL),
	(78, NULL, 0, NULL, 'wendy', '0', '2013-02-19 17:03:06', '网站添加gom连接', 'sherry', '2013-02-20 17:05:00', 2, '2013-02-19 17:05:00', NULL, 3, '网站添加gom连接', 1, NULL, 5, 8, NULL, NULL, NULL),
	(79, NULL, 0, NULL, 'wendy', '0', '2013-02-19 17:08:47', '首页制作与旧版一样', 'sherry', '2013-02-20 16:00:00', 4, '2013-03-16 15:13:30', NULL, 3, 'gom首页制作', 1, NULL, 2, 8, NULL, NULL, NULL),
	(80, '2013-02-19 17:27:50', 0, '2013-01-23 11:33:08', 'sherry', '0', '2013-02-19 17:28:22', NULL, 'sqe_ole', '2013-01-24 11:32:00', 0, '2013-02-19 17:05:00', NULL, 3, '编写工作文档', 0, 5, NULL, 9, NULL, NULL, NULL),
	(81, '2013-03-12 17:32:34', 0.1, '2013-03-12 17:29:12', 'james', '100', '2013-03-09 12:33:46', '登出异常报告BUG修复', 'sqe_ole', '2013-03-17 14:32:00', 0, '2013-02-19 17:05:00', NULL, 5, '登出异常', 1, NULL, 2, 9, NULL, NULL, NULL),
	(82, '2013-03-22 17:25:57', 20.9, '2013-03-12 17:31:56', 'james', '100', '2013-03-09 12:34:02', '登录session改用Cookies 15个小时缓存', 'sqe_ole', '2013-03-17 14:32:00', 0, '2013-03-16 15:13:30', NULL, 5, '登录session', 1, NULL, 2, 9, NULL, NULL, '11'),
	(83, NULL, 0, NULL, 'james', '0', '2013-03-09 12:34:18', '防止重复提交问题', 'sqe_ole', '2013-03-17 14:32:00', 23, '2013-02-19 17:05:00', NULL, 3, '防止重复提交', 1, NULL, 2, 9, NULL, NULL, NULL),
	(84, '2013-03-23 18:00:30', 24.5, '2013-03-22 17:27:53', 'james', '100', '2013-03-09 12:34:37', '入职权限分配', 'sqe_ole', '2013-03-17 14:32:00', 0, '2013-03-16 15:13:30', NULL, 5, '职权限分配', 1, NULL, 2, 9, NULL, NULL, 'a'),
	(85, '2013-03-12 17:32:29', 0, '2013-03-12 17:30:56', 'james', '100', '2013-03-09 12:34:43', '国际化国际化', 'sqe_ole', '2013-03-17 14:32:00', 0, '2013-02-19 17:05:00', NULL, 5, '国际化', 0, 6, NULL, 9, NULL, NULL, NULL),
	(86, '2013-03-12 17:33:01', 0, '2013-03-12 17:30:56', 'james', '100', '2013-03-12 17:32:29', NULL, 'sqe_ole', '2013-03-17 14:32:00', 0, '2013-03-16 15:13:30', NULL, 5, '国际化', 0, 6, NULL, 9, NULL, NULL, NULL),
	(87, '2013-03-12 17:32:47', 0, '2013-03-12 17:30:56', 'james', '0', '2013-03-12 17:33:01', NULL, 'sqe_ole', '2013-03-17 14:32:00', 0, '2013-02-19 17:05:00', NULL, 3, '国际化', 0, 6, NULL, 9, NULL, NULL, NULL),
	(88, '2013-03-28 17:10:04', 290.6, '2013-03-16 14:33:09', 'sherry', '100', '2013-03-16 14:33:09', '请假提交问题', 'sqe_ole', '2013-03-17 14:32:00', 12, '2013-03-16 14:33:09', NULL, 5, '请假提交问题', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(89, '2013-03-28 17:10:11', 289.9, '2013-03-16 15:13:30', 'sherry', '100', '2013-03-16 15:13:30', '修改请假部门显示', 'sqe_ole', '2013-03-16 15:13:00', 12, '2013-03-16 15:13:30', NULL, 5, '修改请假部门显示', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(90, '2013-03-28 17:10:20', 289.5, '2013-03-16 15:42:48', 'sherry', '100', '2013-03-16 15:42:48', '检测过程2', 'sqe_ole', '2013-03-25 15:42:00', 12, '2013-03-16 15:42:48', NULL, 5, '检测过程', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(91, NULL, 0, NULL, 'sqe_ole', '0', '2013-03-16 15:54:12', '登录禁止登录禁止', NULL, NULL, 12, NULL, NULL, 1, '登录禁止', 1, NULL, 2, NULL, NULL, NULL, NULL),
	(92, '2013-03-26 17:33:03', 24.5, '2013-03-25 17:04:33', 'james', '100', '2013-03-25 17:04:33', '通用菜单配置标题改成”通用菜单配置”', 'sqe_ole', '2013-03-25 17:04:00', 1, '2013-03-25 17:04:33', NULL, 5, '通用菜单配置标题', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(93, '2013-03-26 17:32:59', 24.5, '2013-03-25 17:04:53', 'james', '100', '2013-03-25 17:04:53', 'SWOT配置列表', 'sqe_ole', '2013-03-29 17:04:00', 1, '2013-03-25 17:04:53', NULL, 5, 'SWOT配置列表', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(94, '2013-03-29 17:28:16', 96.4, '2013-03-25 17:05:10', 'admin', '100', '2013-03-25 17:05:10', '责任管理和主管分配连接', 'sqe_ole', '2013-03-27 17:05:00', 1, '2013-03-25 17:05:10', NULL, 5, '责任管理和主管分配连接', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(95, '2013-03-25 17:28:32', 0.4, '2013-03-25 17:05:30', 'james', '100', '2013-03-25 17:05:30', '系统参数设置部分按指定人员所属部门', 'sqe_ole', '2013-03-30 17:05:00', 1, '2013-03-25 17:05:30', NULL, 5, '系统参数设置', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(96, '2013-03-25 17:28:28', 0.4, '2013-03-25 17:05:51', 'james', '100', '2013-03-25 17:05:51', '系统参数部分都没做验证', 'sqe_ole', '2013-03-29 17:05:00', 1, '2013-03-25 17:05:51', NULL, 5, '系统参数做验证', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(97, '2013-03-25 17:07:13', 0, '2013-03-25 17:06:09', 'james', '100', '2013-03-25 17:06:09', '6.	节假日的参数也没验证', 'sqe_ole', '2013-03-28 17:06:00', 1, '2013-03-25 17:06:09', NULL, 5, '节假日的参数也没验证', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(98, '2013-03-29 17:30:05', 96.4, '2013-03-25 17:06:38', 'admin', '100', '2013-03-25 17:06:38', '多国语言部分简繁体转换', 'sqe_ole', '2013-03-27 17:06:00', 12, '2013-03-25 17:06:38', NULL, 5, '多国语言部分', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(99, '2013-03-27 17:38:29', 24.1, '2013-03-26 17:33:35', 'james', '100', '2013-03-26 17:33:35', 'Good morning 用户配置页面', 'sqe_ole', '2013-03-29 17:33:00', 12, '2013-03-26 17:33:35', NULL, 5, 'Good morning 用户配置页面', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(100, '2013-03-29 09:21:22', 63.8, '2013-03-26 17:34:03', 'admin', '100', '2013-03-26 17:34:03', '添加资源文件的时候，把责任分数改成主责', 'sqe_ole', '2013-03-28 17:34:00', 2, '2013-03-26 17:34:03', NULL, 5, '添加资源文件责任', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(101, NULL, 0, '2013-03-29 17:26:51', 'james', '0', '2013-03-29 17:26:51', '系统参数所有已有字段验证', 'sqe_ole', '2013-03-29 17:26:00', 1, '2013-03-29 17:26:51', NULL, 3, '系统参数所有已有字段验证', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(102, '2013-04-03 17:28:19', 120, '2013-03-29 17:27:06', 'james', '100', '2013-03-29 17:27:06', '接口没有注释的加上', 'sqe_ole', '2013-03-29 17:27:00', 1, '2013-03-29 17:27:06', NULL, 5, '接口没有注释的加上', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(103, '2013-04-03 17:28:16', 120, '2013-03-29 17:27:19', 'james', '100', '2013-03-29 17:27:19', '资产管理直接连接到主目录资产清单', 'sqe_ole', '2013-03-29 17:27:00', 4, '2013-03-29 17:27:19', NULL, 5, '资产管理直接连接到主目录资产清单', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(104, '2013-04-03 17:28:12', 120, '2013-03-29 17:27:41', 'james', '100', '2013-03-29 17:27:41', '如何做改用编辑器', 'sqe_ole', '2013-03-29 17:27:00', 5, '2013-03-29 17:27:41', NULL, 5, '如何做改用编辑器', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(105, NULL, 0, '2013-03-29 17:27:56', 'admin', '0', '2013-03-29 17:27:56', '添加资源文件中删除根目录添加，只能在子目录添加', 'sqe_ole', '2013-03-29 17:27:00', 5, '2013-03-29 17:27:56', NULL, 3, '添加资源文件中删除根目录添加，只能在子目录添加', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(106, NULL, 0, '2013-04-08 18:11:15', 'james', '0', '2013-04-08 18:11:15', '修改树目录显示到主目录添加问题', 'sqe_ole', '2013-04-08 18:11:00', 1, '2013-04-08 18:11:15', NULL, 3, '修改树目录显示到主目录添加问题', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(107, NULL, 0, '2013-04-08 18:11:33', 'admin', '0', '2013-04-08 18:11:33', '添加资产清单后台管理', 'sqe_ole', '2013-04-08 18:11:00', 5, '2013-04-08 18:11:33', NULL, 3, '添加资产清单后台管理', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(108, NULL, 0, '2013-04-08 18:11:50', 'james', '0', '2013-04-08 18:11:50', '修改前台资产不能删除资产操作', 'sqe_ole', '2013-04-08 18:11:00', 3, '2013-04-08 18:11:50', NULL, 3, '修改前台资产不能删除资产操作', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(109, '2013-04-08 18:20:15', 0.1, '2013-04-08 18:12:16', 'james', '100', '2013-04-08 18:12:16', '申领资产在前台数量在输入时控制输入数量如果大于已有数量返回到原有数量上', 'sqe_ole', '2013-04-08 18:12:00', 5, '2013-04-08 18:12:16', NULL, 5, '申领资产', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(110, '2013-04-08 18:20:10', 0.1, '2013-04-08 18:12:39', 'james', '100', '2013-04-08 18:12:39', '把责任管理的数据库id 1-6 删除', 'sqe_ole', '2013-04-08 18:12:00', 3, '2013-04-08 18:12:39', NULL, 5, '把责任管理的数据库', 2, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;


-- Dumping structure for procedure gom.tj_summary
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `tj_summary`(in_range INT, in_date DATE, userId INT, quantity INT, in_contribution INT, in_plan INT, in_practical INT, in_leave INT, in_lieu INT, in_late INT, in_early INT, in_delay INT)
BEGIN
TRUNCATE TABLE statistics;		

SELECT insert_data(in_range, in_date, in_contribution, quantity, userId);
SELECT insert_data(in_range, in_date, in_plan, quantity, userId);
SELECT insert_data(in_range, in_date, in_practical, quantity, userId);
SELECT insert_data(in_range, in_date, in_leave, quantity, userId);
SELECT insert_data(in_range, in_date, in_lieu, quantity, userId);
SELECT insert_data(in_range, in_date, in_late, quantity, userId);
SELECT insert_data(in_range, in_date, in_early, quantity, userId);
SELECT insert_data(in_range, in_date, in_delay, quantity, userId);

END//
DELIMITER ;


-- Dumping structure for table gom.trace
CREATE TABLE IF NOT EXISTS `trace` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actor` varchar(15) DEFAULT NULL,
  `arrow` varchar(25) DEFAULT NULL,
  `attachment` varchar(37) DEFAULT NULL,
  `deliverTime` datetime DEFAULT NULL,
  `icon` varchar(20) NOT NULL,
  `opinion` varchar(500) DEFAULT NULL,
  `processId` int(10) NOT NULL,
  `state` tinyint(4) unsigned DEFAULT NULL,
  `process_trace_fk` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4D501253C486DEA` (`process_trace_fk`),
  CONSTRAINT `FK4D501253C486DEA` FOREIGN KEY (`process_trace_fk`) REFERENCES `process` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=660 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.trace: ~319 rows (approximately)
/*!40000 ALTER TABLE `trace` DISABLE KEYS */;
INSERT INTO `trace` (`id`, `actor`, `arrow`, `attachment`, `deliverTime`, `icon`, `opinion`, `processId`, `state`, `process_trace_fk`) VALUES
	(1, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-09-25 16:04:16', 'green.jpg', NULL, 1, 5, 10),
	(2, 'sherry', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-26 16:53:38', 'green.jpg', NULL, 1, 5, 11),
	(3, 'sherry', 'right_green_arrow.jpg', NULL, '2012-09-26 10:16:18', 'green.jpg', NULL, 2, 5, 10),
	(4, 'sherry', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-26 16:53:22', 'green.jpg', NULL, 2, 5, 11),
	(5, 'james', 'right_green_arrow.jpg', NULL, '2012-09-26 10:35:22', 'green.jpg', NULL, 3, 5, 10),
	(6, 'sherry', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-26 16:52:57', 'green.jpg', NULL, 3, 5, 11),
	(7, 'admin', 'right_green_arrow.jpg', NULL, '2012-09-26 10:40:12', 'green.jpg', NULL, 4, 5, 10),
	(8, 'sherry', 'right_green_arrow.jpg', 'sqe_sherry@sqeservice.com', '2013-01-23 16:45:31', 'green.jpg', NULL, 4, 5, 11),
	(9, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-27 14:36:52', 'green.jpg', NULL, 3, 5, 12),
	(10, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-27 11:15:13', 'green.jpg', NULL, 2, 5, 12),
	(11, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-27 14:36:28', 'green.jpg', NULL, 1, 5, 12),
	(12, 'wendy', 'right_green_arrow.jpg', NULL, '2012-09-26 16:57:31', 'green.jpg', NULL, 5, 5, 10),
	(13, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-26 17:01:09', 'green.jpg', NULL, 5, 5, 11),
	(14, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-27 14:32:07', 'green.jpg', NULL, 5, 5, 12),
	(15, 'tome', 'right_green_arrow.jpg', NULL, '2012-09-26 17:04:24', 'green.jpg', NULL, 6, 5, 10),
	(16, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2013-01-23 16:42:09', 'green.jpg', NULL, 6, 5, 11),
	(17, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2012-09-27 11:41:42', 'green.jpg', NULL, 2, 5, 13),
	(18, NULL, 'right_green_arrow.jpg', NULL, '2012-09-27 11:40:47', 'end_green.jpg', NULL, 2, 5, 15),
	(116, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-25 16:26:29', 'green.jpg', NULL, 5, 5, 28),
	(117, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-27 15:55:35', 'green.jpg', '批准,通过', 5, 5, 29),
	(144, 'wendy', 'right_green_arrow.jpg', NULL, '2012-12-26 17:24:22', 'green.jpg', '批准,11111', 11, 5, 28),
	(145, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-27 15:06:15', 'green.jpg', '批准,ds', 11, 5, 28),
	(146, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-26 17:26:22', 'green.jpg', '批准,22222', 12, 5, 28),
	(147, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-27 11:53:02', 'red.jpg', '拒绝,通过', 12, 5, 29),
	(172, 'End', 'right_red_arrow.jpg', NULL, '2012-12-27 11:53:02', 'end_red.jpg', '你的申请被拒绝', 12, 5, 32),
	(175, 'wendy', 'right_green_arrow.jpg', NULL, '2012-12-27 15:53:47', 'green.jpg', '批准,通过', 11, 5, 30),
	(177, 'End', 'right_green_arrow.jpg', NULL, '2012-12-27 15:53:47', 'end_green.jpg', NULL, 11, 5, 31),
	(178, 'End', 'right_green_arrow.jpg', NULL, '2012-12-27 15:55:35', 'end_green.jpg', NULL, 5, 5, 31),
	(179, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-27 16:00:48', 'green.jpg', '批准,异常了！', 25, 5, 28),
	(180, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-28 14:30:33', 'green.jpg', '批准,批准', 25, 5, 29),
	(181, 'wendy', 'right_green_arrow.jpg', NULL, '2012-12-27 16:48:29', 'green.jpg', '批准,顶戴', 26, 5, 28),
	(182, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-28 14:32:11', 'green.jpg', '批准,批准', 26, 5, 29),
	(187, 'End', 'right_green_arrow.jpg', NULL, '2012-12-28 14:30:33', 'end_green.jpg', NULL, 25, 5, 31),
	(188, 'End', 'right_green_arrow.jpg', NULL, '2012-12-28 14:32:11', 'end_green.jpg', NULL, 26, 5, 31),
	(189, 'admin', 'right_green_arrow.jpg', NULL, '2012-12-28 14:33:06', 'green.jpg', '批准,我有异常', 27, 5, 28),
	(190, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-28 14:36:35', 'green.jpg', '批准,批准', 27, 5, 29),
	(191, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-28 14:36:27', 'green.jpg', '批准,aa', 28, 5, 28),
	(192, 'james', 'right_green_arrow.jpg', NULL, '2012-12-28 14:38:32', 'green.jpg', '批准,批准', 28, 5, 29),
	(193, 'End', 'right_green_arrow.jpg', NULL, '2012-12-28 14:36:35', 'end_green.jpg', NULL, 27, 5, 31),
	(194, 'james', 'right_green_arrow.jpg', NULL, '2012-12-28 14:38:05', 'green.jpg', '批准,111', 29, 5, 28),
	(195, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-28 14:38:18', 'green.jpg', '批准,批准', 29, 5, 29),
	(196, 'End', 'right_green_arrow.jpg', NULL, '2012-12-28 14:38:18', 'end_green.jpg', NULL, 29, 5, 31),
	(197, 'End', 'right_green_arrow.jpg', NULL, '2012-12-28 14:38:32', 'end_green.jpg', NULL, 28, 5, 31),
	(228, 'wendy', 'right_green_arrow.jpg', NULL, '2012-12-29 09:11:54', 'green.jpg', NULL, 30, 5, 28),
	(229, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:54', 'green.jpg', '批准,批准', 30, 5, 29),
	(230, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-29 17:26:02', 'green.jpg', '批准,11', 31, 5, 28),
	(231, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:55', 'green.jpg', '批准,批准', 31, 5, 29),
	(232, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-29 17:26:13', 'green.jpg', '批准,11', 32, 5, 28),
	(233, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-05 18:50:12', 'green.jpg', '批准,批准', 32, 5, 29),
	(234, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 13:26:15', 'green.jpg', NULL, 22, 5, 22),
	(235, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 13:26:50', 'green.jpg', NULL, 22, 5, 23),
	(236, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 13:32:26', 'green.jpg', NULL, 22, 5, 24),
	(237, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 13:27:07', 'green.jpg', '批准,111', 33, 5, 28),
	(238, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:55', 'green.jpg', '批准,批准', 33, 5, 29),
	(239, 'sqe_ole', 'right_green_arrow.jpg', '', '2012-12-31 13:27:56', 'green.jpg', NULL, 23, 5, 24),
	(240, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:31', 'green.jpg', NULL, 23, 5, 26),
	(241, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:31', 'end_green.jpg', NULL, 23, 5, 27),
	(242, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:54', 'end_green.jpg', NULL, 30, 5, 31),
	(243, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:55', 'end_green.jpg', NULL, 31, 5, 31),
	(244, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 13:28:55', 'end_green.jpg', NULL, 33, 5, 31),
	(245, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 13:33:01', 'green.jpg', NULL, 22, 5, 26),
	(246, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 13:32:42', 'green.jpg', NULL, 34, 5, 28),
	(247, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 16:47:12', 'green.jpg', '批准,批准', 34, 5, 29),
	(248, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 13:33:01', 'end_green.jpg', NULL, 22, 5, 27),
	(249, 'sqe_ole', 'right_green_arrow.jpg', '', '2012-12-31 13:37:01', 'green.jpg', NULL, 24, 5, 24),
	(250, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 14:57:42', 'green.jpg', NULL, 24, 5, 26),
	(251, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 15:10:35', 'green.jpg', NULL, 21, 5, 24),
	(253, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 14:57:42', 'end_green.jpg', NULL, 24, 5, 27),
	(254, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 15:10:32', 'green.jpg', NULL, 20, 5, 24),
	(255, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 15:10:19', 'green.jpg', NULL, 20, 5, 26),
	(263, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 15:10:19', 'end_green.jpg', NULL, 20, 5, 27),
	(264, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 15:10:32', 'green.jpg', NULL, 20, 5, 23),
	(265, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 15:10:35', 'green.jpg', NULL, 21, 5, 23),
	(266, 'wendy', 'right_green_arrow.jpg', '', '2012-12-31 16:13:46', 'green.jpg', NULL, 25, 5, 24),
	(267, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-19 16:42:57', 'green.jpg', NULL, 25, 5, 26),
	(268, 'wendy', 'right_green_arrow.jpg', '', '2012-12-31 16:15:28', 'green.jpg', NULL, 26, 5, 24),
	(269, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-19 16:43:06', 'green.jpg', NULL, 26, 5, 26),
	(270, 'sherry', 'right_green_arrow.jpg', '', '2012-12-31 16:35:14', 'green.jpg', NULL, 27, 5, 24),
	(271, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 16:35:14', 'active.gif', NULL, 27, 2, 26),
	(272, 'sherry', 'right_green_arrow.jpg', '', '2012-12-31 16:37:06', 'green.jpg', NULL, 28, 5, 24),
	(273, 'sherry', 'right_green_arrow.jpg', NULL, '2012-12-31 16:48:02', 'green.jpg', NULL, 28, 5, 26),
	(274, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 16:47:12', 'end_green.jpg', NULL, 34, 5, 31),
	(275, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 16:48:02', 'end_green.jpg', NULL, 28, 5, 27),
	(276, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 17:10:37', 'green.jpg', NULL, 29, 5, 24),
	(277, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 17:17:56', 'green.jpg', NULL, 29, 5, 26),
	(278, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 17:17:56', 'end_green.jpg', NULL, 29, 5, 27),
	(279, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 17:18:11', 'green.jpg', NULL, 31, 5, 23),
	(280, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 17:20:31', 'green.jpg', NULL, 31, 5, 24),
	(281, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 17:20:45', 'green.jpg', NULL, 31, 5, 26),
	(282, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 17:20:45', 'end_green.jpg', NULL, 31, 5, 27),
	(283, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 17:20:55', 'green.jpg', NULL, 32, 5, 23),
	(284, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 17:21:36', 'green.jpg', NULL, 32, 5, 24),
	(285, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 17:21:45', 'green.jpg', NULL, 32, 5, 26),
	(286, 'End', 'right_green_arrow.jpg', NULL, '2012-12-31 17:21:45', 'end_green.jpg', NULL, 32, 5, 27),
	(287, 'james', 'right_green_arrow.jpg', NULL, '2012-12-31 17:21:47', 'green.jpg', NULL, 33, 5, 23),
	(288, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2012-12-31 17:21:47', 'active.gif', NULL, 33, 2, 24),
	(289, 'sqe_ole', 'right_green_arrow.jpg', '', '2012-12-31 17:26:06', 'green.jpg', NULL, 34, 5, 24),
	(290, 'james', 'right_green_arrow.jpg', NULL, '2013-01-08 11:35:13', 'green.jpg', NULL, 34, 5, 26),
	(291, 'sqe_ole', 'right_green_arrow.jpg', '', '2012-12-31 17:26:35', 'green.jpg', NULL, 35, 5, 24),
	(292, 'james', 'right_green_arrow.jpg', NULL, '2013-01-03 16:31:34', 'green.jpg', '好过多完成<br/>批准,好过多完成', 35, 5, 26),
	(293, 'wendy', 'right_green_arrow.jpg', '', '2013-01-02 10:59:45', 'green.jpg', NULL, 36, 5, 24),
	(294, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-21 17:36:31', 'green.jpg', NULL, 36, 5, 26),
	(295, 'wendy', 'right_green_arrow.jpg', '', '2013-01-02 11:30:00', 'green.jpg', NULL, 3, 5, 16),
	(296, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-02 11:31:18', 'green.jpg', '批准,早去早回', 3, 5, 17),
	(297, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-04 13:39:51', 'green.jpg', '批准,同意', 3, 5, 18),
	(298, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-02 13:12:48', 'green.jpg', NULL, 2, 5, 1),
	(299, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 16:24:15', 'green.jpg', '批准,同意', 2, 5, 2),
	(300, 'wendy', 'right_green_arrow.jpg', '', '2013-01-02 15:10:28', 'green.jpg', NULL, 37, 5, 24),
	(301, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:54:39', 'green.jpg', NULL, 37, 5, 26),
	(302, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-02 17:49:52', 'green.jpg', NULL, 38, 5, 24),
	(303, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-04 17:33:36', 'green.jpg', NULL, 38, 5, 26),
	(304, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-02 17:50:16', 'green.jpg', NULL, 39, 5, 24),
	(305, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-04 17:33:41', 'green.jpg', NULL, 39, 5, 26),
	(306, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-02 17:50:44', 'green.jpg', NULL, 40, 5, 24),
	(307, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-02 17:50:54', 'green.jpg', NULL, 40, 5, 26),
	(308, 'End', 'right_green_arrow.jpg', NULL, '2013-01-02 17:50:54', 'end_green.jpg', NULL, 40, 5, 27),
	(309, 'james', 'right_green_arrow.jpg', NULL, '2013-01-03 16:01:19', 'green.jpg', NULL, 41, 5, 22),
	(310, 'james', 'right_green_arrow.jpg', NULL, '2013-01-03 16:02:19', 'green.jpg', NULL, 41, 5, 23),
	(311, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-05 19:03:17', 'green.jpg', NULL, 41, 5, 24),
	(312, 'End', 'right_green_arrow.jpg', NULL, '2013-01-03 16:31:34', 'end_green.jpg', NULL, 35, 5, 27),
	(313, 'End', 'right_green_arrow.jpg', NULL, '2013-01-04 13:39:51', 'end_green.jpg', NULL, 3, 5, 20),
	(314, 'sherry', 'right_green_arrow.jpg', '', '2013-01-04 13:44:05', 'green.jpg', NULL, 4, 5, 16),
	(315, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-04 14:04:11', 'green.jpg', '批准,同意没问题', 4, 5, 17),
	(316, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-04 14:11:01', 'green.jpg', '批准,可以 同意', 4, 5, 18),
	(317, 'End', 'right_green_arrow.jpg', NULL, '2013-01-04 14:11:01', 'end_green.jpg', NULL, 4, 5, 20),
	(318, 'sherry', 'right_green_arrow.jpg', '', '2013-01-04 14:13:17', 'green.jpg', NULL, 5, 5, 16),
	(319, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-04 14:13:53', 'green.jpg', '批准,没问题 同意', 5, 5, 17),
	(320, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-04 14:13:53', 'active.gif', NULL, 5, 2, 18),
	(321, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-04 16:06:12', 'green.jpg', NULL, 42, 5, 22),
	(322, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-07 16:13:10', 'green.jpg', NULL, 42, 5, 23),
	(323, 'End', 'right_green_arrow.jpg', NULL, '2013-01-04 17:33:36', 'end_green.jpg', NULL, 38, 5, 27),
	(324, 'End', 'right_green_arrow.jpg', NULL, '2013-01-04 17:33:41', 'end_green.jpg', NULL, 39, 5, 27),
	(325, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-04 17:34:44', 'green.jpg', NULL, 43, 5, 24),
	(326, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-08 17:38:10', 'green.jpg', NULL, 43, 5, 26),
	(327, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 15:30:15', 'green.jpg', NULL, 45, 5, 22),
	(328, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 15:38:36', 'green.jpg', NULL, 45, 5, 23),
	(329, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-05 16:05:02', 'green.jpg', '批准,完成', 45, 5, 24),
	(330, 'wendy', 'right_green_arrow.jpg', '', '2013-01-05 15:59:45', 'green.jpg', NULL, 46, 5, 24),
	(331, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-19 16:43:15', 'green.jpg', NULL, 46, 5, 26),
	(332, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-05 16:07:31', 'green.jpg', NULL, 45, 5, 26),
	(333, 'End', 'right_green_arrow.jpg', NULL, '2013-01-05 16:07:31', 'end_green.jpg', NULL, 45, 5, 27),
	(334, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 16:53:24', 'green.jpg', '批准,同意<br>批准,111<br/>批准,可以通过', 2, 5, 3),
	(337, 'sherry', 'right_green_arrow.jpg', '105c2308a00e42288d5d323d7ebf440b.docx', '2013-01-05 17:02:20', 'green.jpg', '批准,可以  同意', 2, 5, 4),
	(338, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 17:09:15', 'green.jpg', '批准,结算了', 2, 5, 5),
	(340, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-23 15:20:09', 'green.jpg', '批准,调整工作接收人职责比重', 2, 5, 6),
	(341, 'End', 'right_green_arrow.jpg', NULL, '2013-01-05 18:50:12', 'end_green.jpg', NULL, 32, 5, 31),
	(342, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-05 18:53:13', 'green.jpg', '批准,有问题了？', 35, 5, 28),
	(343, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 18:56:57', 'green.jpg', '批准,批准', 35, 5, 29),
	(346, 'End', 'right_green_arrow.jpg', NULL, '2013-01-05 18:56:57', 'end_green.jpg', NULL, 35, 5, 31),
	(347, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-05 18:59:20', 'green.jpg', NULL, 47, 5, 24),
	(348, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-08 17:38:16', 'green.jpg', NULL, 47, 5, 26),
	(349, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-05 19:04:08', 'green.jpg', NULL, 41, 5, 26),
	(350, 'End', 'right_green_arrow.jpg', NULL, '2013-01-05 19:04:08', 'end_green.jpg', NULL, 41, 5, 27),
	(351, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-07 16:12:23', 'green.jpg', NULL, 48, 5, 24),
	(352, 'james', 'right_green_arrow.jpg', NULL, '2013-01-07 17:42:14', 'green.jpg', NULL, 48, 5, 26),
	(353, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-07 17:41:42', 'green.jpg', NULL, 42, 5, 24),
	(354, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-07 16:22:48', 'green.jpg', '批准,昨天下午断电了！', 36, 5, 28),
	(355, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:29', 'green.jpg', '批准,批准', 36, 5, 29),
	(356, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:23', 'end_green.jpg', NULL, 36, 5, 31),
	(357, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:25', 'end_green.jpg', NULL, 36, 5, 31),
	(358, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:27', 'end_green.jpg', NULL, 36, 5, 31),
	(359, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:28', 'end_green.jpg', NULL, 36, 5, 31),
	(360, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:28', 'end_green.jpg', NULL, 36, 5, 31),
	(361, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:40:29', 'end_green.jpg', NULL, 36, 5, 31),
	(362, 'james', 'right_green_arrow.jpg', NULL, '2013-01-07 17:42:07', 'green.jpg', NULL, 42, 5, 26),
	(363, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:42:07', 'end_green.jpg', NULL, 42, 5, 27),
	(364, 'End', 'right_green_arrow.jpg', NULL, '2013-01-07 17:42:14', 'end_green.jpg', NULL, 48, 5, 27),
	(365, 'End', 'right_green_arrow.jpg', NULL, '2013-01-08 11:35:13', 'end_green.jpg', NULL, 34, 5, 27),
	(366, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-08 17:37:45', 'green.jpg', NULL, 49, 5, 24),
	(367, 'james', 'right_green_arrow.jpg', NULL, '2013-01-08 17:37:45', 'active.gif', NULL, 49, 2, 26),
	(368, 'End', 'right_green_arrow.jpg', NULL, '2013-01-08 17:38:10', 'end_green.jpg', NULL, 43, 5, 27),
	(369, 'End', 'right_green_arrow.jpg', NULL, '2013-01-08 17:38:16', 'end_green.jpg', NULL, 47, 5, 27),
	(370, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-09 18:11:39', 'green.jpg', NULL, 50, 5, 24),
	(371, 'james', 'right_green_arrow.jpg', NULL, '2013-01-09 18:11:49', 'green.jpg', NULL, 50, 5, 26),
	(372, 'End', 'right_green_arrow.jpg', NULL, '2013-01-09 18:11:49', 'end_green.jpg', NULL, 50, 5, 27),
	(373, 'james', 'right_green_arrow.jpg', NULL, '2013-01-09 18:12:14', 'green.jpg', NULL, 51, 5, 22),
	(374, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-22 17:35:43', 'green.jpg', NULL, 51, 5, 23),
	(375, 'james', 'right_green_arrow.jpg', NULL, '2013-01-09 18:12:36', 'green.jpg', NULL, 52, 5, 22),
	(376, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-09 18:13:53', 'green.jpg', NULL, 52, 5, 23),
	(377, 'james', 'right_green_arrow.jpg', NULL, '2013-01-09 18:12:53', 'green.jpg', NULL, 53, 5, 22),
	(378, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-09 18:13:41', 'green.jpg', NULL, 53, 5, 23),
	(379, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-10 17:35:39', 'green.jpg', NULL, 53, 5, 24),
	(380, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-12 20:13:07', 'green.jpg', NULL, 52, 5, 24),
	(381, 'james', 'right_green_arrow.jpg', NULL, '2013-01-10 17:35:49', 'green.jpg', NULL, 53, 5, 26),
	(382, 'End', 'right_green_arrow.jpg', NULL, '2013-01-10 17:35:49', 'end_green.jpg', NULL, 53, 5, 27),
	(384, 'james', 'right_green_arrow.jpg', NULL, '2013-01-12 20:13:23', 'green.jpg', NULL, 52, 5, 26),
	(385, 'End', 'right_green_arrow.jpg', NULL, '2013-01-12 20:13:23', 'end_green.jpg', NULL, 52, 5, 27),
	(386, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-14 17:52:28', 'green.jpg', NULL, 54, 5, 24),
	(387, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-14 17:53:52', 'green.jpg', NULL, 54, 5, 26),
	(388, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-14 17:52:50', 'green.jpg', NULL, 55, 5, 24),
	(389, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-22 17:35:09', 'green.jpg', NULL, 55, 5, 26),
	(390, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-14 17:53:07', 'green.jpg', NULL, 56, 5, 24),
	(391, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-17 17:35:52', 'green.jpg', NULL, 56, 5, 26),
	(392, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-14 17:53:21', 'green.jpg', NULL, 57, 5, 24),
	(393, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-15 18:12:28', 'green.jpg', NULL, 57, 5, 26),
	(394, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-14 17:53:35', 'green.jpg', NULL, 58, 5, 24),
	(395, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-18 17:36:03', 'green.jpg', NULL, 58, 5, 26),
	(396, 'End', 'right_green_arrow.jpg', NULL, '2013-01-14 17:53:52', 'end_green.jpg', NULL, 54, 5, 27),
	(397, 'End', 'right_green_arrow.jpg', NULL, '2013-01-15 18:12:28', 'end_green.jpg', NULL, 57, 5, 27),
	(398, 'wendy', 'right_green_arrow.jpg', '5c4709ce4b164bcc879070a0628a10a2.docx', '2013-01-16 15:00:45', 'active.gif', NULL, 6, 2, 16),
	(399, 'sherry', 'left_yellow_arrow_.jpg', NULL, '2013-02-23 12:49:34', 'yellow.jpg', '驳回,ff', 6, 5, 17),
	(400, 'End', 'right_green_arrow.jpg', NULL, '2013-01-17 17:35:52', 'end_green.jpg', NULL, 56, 5, 27),
	(401, 'End', 'right_green_arrow.jpg', NULL, '2013-01-18 17:36:03', 'end_green.jpg', NULL, 58, 5, 27),
	(402, 'wendy', 'right_green_arrow.jpg', '', '2013-01-19 16:40:21', 'green.jpg', NULL, 59, 5, 24),
	(403, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-19 16:43:23', 'green.jpg', NULL, 59, 5, 26),
	(404, 'End', 'right_green_arrow.jpg', NULL, '2013-01-19 16:42:57', 'end_green.jpg', NULL, 25, 5, 27),
	(405, 'End', 'right_green_arrow.jpg', NULL, '2013-01-19 16:43:06', 'end_green.jpg', NULL, 26, 5, 27),
	(406, 'End', 'right_green_arrow.jpg', NULL, '2013-01-19 16:43:15', 'end_green.jpg', NULL, 46, 5, 27),
	(407, 'End', 'right_green_arrow.jpg', NULL, '2013-01-19 16:43:23', 'end_green.jpg', NULL, 59, 5, 27),
	(408, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-01-19 19:53:53', 'green.jpg', NULL, 60, 5, 24),
	(409, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-19 19:54:04', 'green.jpg', NULL, 60, 5, 26),
	(410, 'End', 'right_green_arrow.jpg', NULL, '2013-01-19 19:54:04', 'end_green.jpg', NULL, 60, 5, 27),
	(411, 'End', 'right_green_arrow.jpg', NULL, '2013-01-21 17:36:31', 'end_green.jpg', NULL, 36, 5, 27),
	(412, 'End', 'right_green_arrow.jpg', NULL, '2013-01-22 17:35:09', 'end_green.jpg', NULL, 55, 5, 27),
	(413, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-23 11:14:16', 'green.jpg', NULL, 51, 5, 24),
	(415, 'james', 'right_green_arrow.jpg', NULL, '2013-01-23 11:06:07', 'green.jpg', NULL, 61, 5, 22),
	(416, 'james', 'right_green_arrow.jpg', NULL, '2013-01-23 11:17:56', 'green.jpg', NULL, 61, 5, 23),
	(417, 'james', 'right_green_arrow.jpg', NULL, '2013-01-23 11:06:24', 'green.jpg', NULL, 62, 5, 22),
	(418, 'james', 'right_green_arrow.jpg', NULL, '2013-01-23 11:06:51', 'green.jpg', NULL, 62, 5, 23),
	(419, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-24 17:14:41', 'green.jpg', NULL, 62, 5, 24),
	(420, 'james', 'right_green_arrow.jpg', NULL, '2013-01-23 11:15:03', 'green.jpg', NULL, 51, 5, 26),
	(421, 'End', 'right_green_arrow.jpg', NULL, '2013-01-23 11:15:03', 'end_green.jpg', NULL, 51, 5, 27),
	(422, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-25 16:34:57', 'green.jpg', NULL, 61, 5, 24),
	(423, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-23 11:40:13', 'green.jpg', NULL, 63, 5, 24),
	(424, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-23 11:42:17', 'green.jpg', NULL, 63, 5, 26),
	(426, 'End', 'right_green_arrow.jpg', NULL, '2013-01-23 11:42:17', 'end_green.jpg', NULL, 63, 5, 27),
	(427, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-23 11:42:44', 'green.jpg', NULL, 64, 5, 23),
	(428, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-01-24 17:14:02', 'green.jpg', NULL, 64, 5, 24),
	(429, 'jason', 'right_green_arrow.jpg', NULL, '2013-01-23 16:24:22', 'green.jpg', NULL, 7, 5, 10),
	(430, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2013-01-23 16:41:52', 'green.jpg', NULL, 7, 5, 11),
	(431, 'james', 'right_green_arrow.jpg', 'sqe_james@sqeservice.com', '2013-01-23 16:44:13', 'green.jpg', NULL, 7, 5, 12),
	(432, 'james', 'right_green_arrow.jpg', 'sqe_james@sqeservice.com', '2013-01-23 16:45:02', 'green.jpg', NULL, 6, 5, 12),
	(433, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2013-03-02 17:26:04', 'green.jpg', NULL, 7, 5, 13),
	(434, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2013-03-09 14:01:17', 'green.jpg', NULL, 6, 5, 13),
	(435, 'james', 'right_green_arrow.jpg', 'sqe_james@sqeservice.com', '2013-01-23 16:45:57', 'green.jpg', NULL, 4, 5, 12),
	(436, 'admin', 'right_green_arrow.jpg', 'gom-admin@sqeservice.com', '2013-03-04 15:38:06', 'green.jpg', NULL, 4, 5, 13),
	(437, 'wendy', 'right_green_arrow.jpg', '', '2013-01-23 17:33:05', 'green.jpg', NULL, 65, 5, 24),
	(438, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:55:37', 'green.jpg', NULL, 65, 5, 26),
	(439, 'wendy', 'right_green_arrow.jpg', '', '2013-01-23 17:35:06', 'green.jpg', NULL, 66, 5, 24),
	(440, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-23 17:35:06', 'active.gif', NULL, 66, 2, 26),
	(441, 'wendy', 'right_green_arrow.jpg', '', '2013-01-23 17:36:04', 'green.jpg', NULL, 67, 5, 24),
	(442, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-23 17:36:04', 'active.gif', NULL, 67, 2, 26),
	(443, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:35:19', 'green.jpg', NULL, 64, 5, 26),
	(444, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:35:24', 'green.jpg', NULL, 62, 5, 26),
	(445, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:37', 'green.jpg', NULL, 61, 5, 26),
	(446, 'End', 'right_green_arrow.jpg', NULL, '2013-01-25 16:35:19', 'end_green.jpg', NULL, 64, 5, 27),
	(447, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:35:19', 'green.jpg', NULL, 68, 5, 23),
	(448, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-02-18 17:52:09', 'green.jpg', NULL, 68, 5, 24),
	(449, 'End', 'right_green_arrow.jpg', NULL, '2013-01-25 16:35:24', 'end_green.jpg', NULL, 62, 5, 27),
	(450, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-25 16:42:22', 'green.jpg', '批准,1111111111111111111111111111', 37, 5, 28),
	(451, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:43:59', 'red.jpg', '拒绝,拒绝', 37, 5, 29),
	(452, 'End', 'right_red_arrow.jpg', NULL, '2013-01-25 16:43:59', 'end_red.jpg', '你的申请被拒绝', 37, 5, 32),
	(453, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-25 16:45:33', 'green.jpg', '批准,要', 38, 5, 28),
	(454, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:45:42', 'red.jpg', '拒绝,拒绝', 38, 5, 29),
	(455, 'End', 'right_red_arrow.jpg', NULL, '2013-01-25 16:45:42', 'end_red.jpg', '你的申请被拒绝', 38, 5, 32),
	(456, 'wendy', 'right_green_arrow.jpg', NULL, '2013-01-25 16:49:11', 'green.jpg', '批准,顶替', 39, 5, 28),
	(457, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:49:23', 'red.jpg', '拒绝,拒绝', 39, 5, 29),
	(458, 'End', 'right_red_arrow.jpg', NULL, '2013-01-25 16:49:23', 'end_red.jpg', '你的申请被拒绝', 39, 5, 32),
	(459, 'wendy', 'right_green_arrow.jpg', '', '2013-01-25 16:52:26', 'green.jpg', NULL, 69, 5, 24),
	(460, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:54:20', 'green.jpg', NULL, 69, 5, 26),
	(461, 'wendy', 'right_green_arrow.jpg', '', '2013-01-25 16:53:24', 'green.jpg', NULL, 70, 5, 24),
	(462, 'sherry', 'right_green_arrow.jpg', NULL, '2013-01-25 16:53:24', 'active.gif', NULL, 70, 2, 26),
	(463, 'End', 'right_green_arrow.jpg', NULL, '2013-01-25 16:54:20', 'end_green.jpg', NULL, 69, 5, 27),
	(464, 'End', 'right_green_arrow.jpg', NULL, '2013-01-25 16:54:39', 'end_green.jpg', NULL, 37, 5, 27),
	(465, 'End', 'right_green_arrow.jpg', NULL, '2013-01-25 16:55:37', 'end_green.jpg', NULL, 65, 5, 27),
	(466, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:43', 'green.jpg', NULL, 68, 5, 26),
	(467, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-02-18 17:52:30', 'green.jpg', NULL, 71, 5, 24),
	(468, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:47', 'green.jpg', NULL, 71, 5, 26),
	(469, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-02-18 17:52:46', 'green.jpg', NULL, 72, 5, 24),
	(470, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-18 17:52:46', 'active.gif', NULL, 72, 2, 26),
	(471, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-02-18 17:53:14', 'green.jpg', NULL, 73, 5, 24),
	(472, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:14', 'active.gif', NULL, 73, 2, 26),
	(473, 'End', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:37', 'end_green.jpg', NULL, 61, 5, 27),
	(474, 'End', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:43', 'end_green.jpg', NULL, 68, 5, 27),
	(475, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:43', 'green.jpg', NULL, 74, 5, 23),
	(476, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-02-19 17:27:54', 'green.jpg', NULL, 74, 5, 24),
	(477, 'End', 'right_green_arrow.jpg', NULL, '2013-02-18 17:53:47', 'end_green.jpg', NULL, 71, 5, 27),
	(490, 'sherry', 'right_green_arrow.jpg', '', '2013-02-19 16:22:43', 'green.jpg', NULL, 76, 5, 24),
	(491, 'wendy', 'right_green_arrow.jpg', NULL, '2013-02-19 16:24:21', 'green.jpg', NULL, 76, 5, 26),
	(492, 'wendy', 'right_green_arrow.jpg', NULL, '2013-02-19 16:22:57', 'green.jpg', NULL, 40, 5, 28),
	(493, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-23 11:46:08', 'green.jpg', '批准,批准', 40, 5, 29),
	(494, 'End', 'right_green_arrow.jpg', NULL, '2013-02-19 16:24:21', 'end_green.jpg', NULL, 76, 5, 27),
	(495, 'wendy', 'right_green_arrow.jpg', NULL, '2013-02-19 16:28:32', 'green.jpg', NULL, 41, 5, 28),
	(496, NULL, 'right_green_arrow.jpg', NULL, '2013-02-19 16:28:32', 'active.gif', NULL, 41, 2, 29),
	(497, 'james', 'right_green_arrow.jpg', NULL, '2013-02-19 16:55:47', 'green.jpg', NULL, 77, 5, 22),
	(498, 'james', 'right_green_arrow.jpg', NULL, '2013-02-19 16:57:53', 'green.jpg', NULL, 77, 5, 23),
	(499, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-19 16:57:53', 'active.gif', NULL, 77, 2, 24),
	(500, 'james', 'right_green_arrow.jpg', NULL, '2013-02-19 17:03:06', 'green.jpg', NULL, 78, 5, 22),
	(501, 'james', 'right_green_arrow.jpg', NULL, '2013-02-19 17:06:02', 'green.jpg', NULL, 78, 5, 23),
	(502, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-19 17:06:02', 'active.gif', NULL, 78, 2, 24),
	(503, 'james', 'right_green_arrow.jpg', NULL, '2013-02-19 17:08:47', 'green.jpg', NULL, 79, 5, 22),
	(504, 'james', 'right_green_arrow.jpg', NULL, '2013-02-19 17:11:24', 'green.jpg', NULL, 79, 5, 23),
	(505, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-19 17:11:24', 'active.gif', NULL, 79, 2, 24),
	(506, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-19 17:28:22', 'green.jpg', NULL, 74, 5, 26),
	(507, 'End', 'right_green_arrow.jpg', NULL, '2013-02-19 17:28:22', 'end_green.jpg', NULL, 74, 5, 27),
	(508, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-19 17:28:22', 'green.jpg', NULL, 80, 5, 23),
	(509, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-02-19 17:28:22', 'active.gif', NULL, 80, 2, 24),
	(510, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-02-23 10:53:09', 'green.jpg', NULL, 7, 5, 16),
	(511, 'wendy', 'right_green_arrow.jpg', NULL, '2013-02-23 10:54:21', 'green.jpg', '批准,好的', 7, 5, 17),
	(512, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-23 10:54:45', 'green.jpg', '批准,好的', 7, 5, 18),
	(513, 'End', 'right_green_arrow.jpg', NULL, '2013-02-23 10:54:45', 'end_green.jpg', NULL, 7, 5, 20),
	(514, 'wendy', 'right_green_arrow.jpg', NULL, '2013-02-23 11:22:49', 'green.jpg', '批准,出问题了\r\n', 42, 5, 28),
	(515, 'james', 'right_green_arrow.jpg', NULL, '2013-02-23 11:26:45', 'green.jpg', NULL, 42, 5, 28),
	(516, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-02-23 11:26:45', 'active.gif', NULL, 42, 2, 30),
	(517, 'james', 'right_green_arrow.jpg', NULL, '2013-02-23 11:45:35', 'green.jpg', NULL, 36, 5, 28),
	(518, 'sherry', 'right_green_arrow.jpg', NULL, '2013-02-23 11:45:57', 'green.jpg', '批准,批准', 36, 5, 30),
	(519, 'End', 'right_green_arrow.jpg', NULL, '2013-02-23 11:45:57', 'end_green.jpg', NULL, 36, 5, 31),
	(520, 'End', 'right_green_arrow.jpg', NULL, '2013-02-23 11:46:08', 'end_green.jpg', NULL, 40, 5, 31),
	(521, 'admin', 'right_green_arrow.jpg', NULL, '2013-02-23 15:20:09', 'active.gif', NULL, 2, 2, 7),
	(522, 'End', 'right_green_arrow.jpg', NULL, '2013-03-02 17:26:04', 'end_green.jpg', NULL, 7, 5, 15),
	(523, 'End', 'right_green_arrow.jpg', NULL, '2013-03-04 15:38:06', 'end_green.jpg', NULL, 4, 5, 15),
	(524, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:33:46', 'green.jpg', NULL, 81, 5, 22),
	(525, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:35:15', 'green.jpg', NULL, 81, 5, 23),
	(526, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:34:02', 'green.jpg', NULL, 82, 5, 22),
	(527, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:35:48', 'green.jpg', NULL, 82, 5, 23),
	(528, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:34:18', 'green.jpg', NULL, 83, 5, 22),
	(529, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:35:33', 'green.jpg', NULL, 83, 5, 23),
	(530, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:34:37', 'green.jpg', NULL, 84, 5, 22),
	(531, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-09 12:35:22', 'green.jpg', NULL, 84, 5, 23),
	(532, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:05', 'green.jpg', NULL, 81, 5, 24),
	(533, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:12', 'green.jpg', NULL, 85, 5, 24),
	(534, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-23 16:13:30', 'green.jpg', NULL, 84, 5, 24),
	(535, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-09 12:35:33', 'active.gif', NULL, 83, 2, 24),
	(536, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-22 17:25:13', 'green.jpg', NULL, 82, 5, 24),
	(537, 'End', 'right_green_arrow.jpg', NULL, '2013-03-09 14:01:17', 'end_green.jpg', NULL, 6, 5, 15),
	(538, 'james', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:34', 'green.jpg', NULL, 81, 5, 26),
	(539, 'james', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:29', 'green.jpg', NULL, 85, 5, 26),
	(540, 'End', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:29', 'end_green.jpg', NULL, 85, 5, 27),
	(541, 'james', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:29', 'green.jpg', NULL, 86, 5, 23),
	(542, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:50', 'green.jpg', NULL, 86, 5, 24),
	(543, 'End', 'right_green_arrow.jpg', NULL, '2013-03-12 17:32:34', 'end_green.jpg', NULL, 81, 5, 27),
	(544, 'james', 'right_green_arrow.jpg', NULL, '2013-03-12 17:33:01', 'green.jpg', NULL, 86, 5, 26),
	(545, 'End', 'right_green_arrow.jpg', NULL, '2013-03-12 17:33:01', 'end_green.jpg', NULL, 86, 5, 27),
	(546, 'james', 'right_green_arrow.jpg', NULL, '2013-03-12 17:33:01', 'green.jpg', NULL, 87, 5, 23),
	(547, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-12 17:33:01', 'active.gif', NULL, 87, 2, 24),
	(548, 'ssah', 'right_green_arrow.jpg', NULL, '2013-03-13 15:57:00', 'green.jpg', NULL, 11, 5, 10),
	(549, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-13 15:57:00', 'active.gif', NULL, 11, 2, 11),
	(550, 'oole', 'right_green_arrow.jpg', NULL, '2013-03-14 11:07:49', 'green.jpg', NULL, 12, 5, 10),
	(551, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-14 11:07:49', 'active.gif', NULL, 12, 2, 11),
	(552, 'yyes', 'right_green_arrow.jpg', NULL, '2013-03-14 11:16:04', 'green.jpg', NULL, 13, 5, 10),
	(553, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-14 11:16:04', 'active.gif', NULL, 13, 2, 11),
	(554, 'uuoe', 'right_green_arrow.jpg', NULL, '2013-03-14 11:39:19', 'green.jpg', NULL, 15, 5, 10),
	(555, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-14 11:39:19', 'active.gif', NULL, 15, 2, 11),
	(556, 'eeqr', 'right_green_arrow.jpg', NULL, '2013-03-14 11:45:43', 'green.jpg', NULL, 17, 5, 10),
	(557, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-14 11:45:43', 'active.gif', NULL, 17, 2, 11),
	(558, 'eeqr2', 'right_green_arrow.jpg', NULL, '2013-03-14 11:53:43', 'green.jpg', NULL, 18, 5, 10),
	(559, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-14 11:53:43', 'active.gif', NULL, 18, 2, 11),
	(566, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-16 11:10:11', 'green.jpg', NULL, 7, 5, 1),
	(567, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-16 11:37:13', 'green.jpg', '批准,dsaf', 7, 5, 2),
	(568, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-16 11:37:27', 'green.jpg', '批准,sdf', 7, 5, 3),
	(569, 'sherry', 'right_green_arrow.jpg', '87e740bc67d7495198fdf49c83ca6d8b.doc', '2013-03-16 11:37:50', 'green.jpg', '批准,dfsfd', 7, 5, 4),
	(570, 'sherry', 'right_green_arrow.jpg', '87e740bc67d7495198fdf49c83ca6d8b.doc', '2013-03-16 11:38:00', 'green.jpg', '批准,sdf', 7, 5, 5),
	(571, 'sherry', 'right_green_arrow.jpg', '87e740bc67d7495198fdf49c83ca6d8b.doc', '2013-03-16 11:38:50', 'green.jpg', '批准,调整工作接收人职责比重', 7, 5, 6),
	(572, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-16 11:39:55', 'green.jpg', '批准,sqe_ole的电脑密码：', 7, 5, 7),
	(573, 'End', 'right_green_arrow.jpg', NULL, '2013-03-16 11:39:55', 'end_green.jpg', NULL, 7, 5, 9),
	(584, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-16 14:33:09', 'green.jpg', NULL, 88, 5, 24),
	(585, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-28 17:10:04', 'green.jpg', NULL, 88, 5, 26),
	(586, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-16 15:13:31', 'green.jpg', NULL, 89, 5, 24),
	(587, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-28 17:10:11', 'green.jpg', NULL, 89, 5, 26),
	(588, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-16 15:42:48', 'green.jpg', NULL, 90, 5, 24),
	(589, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-28 17:10:20', 'green.jpg', NULL, 90, 5, 26),
	(590, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-16 15:54:13', 'green.jpg', NULL, 91, 5, 22),
	(591, 'Allocation', 'right_green_arrow.jpg', NULL, '2013-03-16 15:54:13', 'active.gif', NULL, 91, 2, 23),
	(592, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-21 10:36:21', 'green.jpg', '批准,星期四异常！', 43, 5, 28),
	(593, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-21 10:43:24', 'green.jpg', '批准,批准', 43, 5, 29),
	(594, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-21 10:43:00', 'green.jpg', '批准,sherry载波异常1', 44, 5, 28),
	(595, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-21 10:43:00', 'active.gif', NULL, 44, 2, 29),
	(596, 'End', 'right_green_arrow.jpg', NULL, '2013-03-21 10:43:24', 'end_green.jpg', NULL, 43, 5, 31),
	(597, 'sqe_ole', 'right_green_arrow.jpg', NULL, '2013-03-21 11:40:18', 'green.jpg', '批准,大家好，我不好！', 45, 5, 28),
	(598, 'sherry', 'right_green_arrow.jpg', NULL, '2013-03-21 11:40:18', 'active.gif', NULL, 45, 2, 29),
	(599, 'james', 'right_green_arrow.jpg', NULL, '2013-03-22 17:25:57', 'green.jpg', NULL, 82, 5, 26),
	(600, 'End', 'right_green_arrow.jpg', NULL, '2013-03-22 17:25:57', 'end_green.jpg', NULL, 82, 5, 27),
	(601, 'james', 'right_green_arrow.jpg', NULL, '2013-03-23 18:00:29', 'green.jpg', NULL, 84, 5, 26),
	(602, 'End', 'right_green_arrow.jpg', NULL, '2013-03-23 18:00:29', 'end_green.jpg', NULL, 84, 5, 27),
	(603, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-25 17:04:33', 'green.jpg', NULL, 92, 5, 24),
	(604, 'james', 'right_green_arrow.jpg', NULL, '2013-03-26 17:33:03', 'green.jpg', NULL, 92, 5, 26),
	(605, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-25 17:04:53', 'green.jpg', NULL, 93, 5, 24),
	(606, 'james', 'right_green_arrow.jpg', NULL, '2013-03-26 17:32:59', 'green.jpg', NULL, 93, 5, 26),
	(607, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-25 17:05:10', 'green.jpg', NULL, 94, 5, 24),
	(608, 'james', 'right_green_arrow.jpg', NULL, '2013-03-29 17:28:16', 'green.jpg', NULL, 94, 5, 26),
	(609, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-25 17:05:30', 'green.jpg', NULL, 95, 5, 24),
	(610, 'james', 'right_green_arrow.jpg', NULL, '2013-03-25 17:28:32', 'green.jpg', NULL, 95, 5, 26),
	(611, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-25 17:05:51', 'green.jpg', NULL, 96, 5, 24),
	(612, 'james', 'right_green_arrow.jpg', NULL, '2013-03-25 17:28:28', 'green.jpg', NULL, 96, 5, 26),
	(613, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-25 17:06:09', 'green.jpg', NULL, 97, 5, 24),
	(614, 'james', 'right_green_arrow.jpg', NULL, '2013-03-25 17:07:13', 'green.jpg', NULL, 97, 5, 26),
	(615, 'sqe_ole', 'right_green_arrow.jpg', '2131332', '2013-03-25 17:06:38', 'green.jpg', NULL, 98, 5, 24),
	(616, 'james', 'right_green_arrow.jpg', NULL, '2013-03-29 17:30:05', 'green.jpg', NULL, 98, 5, 26),
	(617, 'End', 'right_green_arrow.jpg', NULL, '2013-03-25 17:07:13', 'end_green.jpg', NULL, 97, 5, 27),
	(618, 'End', 'right_green_arrow.jpg', NULL, '2013-03-25 17:28:28', 'end_green.jpg', NULL, 96, 5, 27),
	(619, 'End', 'right_green_arrow.jpg', NULL, '2013-03-25 17:28:32', 'end_green.jpg', NULL, 95, 5, 27),
	(620, 'End', 'right_green_arrow.jpg', NULL, '2013-03-26 17:32:59', 'end_green.jpg', NULL, 93, 5, 27),
	(621, 'End', 'right_green_arrow.jpg', NULL, '2013-03-26 17:33:03', 'end_green.jpg', NULL, 92, 5, 27),
	(622, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-26 17:33:35', 'green.jpg', NULL, 99, 5, 24),
	(623, 'james', 'right_green_arrow.jpg', NULL, '2013-03-27 17:38:29', 'green.jpg', NULL, 99, 5, 26),
	(624, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-26 17:34:03', 'green.jpg', NULL, 100, 5, 24),
	(625, 'james', 'right_green_arrow.jpg', NULL, '2013-03-29 09:21:22', 'green.jpg', NULL, 100, 5, 26),
	(626, 'james', 'right_green_arrow.jpg', NULL, '2013-03-27 16:50:38', 'green.jpg', NULL, 46, 5, 28),
	(627, 'james', 'right_green_arrow.jpg', NULL, '2013-03-27 16:50:38', 'active.gif', NULL, 46, 2, 29),
	(628, 'End', 'right_green_arrow.jpg', NULL, '2013-03-27 17:38:29', 'end_green.jpg', NULL, 99, 5, 27),
	(629, 'End', 'right_green_arrow.jpg', NULL, '2013-03-28 17:10:04', 'end_green.jpg', NULL, 88, 5, 27),
	(630, 'End', 'right_green_arrow.jpg', NULL, '2013-03-28 17:10:11', 'end_green.jpg', NULL, 89, 5, 27),
	(631, 'End', 'right_green_arrow.jpg', NULL, '2013-03-28 17:10:20', 'end_green.jpg', NULL, 90, 5, 27),
	(632, 'End', 'right_green_arrow.jpg', NULL, '2013-03-29 09:21:22', 'end_green.jpg', NULL, 100, 5, 27),
	(633, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-29 17:26:51', 'green.jpg', NULL, 101, 5, 24),
	(634, 'james', 'right_green_arrow.jpg', NULL, '2013-03-29 17:26:51', 'active.gif', NULL, 101, 2, 26),
	(635, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-29 17:27:06', 'green.jpg', NULL, 102, 5, 24),
	(636, 'james', 'right_green_arrow.jpg', NULL, '2013-04-03 17:28:19', 'green.jpg', NULL, 102, 5, 26),
	(637, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-29 17:27:19', 'green.jpg', NULL, 103, 5, 24),
	(638, 'james', 'right_green_arrow.jpg', NULL, '2013-04-03 17:28:16', 'green.jpg', NULL, 103, 5, 26),
	(639, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-29 17:27:41', 'green.jpg', NULL, 104, 5, 24),
	(640, 'james', 'right_green_arrow.jpg', NULL, '2013-04-03 17:28:12', 'green.jpg', NULL, 104, 5, 26),
	(641, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-03-29 17:27:56', 'green.jpg', NULL, 105, 5, 24),
	(642, 'admin', 'right_green_arrow.jpg', NULL, '2013-03-29 17:27:56', 'active.gif', NULL, 105, 2, 26),
	(643, 'End', 'right_green_arrow.jpg', NULL, '2013-03-29 17:28:16', 'end_green.jpg', NULL, 94, 5, 27),
	(644, 'End', 'right_green_arrow.jpg', NULL, '2013-03-29 17:30:05', 'end_green.jpg', NULL, 98, 5, 27),
	(645, 'End', 'right_green_arrow.jpg', NULL, '2013-04-03 17:28:12', 'end_green.jpg', NULL, 104, 5, 27),
	(646, 'End', 'right_green_arrow.jpg', NULL, '2013-04-03 17:28:16', 'end_green.jpg', NULL, 103, 5, 27),
	(647, 'End', 'right_green_arrow.jpg', NULL, '2013-04-03 17:28:19', 'end_green.jpg', NULL, 102, 5, 27),
	(648, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-04-08 18:11:15', 'green.jpg', NULL, 106, 5, 24),
	(649, 'james', 'right_green_arrow.jpg', NULL, '2013-04-08 18:11:15', 'active.gif', NULL, 106, 2, 26),
	(650, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-04-08 18:11:33', 'green.jpg', NULL, 107, 5, 24),
	(651, 'admin', 'right_green_arrow.jpg', NULL, '2013-04-08 18:11:33', 'active.gif', NULL, 107, 2, 26),
	(652, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-04-08 18:11:50', 'green.jpg', NULL, 108, 5, 24),
	(653, 'james', 'right_green_arrow.jpg', NULL, '2013-04-08 18:11:50', 'active.gif', NULL, 108, 2, 26),
	(654, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-04-08 18:12:16', 'green.jpg', NULL, 109, 5, 24),
	(655, 'james', 'right_green_arrow.jpg', NULL, '2013-04-08 18:20:15', 'green.jpg', NULL, 109, 5, 26),
	(656, 'sqe_ole', 'right_green_arrow.jpg', '', '2013-04-08 18:12:39', 'green.jpg', NULL, 110, 5, 24),
	(657, 'james', 'right_green_arrow.jpg', NULL, '2013-04-08 18:20:10', 'green.jpg', NULL, 110, 5, 26),
	(658, 'End', 'right_green_arrow.jpg', NULL, '2013-04-08 18:20:10', 'end_green.jpg', NULL, 110, 5, 27),
	(659, 'End', 'right_green_arrow.jpg', NULL, '2013-04-08 18:20:15', 'end_green.jpg', NULL, 109, 5, 27);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.training: ~4 rows (approximately)
/*!40000 ALTER TABLE `training` DISABLE KEYS */;
INSERT INTO `training` (`id`, `endDate`, `fee`, `lecturer`, `otherFee`, `qualification`, `startDate`, `tcontent`, `tprogram`, `trainingTime`, `trainingType`) VALUES
	(1, '2012-09-30', 0, 'james', 0, '高级', '2012-09-01', '公司内部对员工进行内部做开发管理培训！', '软件开发规范', 12, 0),
	(2, '2013-01-06', 100, 'wendy', 20, '高级', '2013-01-05', '日常操作', 'GOM操作', 2, 0),
	(3, '2013-01-26', 12, 'wendy', 12, '中级', '2013-01-25', '培训课程培训课程培训课程', '培训课程', 12, 0),
	(4, '2013-02-09', 20.5, 'james', 2.5, '顶替', '2013-02-09', '顶替夺地', '工作识破', 2.5, 0);
/*!40000 ALTER TABLE `training` ENABLE KEYS */;


-- Dumping structure for table gom.ugroup
CREATE TABLE IF NOT EXISTS `ugroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) NOT NULL,
  `ename` varchar(15) NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

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

-- Dumping data for table gom.usergroup: ~39 rows (approximately)
/*!40000 ALTER TABLE `usergroup` DISABLE KEYS */;
INSERT INTO `usergroup` (`uid`, `gid`) VALUES
	(1, 2),
	(1, 5),
	(1, 10),
	(2, 1),
	(2, 3),
	(2, 6),
	(3, 1),
	(3, 5),
	(3, 7),
	(4, 1),
	(4, 5),
	(4, 9),
	(5, 1),
	(5, 3),
	(5, 9),
	(6, 1),
	(6, 4),
	(6, 10),
	(7, 1),
	(7, 5),
	(7, 9),
	(11, 1),
	(11, 3),
	(11, 6),
	(12, 1),
	(12, 3),
	(12, 6),
	(13, 1),
	(13, 4),
	(13, 7),
	(15, 1),
	(15, 3),
	(15, 7),
	(17, 1),
	(17, 3),
	(17, 6),
	(18, 1),
	(18, 3),
	(18, 6);
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
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.userresp: ~24 rows (approximately)
/*!40000 ALTER TABLE `userresp` DISABLE KEYS */;
INSERT INTO `userresp` (`id`, `expected`, `node`, `resp_user_fk`, `user_resp_fk`) VALUES
	(121, 40, '1', 25, 4),
	(122, 20, '1.1', 26, 4),
	(123, 30, '1.2', 27, 4),
	(124, 10, '1.3', 28, 4),
	(125, 20, '1.4', 29, 4),
	(126, 20, '1.5', 30, 4),
	(127, 20, '2', 7, 4),
	(128, 20, '2.1', 8, 4),
	(129, 10, '2.2', 9, 4),
	(130, 20, '2.3', 10, 4),
	(131, 30, '2.4', 11, 4),
	(132, 20, '2.5', 12, 4),
	(133, 10, '3', 13, 4),
	(134, 20, '3.1', 14, 4),
	(135, 20, '3.2', 15, 4),
	(136, 20, '3.3', 16, 4),
	(137, 20, '3.4', 17, 4),
	(138, 20, '3.5', 18, 4),
	(139, 30, '4', 19, 4),
	(140, 20, '4.1', 20, 4),
	(141, 30, '4.2', 21, 4),
	(142, 30, '4.3', 22, 4),
	(143, 10, '4.4', 23, 4),
	(144, 10, '4.5', 24, 4);
/*!40000 ALTER TABLE `userresp` ENABLE KEYS */;


-- Dumping structure for table gom.usertree
CREATE TABLE IF NOT EXISTS `usertree` (
  `uid` int(10) unsigned NOT NULL,
  `zid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uid`,`zid`),
  KEY `user_ztree_FK` (`uid`),
  KEY `ztree_user_FK` (`zid`),
  CONSTRAINT `user_ztree_FK` FOREIGN KEY (`uid`) REFERENCES `guser` (`id`),
  CONSTRAINT `ztree_user_FK` FOREIGN KEY (`zid`) REFERENCES `ztree` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table gom.usertree: ~174 rows (approximately)
/*!40000 ALTER TABLE `usertree` DISABLE KEYS */;
INSERT INTO `usertree` (`uid`, `zid`) VALUES
	(0, 9),
	(0, 17),
	(0, 18),
	(0, 23),
	(0, 24),
	(0, 32),
	(0, 36),
	(0, 37),
	(0, 40),
	(0, 41),
	(0, 42),
	(0, 43),
	(0, 45),
	(0, 46),
	(0, 60),
	(0, 61),
	(0, 64),
	(0, 67),
	(1, 22),
	(1, 47),
	(1, 48),
	(1, 49),
	(1, 50),
	(1, 51),
	(1, 52),
	(1, 53),
	(1, 54),
	(1, 55),
	(1, 56),
	(1, 57),
	(1, 58),
	(1, 62),
	(1, 63),
	(1, 68),
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(2, 6),
	(2, 7),
	(2, 10),
	(2, 11),
	(2, 12),
	(2, 13),
	(2, 14),
	(2, 16),
	(2, 20),
	(2, 21),
	(2, 25),
	(2, 26),
	(2, 38),
	(2, 65),
	(2, 66),
	(3, 1),
	(3, 2),
	(3, 4),
	(3, 6),
	(3, 7),
	(3, 8),
	(3, 10),
	(3, 11),
	(3, 12),
	(3, 13),
	(3, 14),
	(3, 15),
	(3, 16),
	(3, 19),
	(3, 20),
	(3, 21),
	(3, 22),
	(3, 25),
	(3, 26),
	(3, 27),
	(3, 29),
	(3, 30),
	(3, 31),
	(3, 33),
	(3, 35),
	(3, 38),
	(3, 47),
	(3, 52),
	(3, 53),
	(3, 59),
	(3, 63),
	(3, 65),
	(3, 66),
	(4, 1),
	(4, 2),
	(4, 4),
	(4, 5),
	(4, 6),
	(4, 7),
	(4, 8),
	(4, 10),
	(4, 11),
	(4, 12),
	(4, 13),
	(4, 14),
	(4, 15),
	(4, 16),
	(4, 19),
	(4, 20),
	(4, 21),
	(4, 22),
	(4, 25),
	(4, 26),
	(4, 27),
	(4, 29),
	(4, 30),
	(4, 31),
	(4, 33),
	(4, 35),
	(4, 38),
	(4, 47),
	(4, 48),
	(4, 49),
	(4, 50),
	(4, 51),
	(4, 52),
	(4, 53),
	(4, 54),
	(4, 55),
	(4, 56),
	(4, 57),
	(4, 58),
	(4, 59),
	(4, 62),
	(4, 63),
	(4, 65),
	(4, 66),
	(4, 68),
	(5, 2),
	(5, 3),
	(5, 4),
	(5, 5),
	(5, 10),
	(5, 11),
	(5, 12),
	(5, 13),
	(5, 14),
	(5, 16),
	(5, 25),
	(5, 26),
	(5, 38),
	(6, 2),
	(6, 3),
	(6, 4),
	(6, 5),
	(6, 6),
	(6, 7),
	(6, 10),
	(6, 11),
	(6, 12),
	(6, 13),
	(6, 14),
	(6, 16),
	(6, 20),
	(6, 21),
	(6, 25),
	(6, 26),
	(6, 29),
	(6, 31),
	(6, 33),
	(6, 38),
	(6, 52),
	(6, 53),
	(6, 54),
	(6, 55),
	(6, 57),
	(6, 58),
	(6, 59),
	(6, 62),
	(6, 63),
	(6, 65);
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
  `menuType` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Z_PARENTID` (`parentid`),
  CONSTRAINT `FK_Z_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `ztree` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- Dumping data for table gom.ztree: ~68 rows (approximately)
/*!40000 ALTER TABLE `ztree` DISABLE KEYS */;
INSERT INTO `ztree` (`id`, `ico`, `name`, `node`, `position`, `role`, `title`, `url`, `parentid`, `menuType`) VALUES
	(1, '', '审批中心', '1', 'Employee', 'User', 'Task center of user', 'index.htm', NULL, 0),
	(2, '', '会议记录', '1.1', 'Employee', 'User', 'Meeting Information', 'meeting.htm', 1, 1),
	(3, '', '待批请假', '1.2', 'Employee', 'User', 'The leave waitting for approve', 'approving_leaves.htm', 1, 0),
	(4, '', '待批申领', '1.3', 'Manager', 'User', 'For approval to claim', 'approving_asset.htm', 1, 1),
	(5, '', '开设邮箱', '1.4', 'Employee', 'User', 'Email for new staff', 'set_mail.htm', 1, 1),
	(6, '', '入职审核', '1.5', 'Director', 'User', 'Review the new employee inform', 'check_entrant.htm', 1, 1),
	(7, '', '离职审核', '1.6', 'Director', 'User', 'Departure Audit', 'check_departure.htm', 1, 1),
	(8, '', '工作管理', '2', 'Employee', 'User', 'WorkTask management', '', NULL, 0),
	(9, '', '我的任务', '2.1', 'Employee', 'User', 'My Task', 'my_task.htm', 8, 0),
	(10, '', '添加任务', '2.2', 'Manager', 'User', 'Work Task', 'add_task.htm', 8, 1),
	(11, '', '工作分配', '2.3', 'Director', 'User', 'Work Task Order', 'order_task.htm', 8, 1),
	(12, '', '追踪执行', '2.4', 'Director', 'User', 'Execution Trace', 'track_task.htm', 8, 1),
	(13, '', '固定工作', '2.5', 'Employee', 'User', 'Fixed Task', 'fixed_task.htm', 8, 1),
	(14, '', '需要帮忙', '2.6', 'Employee', 'User', 'Need Help', 'needing_help.htm', 8, 1),
	(15, '', '培训管理', '3', 'Employee', 'User', 'Training management', '', NULL, 0),
	(16, '', '人力培训', '3.1', 'Manager', 'User', 'Human training', 'training.htm', 15, 1),
	(17, '', '心得收获', '3.2', 'Employee', 'User', 'Experience harvest', 'harvest.htm', 15, 0),
	(18, '', '如何做', '3.3', 'Employee', 'User', 'How to do', 'howtodo.htm', 15, 0),
	(19, '', '项目管理', '4', 'Manager', 'User', 'System management', '', NULL, 1),
	(20, '', '项目', '4.1', 'Manager', 'User', 'Project management', 'project.htm', 19, 1),
	(21, '', '产品', '4.2', 'Manager', 'User', 'Product management', 'product.htm', 19, 1),
	(22, '', '资产管理', '5', 'Employee', 'User', 'Asset Management', 'asset.htm', NULL, 0),
	(23, '', '物资申请', '5.1', 'Employee', 'User', 'Material apply for', 'apply_asset.htm', 22, 0),
	(24, '', '申领回执', '5.2', 'Employee', 'User', 'For receipt', 'receipt_asset.htm', 22, 0),
	(25, '', '资产管理', '5.3', 'Manager', 'User', 'Assets list', 'asset_config.htm', 22, 1),
	(26, '', '领用记录', '5.4', 'Manager', 'User', 'Use record', 'borrow_records.htm', 22, 1),
	(27, '', '文管中心', '6', 'Employee', 'User', 'File management', '', NULL, 0),
	(28, '', '文件管理', '6.1', 'Employee', 'User', 'File management', 'resource.htm', 27, 0),
	(29, '', '分组', '6.2', 'Employee', 'User', 'Category management', 'resource_category.htm', 27, 1),
	(30, '', '责任管理', '7', 'Employee', 'User', 'Responsibility management', '', NULL, 0),
	(31, '', '责任管理', '7.1', 'Director', 'User', 'Responsibility management', 'respons_config.htm', 30, 1),
	(32, '', '我的责任', '7.2', 'Employee', 'User', 'User Responsibility', 'my_respons.htm', 30, 0),
	(33, '', '主管分配', '7.3', 'Manager', 'User', 'Responsibility Config', 'supervisor_respons.htm', 30, 1),
	(34, '', '私人秘书', '8', 'Employee', 'User', 'Personal secretary', '', NULL, 0),
	(35, '', '请假', '8.1', 'Employee', 'User', 'user leave', '', 34, 0),
	(36, '', '申请', '8.1.1', 'Employee', 'User', 'user for leave', 'leave.htm', 35, 0),
	(37, '', '回执', '8.1.2', 'Employee', 'User', 'receipt for leave', 'leave.htm', 35, 0),
	(38, '', '记录', '8.1.3', 'Employee', 'User', 'record for leave', 'leave_records.htm', 35, 1),
	(39, '', '个人资料', '8.2', 'Employee', 'User', 'update user information', '', 34, 0),
	(40, '', '基本信息', '8.2.1', 'Employee', 'User', 'user basic information', 'edit_user.htm', 39, 0),
	(41, '', '教育经历', '8.2.2', 'Employee', 'User', 'Education for user', 'education.htm', 39, 0),
	(42, '', '地址列表', '8.2.3', 'Employee', 'User', 'list of address for user', 'address.htm', 39, 0),
	(43, '', '修改密码', '8.2.4', 'Employee', 'User', 'update user password', 'update_pwd.htm', 39, 0),
	(44, '', '离职', '9', 'Employee', 'User', 'Departure Application', '', NULL, 0),
	(45, '', '申请', '9.1', 'Employee', 'User', 'Departure Application', 'departure.htm', 44, 0),
	(46, '', '回执', '9.2', 'Employee', 'User', 'Departure Receipt', 'departure.htm', 44, 0),
	(47, '', '系统管理', '10', 'Manager', 'Admin', 'Manager the system user', '', NULL, 1),
	(48, '', '左侧菜单', '10.1', 'Manager', 'Admin', 'The left side menu', '', 47, 1),
	(49, '', '全局配置', '10.1.1', 'Manager', 'Admin', 'All Menu Global configuration', 'trees.htm', 48, 1),
	(50, '', '通用配置', '10.1.2', 'Manager', 'Admin', 'Basic Menu configuratio', 'basic_tree.htm', 48, 1),
	(51, '', '用户定制', '10.1.3', 'Manager', 'Admin', 'User Menu configuration', 'tree_config.htm', 48, 1),
	(52, '', '用户配置', '10.2', 'Manager', 'Admin', 'Users Config management', 'user_config.htm', 47, 1),
	(53, '', '系统参数', '10.3', 'Manager', 'Admin', 'config the system parameter', 'config.htm', 47, 1),
	(54, '', '组管理', '10.4', 'Manager', 'Admin', 'System of Group Manager', 'group_config.htm', 47, 1),
	(55, '', '用户清单', '10.5', 'Manager', 'Admin', 'Basic information', 'list_users.htm', 47, 1),
	(56, '', '流程配置', '10.6', 'Manager', 'Admin', 'Process', 'process_config.htm', 47, 1),
	(57, '', 'SWOT配置', '10.7', 'Director', 'Admin', 'Department Task', 'swot_config.htm', 47, 1),
	(58, '', '日志记录', '10.8', 'Manager', 'Admin', 'Logs', 'log_config.htm', 47, 1),
	(59, '', '文件管理', '10.11', 'Manager', 'Admin', 'The background file management', 'resource_config.htm', 47, 1),
	(60, '', '邮件配置', '8.3', 'Employee', 'User', 'Email Report Config Manager', 'report_config.htm', 34, 0),
	(61, '', '调休', '8.1.4', 'Employee', 'User', 'Lieu Manager', 'leave_lieu.htm', 35, 0),
	(62, '', '节假日配置', '10.9', 'Manager', 'Admin', 'Holidays Config', 'holiday_config.htm', 47, 1),
	(63, '', '公司格言', '10.10', 'Manager', 'Admin', 'The company motto', 'motto_config.htm', 47, 1),
	(64, '', '报表预览', '2.7', 'Employee', 'User', 'Preview Report', 'summary.htm', 8, 0),
	(65, '', '异常审核', '1.7', 'Manager', 'User', 'Abnormal Manager', 'check_abnormal.htm', 1, 1),
	(66, '', '职责分配', '1.8', 'Manager', 'User', 'Responsibility Assign', 'assigned_respons.htm', 1, 1),
	(67, '', '我的异常', '2.8', 'Employee', 'User', 'MyAbnormal', 'my_abnormal.htm', 8, 0),
	(68, '', '后台管理', '5.5', 'Manager', 'User', 'Admin Asset Management', 'asset_config.htm', 22, 1);
/*!40000 ALTER TABLE `ztree` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
