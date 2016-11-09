/*
SQLyog Enterprise - MySQL GUI v7.15 
MySQL - 5.0.96-community-nt : Database - gom
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`gom` /*!40100 DEFAULT CHARACTER SET utf8 */;

CREATE USER 'gom'@'localhost' IDENTIFIED BY '654321';
grant ALL on gom.* TO 'gom'@'localhost';

USE `gom`;

/*Table structure for table `abnormal` */

DROP TABLE IF EXISTS `abnormal`;

CREATE TABLE `abnormal` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `des` varchar(500) default NULL,
  `indirect` varchar(50) default NULL,
  `reporter` varchar(50) default NULL,
  `type` tinyint(4) unsigned default NULL,
  `user_abnormal_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK6255D06853B55EF6` (`user_abnormal_fk`),
  CONSTRAINT `FK6255D06853B55EF6` FOREIGN KEY (`user_abnormal_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `abnormal` */

/*Table structure for table `address` */

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `addrType` tinyint(4) unsigned default NULL,
  `address` varchar(50) NOT NULL,
  `cell` varchar(17) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `phone` varchar(16) default NULL,
  `relation` varchar(10) NOT NULL,
  `zipcode` varchar(6) default NULL,
  `user_address_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK1ED033D45358BB32` (`user_address_fk`),
  CONSTRAINT `FK1ED033D45358BB32` FOREIGN KEY (`user_address_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `address` */

insert  into `address`(`id`,`addrType`,`address`,`cell`,`contact`,`phone`,`relation`,`zipcode`,`user_address_fk`) values (1,0,'上海浦东芳华路','18655532555','曾小贤','0737-21321321','朋友','465552',1),(2,0,'上海浦东芳华路','13588665555','乔不利','0737-21321321','朋友','123132',2),(3,0,'上海浦东芳华路','(86)138-1741-3430','吕子乔','86(733)1750-1222','朋友','231313',3),(4,0,'上海浦东芳华路','13954542222','陈华','021-59655523','朋友','121243',4),(5,0,'上海浦东芳华路','13585512535','胡一菲','021-59655523','朋友','232323',5),(6,0,'牡丹路89弄18号602室','86137619401','紫色','02150499035','朋友','212102',6),(7,0,'牡丹路89弄18号602室','(86)138-1760-1860','章子怡','86(21)1760-1860','朋友','343434',7);

/*Table structure for table `asset` */

DROP TABLE IF EXISTS `asset`;

CREATE TABLE `asset` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `admin` varchar(15) NOT NULL,
  `ascription` varchar(15) NOT NULL,
  `assetName` varchar(30) NOT NULL,
  `assetState` tinyint(4) unsigned NOT NULL,
  `assetType` tinyint(4) unsigned NOT NULL,
  `attachment` varchar(36) default NULL,
  `buyDate` date default NULL,
  `buyNum` int(10) NOT NULL,
  `buyer` varchar(15) NOT NULL,
  `controlDate` date default NULL,
  `des` varchar(100) default NULL,
  `scrapDate` date default NULL,
  `unit` varchar(10) default NULL,
  `warrantyDate` date default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `asset` */

/*Table structure for table `attendance_tb` */

DROP TABLE IF EXISTS `attendance_tb`;

CREATE TABLE `attendance_tb` (
  `jobNo` varchar(30) default NULL,
  `ename` varchar(15) default NULL,
  `range` tinyint(4) default NULL,
  `day` float default '0',
  `hours` float default '0',
  `leave` int(11) default '0',
  `late` int(11) default '0',
  `compensatory` int(11) default '0',
  `des` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `attendance_tb` */

/*Table structure for table `borrow` */

DROP TABLE IF EXISTS `borrow`;

CREATE TABLE `borrow` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `applyState` tinyint(4) unsigned default NULL,
  `funCode` varchar(50) NOT NULL,
  `overStaff` varchar(12) NOT NULL,
  `receiveDate` date default NULL,
  `receiveNum` int(10) NOT NULL,
  `receiver` varchar(12) NOT NULL,
  `remark` varchar(80) default NULL,
  `returnDate` date default NULL,
  `asset_borrow_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK76F1961559B4B28E` (`asset_borrow_fk`),
  CONSTRAINT `FK76F1961559B4B28E` FOREIGN KEY (`asset_borrow_fk`) REFERENCES `asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `borrow` */

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `node` varchar(10) NOT NULL,
  `parentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_PARENTID` (`parentid`),
  CONSTRAINT `FK_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`id`,`name`,`node`,`parentid`) values (1,'人事部资料','1',NULL),(2,'IT部资料','2',NULL),(3,'财务部资料','3',NULL),(4,'财务账单','3.1',3),(5,'GOM开发规范','2.1',2),(6,'开发文档','2.2',2),(7,'新进员工','1.1',1),(8,'IT人员名单','2.3',2);

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `_key` varchar(45) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) default NULL,
  PRIMARY KEY  (`_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `config` */

insert  into `config`(`_key`,`name`,`value`) values ('basis','基础参数',NULL),('basis.adminIT','IT管理员','it_gail'),('basis.company.cn','公司中文名称','上海实名信息科技有限公司'),('basis.company.en','公司英文名称','SQE SERVICE'),('basis.fax','公司传真','+8621-50499037'),('basis.jobNo.prefix','工号前缀','SQE'),('basis.login.out','登出时间','17:30'),('basis.login.time','上班时间','8:30'),('basis.logs.path','日志路径','/usr/share/tomcat6/logs/'),('basis.mail.host','邮件服务主机','smtp.126.com'),('basis.mail.pwd','系统邮件账号密码','sqe321'),('basis.mail.user','系统邮件账号','gom_admin@126.com'),('basis.tel','公司电话','+8621-50499035'),('basis.version','系统版本','3.0'),('basis.web','公司网站','www.sqeservice.com'),('departure','离职流程节点参数',NULL),('departure.fieldwork.days','实习生离职提前天数','7'),('departure.financial','离职财务核算专员','fd_sarah'),('departure.HR','离职审核人事专员','hr_join'),('departure.qualified.days','正式员工离职申请提前天数','30'),('departure.training.days','试用期员工离职提前天数','15'),('entrant','入职流程节点参数',NULL),('entrant.HR','入职资料审核人事专员','hr_tina'),('fileUpload','文件上传参数组',NULL),('fileUpload.rootPath','上传根目录','/usr/share/tomcat6/webapps/ROOT/uploads/'),('fileUpload.typesAllows','允许上传文件类型','jpg,gif,png,pdf,doc,docx,xls,xlsx,swf,flv'),('fileUpload.typesForbid','禁止上传类型','exe,bat,sh'),('leave','请假模块参数组',NULL),('leave.daysDtr','部门主管可批准的请假天数','1'),('leave.daysMgr','部门经理可批准的请假天数','3');

/*Table structure for table `departure` */

DROP TABLE IF EXISTS `departure`;

CREATE TABLE `departure` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `handover` varchar(500) default NULL,
  `reason` varchar(200) NOT NULL,
  `recipient` varchar(15) default NULL,
  `recipientDpt` varchar(15) default NULL,
  `recipientJobNo` varchar(15) default NULL,
  `recipientPst` varchar(15) default NULL,
  `salaryDate` date default NULL,
  `state` tinyint(4) unsigned default NULL,
  `toMailAddr` varchar(350) default NULL,
  `user_departure_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK2EC128D44756C132` (`user_departure_fk`),
  CONSTRAINT `FK2EC128D44756C132` FOREIGN KEY (`user_departure_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `departure` */

/*Table structure for table `education` */

DROP TABLE IF EXISTS `education`;

CREATE TABLE `education` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ed` varchar(16) NOT NULL,
  `endDate` date default NULL,
  `idScan` varchar(36) default NULL,
  `idno` varchar(30) default NULL,
  `major` varchar(20) NOT NULL,
  `school` varchar(30) NOT NULL,
  `startDate` date default NULL,
  `user_education_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK661D8788AD8775FE` (`user_education_fk`),
  CONSTRAINT `FK661D8788AD8775FE` FOREIGN KEY (`user_education_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `education` */

insert  into `education`(`id`,`ed`,`endDate`,`idScan`,`idno`,`major`,`school`,`startDate`,`user_education_fk`) values (1,'本科','2010-09-04','','430265','计算机','上海交通大学','2010-09-03',1),(2,'大专','2011-09-03','','432652','开车','新东方学校','2007-09-01',2),(3,'本科','2012-09-01','','430265','计算机','上海交通大学','2007-09-01',3),(4,'本科','2011-09-03','','430265','计算机','上海交通大学','2010-09-03',4),(5,'大专','2010-09-04','','432652','会计','新东方学校','2010-09-03',5),(6,'大专','2012-09-01','','432652','计算机','新东方学校','2010-09-03',6);

/*Table structure for table `experience` */

DROP TABLE IF EXISTS `experience`;

CREATE TABLE `experience` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `createDate` date default NULL,
  `gain` text,
  `student` varchar(15) NOT NULL,
  `resource_how_fk` int(10) unsigned default NULL,
  `training_experience_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK71B8358A540790D5` (`resource_how_fk`),
  KEY `FK71B8358A3618EA51` (`training_experience_fk`),
  CONSTRAINT `FK71B8358A3618EA51` FOREIGN KEY (`training_experience_fk`) REFERENCES `training` (`id`),
  CONSTRAINT `FK71B8358A540790D5` FOREIGN KEY (`resource_how_fk`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `experience` */

/*Table structure for table `fixedtask` */

DROP TABLE IF EXISTS `fixedtask`;

CREATE TABLE `fixedtask` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `createDate` datetime default NULL,
  `des` varchar(500) default NULL,
  `expectedEnd` time default NULL,
  `expectedStart` time default NULL,
  `frequency` int(10) default NULL,
  `hours` float default NULL,
  `period` smallint(6) default NULL,
  `state` tinyint(4) unsigned default NULL,
  `taskTitle` varchar(35) NOT NULL,
  `updateDate` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fixedtask` */

/*Table structure for table `guser` */

DROP TABLE IF EXISTS `guser`;

CREATE TABLE `guser` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `accountNo` varchar(19) default NULL,
  `active` bit(1) default NULL,
  `bank` varchar(20) default NULL,
  `birthday` date default NULL,
  `cell` varchar(17) NOT NULL,
  `censusType` tinyint(4) unsigned default NULL,
  `cname` varchar(12) NOT NULL,
  `documents` tinyint(4) unsigned NOT NULL,
  `email` varchar(35) default NULL,
  `emailPwd` varchar(16) default NULL,
  `ename` varchar(15) NOT NULL,
  `entryDate` date default NULL,
  `exitDate` date default NULL,
  `fullDate` date default NULL,
  `gender` tinyint(4) unsigned default NULL,
  `height` varchar(3) default NULL,
  `idScan` varchar(36) default NULL,
  `idcard` varchar(18) NOT NULL,
  `jobNo` varchar(15) NOT NULL,
  `locked` bit(1) default NULL,
  `marriage` tinyint(4) unsigned default NULL,
  `nation` varchar(8) default NULL,
  `phone` varchar(16) default NULL,
  `portrait` varchar(36) default NULL,
  `privateMail` varchar(35) default NULL,
  `pwd` varchar(32) NOT NULL,
  `telExt` varchar(5) default NULL,
  `type` tinyint(4) unsigned default NULL,
  `generic` bit(1) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `ename` (`ename`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `guser` */

insert  into `guser`(`id`,`accountNo`,`active`,`bank`,`birthday`,`cell`,`censusType`,`cname`,`documents`,`email`,`emailPwd`,`ename`,`entryDate`,`exitDate`,`fullDate`,`gender`,`height`,`idScan`,`idcard`,`jobNo`,`locked`,`marriage`,`nation`,`phone`,`portrait`,`privateMail`,`pwd`,`telExt`,`type`,`generic`) 
values (0,'0000000000000000000','\0','中国建设银行','1900-01-01','(86)130-0000-0000',0,'通用账户',0,'default@sqeservice.com','service11','default','2012-09-26',NULL,'2012-09-26',0,'168','bb3c4c71efd141e1874b907e10ec01cd.jpg','430902198710015578','SQE12000','',0,'汉族','86(957)0000-000','default_touxiang.png','test@sina.com','905dcb52b6585ac391ffcf8162cd6c99','10',2,'\0'),(1,'6227556322215698','','中国建设银行','1987-10-01','(86)133-4567-4567',0,'管理员',0,'gom-admin@sqeservice.com','service11','admin','2012-09-26',NULL,'2012-09-26',0,'168','bb3c4c71efd141e1874b907e10ec01cd.jpg','430902198710015578','SQE12001','\0',0,'汉族','86(957)6879-123','default_touxiang.png','ou8zz@sina.com','905dcb52b6585ac391ffcf8162cd6c99','10',2,'\0'),(2,'6226555488855445','','中国建设银行','1965-10-01','(86)134-9876-8908',1,'李磊',0,'sqegom4@126.com','service4','mgr_laura','2012-05-21',NULL,'2012-09-26',1,'178','bb3c4c71efd141e1874b907e10ec01cd.jpg','426655995656322112','SQE12002','\0',0,'汉族','86(21)3387-4356','default_touxiang.png','sherry@126.com','905dcb52b6585ac391ffcf8162cd6c99','12',2,'\0'),(3,'6226555488855445','','中国建设银行','1987-03-01','(86)136-3489-4567',1,'高原',0,'sqegom1@126.com','service1','it_gail','2010-09-27',NULL,'2012-09-26',1,'165','bb3c4c71efd141e1874b907e10ec01cd.jpg','426655995656322112','SQE12008','\0',0,'汉族','86(10)7878-5656','default_touxiang.png','sherry@126.com','905dcb52b6585ac391ffcf8162cd6c99','15',2,''),(4,'6226555488855445','','中国建设银行','1985-07-26','(86)135-0945-2334',1,'司徒',0,'sqegom1@126.com','service1','it_tess','2012-10-30',NULL,'2012-09-27',0,'190','bb3c4c71efd141e1874b907e10ec01cd.jpg','430902198710015578','SQE12003','\0',1,'汉族','86(751)7789-6565','default_touxiang.png','james@sqeservice.com','905dcb52b6585ac391ffcf8162cd6c99','16',2,''),(5,'6226555488855445','','中国建设银行','1994-12-01','(86)139-8908-5656',1,'蒂娜',1,'sqegom2@126.com','service2','hr_tina','2011-01-17',NULL,'2013-01-24',0,'155','bb3c4c71efd141e1874b907e10ec01cd.jpg','430902198710015578','SQE12004','\0',1,'汉族','86(733)1750-1222','default_touxiang.png','ou8zz@sina.com','905dcb52b6585ac391ffcf8162cd6c99','17',2,''),(6,'6226555488855445','','中国建设银行','1982-04-01','(86)137-1456-7878',1,'王灵',0,'sqegom2@126.com','service2','hr_join','2011-06-13',NULL,'2012-09-30',1,'158','bb3c4c71efd141e1874b907e10ec01cd.jpg','430902198710015554','SQE12005','\0',0,'汉族','86(21)1750-1222','default_touxiang.png','sqe_wendy@sqeservice.com','905dcb52b6585ac391ffcf8162cd6c99','18',2,''),(7,'6226555488855445','','中国建设银行','1984-08-16','(86)139-3256-2345',1,'妙歌',0,'sqegom3@126.com','service3','fd_magia','2012-04-02',NULL,'2013-01-24',0,'187','bb3c4c71efd141e1874b907e10ec01cd.jpg','430902198710015578','SQE12006','\0',0,'蒙古族','86(591)3476-8965','default_touxiang.png','roger_cn@126.com','905dcb52b6585ac391ffcf8162cd6c99','19',2,''),(8,'62267722656522211','','中国建设银行','1995-01-04','(86)138-1741-1245',1,'莎莎',0,'sqegom3@126.com','service3','fd_sarah','2012-01-19',NULL,'2013-01-31',0,'169','bb3c4c71efd141e1874b907e10ec01cd.jpg','430922198910135531','SQE13007','\0',0,'漢族','86(521)1234-6789','default_touxiang.png','sqe_jason@126.com','905dcb52b6585ac391ffcf8162cd6c99','20',2,'');

/*Table structure for table `holidays` */

DROP TABLE IF EXISTS `holidays`;

CREATE TABLE `holidays` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `days` int(10) default NULL,
  `endDate` date default NULL,
  `name` varchar(15) NOT NULL,
  `startDate` date default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `holidays` */

insert  into `holidays`(`id`,`days`,`endDate`,`name`,`startDate`) values (1,7,'2013-01-07','春节','2013-01-01'),(2,3,'2013-05-07','端午','2013-05-05'),(3,7,'2013-10-07','国庆节','2013-10-01');

/*Table structure for table `leaves` */

DROP TABLE IF EXISTS `leaves`;

CREATE TABLE `leaves` (
  `id` int(10) unsigned NOT NULL auto_increment,
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
  `relationAddr` varchar(300) default NULL,
  `startDate` datetime NOT NULL,
  `state` tinyint(4) unsigned NOT NULL,
  `type` tinyint(4) unsigned NOT NULL,
  `user_leave_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKBE08889C14E11AE5` (`user_leave_id`),
  CONSTRAINT `FKBE08889C14E11AE5` FOREIGN KEY (`user_leave_id`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `leaves` */

/*Table structure for table `lieu` */

DROP TABLE IF EXISTS `lieu`;

CREATE TABLE `lieu` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dayoff` date default NULL,
  `explainr` varchar(30) default NULL,
  `type` tinyint(4) default NULL,
  `workedon` date default NULL,
  `explanation` varchar(30) default NULL,
  `holidays_lieu_fk` int(10) unsigned default NULL,
  `user_lieu_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK24230D18D88431` (`user_lieu_fk`),
  KEY `FK24230DF8E7C5B0` (`holidays_lieu_fk`),
  CONSTRAINT `FK24230D18D88431` FOREIGN KEY (`user_lieu_fk`) REFERENCES `guser` (`id`),
  CONSTRAINT `FK24230DF8E7C5B0` FOREIGN KEY (`holidays_lieu_fk`) REFERENCES `holidays` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lieu` */

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `loginIP` varchar(15) NOT NULL,
  `loginOut` datetime default NULL,
  `loginTake` varchar(500) NOT NULL,
  `loginTime` datetime default NULL,
  `unlockTime` time default NULL,
  `user_id` int(10) unsigned default NULL,
  `reportMark` bit(1) default NULL,
  `dateMark` tinyint(4) default NULL,
  `des` varchar(150) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK462FF49AB101B5D` (`user_id`),
  CONSTRAINT `FK462FF49AB101B5D` FOREIGN KEY (`user_id`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `login` */

insert  into `login`(`id`,`loginIP`,`loginOut`,`loginTake`,`loginTime`,`unlockTime`,`user_id`,`reportMark`,`dateMark`,`des`) values (1,'127.0.0.1',NULL,'15:29,16:07','2013-03-09 15:29:14',NULL,1,'',0,NULL),(2,'180.172.52.42','2013-03-16 16:35:27','15:57,15:57,16:32,16:34','2013-03-16 15:57:51',NULL,1,'',0,NULL),(3,'180.172.52.42','2013-03-16 16:29:31','16:28','2013-03-16 16:28:39',NULL,2,'\0',0,NULL),(4,'180.172.52.42','2013-03-16 16:55:07','16:30,16:35,16:36,16:53,16:57','2013-03-16 16:30:15',NULL,8,'\0',0,NULL),(5,'180.172.52.42','2013-03-16 16:52:25','16:37','2013-03-16 16:37:51',NULL,3,'\0',0,NULL);

/*Table structure for table `logs` */

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `dated` datetime NOT NULL,
  `level` varchar(10) NOT NULL,
  `logger` varchar(50) NOT NULL,
  `message` varchar(2000) NOT NULL,
  `type` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

/*Data for the table `logs` */

insert  into `logs`(`id`,`dated`,`level`,`logger`,`message`,`type`) values (1,'2012-11-06 15:59:58','2','缺陷修正','<p>\r\n	<strong><span style=\"color:#003399;\">缺陷修正</span></strong> \r\n</p>\r\n<ol>\r\n	<li>\r\n		当服务器忙时，提示用户服务器忙，请稍后再访问，而不是看到一个出错页面\r\n	</li>\r\n	<li>\r\n		首页的登入选项卡中要可查阅具体日期的登陆信息\r\n	</li>\r\n	<li>\r\n		退出系统的弹出层中显示的收件人必须是系统中未禁用及未注销的人员\r\n	</li>\r\n	<li>\r\n		登入系统时用户名与注册时的大小写完全一样才能正常登入\r\n	</li>\r\n	<li>\r\n		职务代理人应不能用户自己选择，应直接从个人资料中读取，如职务代理人以被系统注销将显示未红色，并在用户点击确认按钮时提示用户连接至个人资料中修改\r\n	</li>\r\n</ol>\r\n<br />',3),(2,'2012-11-06 16:00:53','1','改进功能','<p>\r\n	<span style=\"color:#003399;\"><strong>改进功能</strong></span>\r\n</p>\r\n<ol>\r\n	<li>\r\n		登入系统时，能提示用户及时更新与已注销掉的用户相关连的模块信息\r\n	</li>\r\n	<li>\r\n		登入首页时的统计要能按时间及人员搜索信息，普通人员能看到自己的及报告给他的人员及以下人员的统计信息，管理员可看到所有人的统计信息\r\n	</li>\r\n	<li>\r\n		管理责任中功能代码的说明列，以数字显示说明条数，点击时弹出具体信息层查看编辑\r\n	</li>\r\n	<li>\r\n		管理责任中编辑页面可切换FCODE，进行查看\r\n	</li>\r\n</ol>\r\n<br />',1),(3,'2012-11-06 16:01:01','1','新增功能','<p>\r\n	<strong><span style=\"color:#003399;\">新增功能</span></strong> \r\n</p>\r\n<ol>\r\n	<li>\r\n		首页中以广播的形式展现GOM系统版本更新日志<br />\r\n	</li>\r\n	<li>\r\n		贡献中增加搜索条件：按日期、已完成、未完成查询<br />\r\n	</li>\r\n	<li>\r\n		在系统左导航最上方增加“首页”导航，首页中分为：出勤、需要做、PI（不生效）、日报、周报、月报、总经理周报（不是总经理的不生效）、登陆选项卡页面\r\n	</li>\r\n	<li>\r\n		工作指令中的编辑页面中固定项目号(PRXXXXXX),固定版本号(VXX),固定文件号(PXXXXXX）\r\n	</li>\r\n	<li>\r\n		工作指令可按日期，已完成，未完成，全部这些条件搜索\r\n	</li>\r\n	<li>\r\n		如何做中总表增加创建日期，期间（1-12个月，内定为3各月），计划日期（自动算取）说明显示内容可固定并以省略号表示其它内容\r\n	</li>\r\n	<li>\r\n		将Email设置放入后台的操作指南之后，由部门主管设置\r\n	</li>\r\n	<li>\r\n		人力训练中增加训练类型：内训（内定），外训\r\n	</li>\r\n	<li>\r\n		用户管理中增加搜索条件：未注销，已注销（红色），全部，默认显示未注销用户，按工号排序资产管理中增加挑选转交人员功能，勾选人员转交后此资产将显示在转交人员中，此时这条数据将显示已转交状态\r\n	</li>\r\n	<li>\r\n		增加广播周期（每三天、每几天，礼拜几，内定为每天），状态（作废，正常）\r\n	</li>\r\n</ol>',1),(4,'2012-11-08 09:05:23','1','日志乱码','<p style=\"text-align:left;\">\r\n	<strong><span style=\"color:#006600;\">日志乱码</span></strong><strong><span style=\"color:#006600;\"> </span></strong>      \r\n</p>\r\n<p style=\"color:#000000;font-family:Helvetica, Tahoma, Arial, sans-serif;font-size:14px;font-style:normal;font-weight:normal;text-align:left;text-indent:0px;background-color:#FFFFFF;\">\r\n	<span style=\"color:#009900;font-size:12px;\">         <span style=\"color:#000000;\">手头的项目用LOG4J做日志的输出处理，可不知怎么了，最近输出的日志内容里面居然出现了乱码——问号，而且比较郁闷的是，从另一个类的属性里面读出的中文确可以正常显示，试了各种办法，如给日志增加一项ENCODE为GBK，UTF-8，均不能解决此问题，突然想到会不会是JAVA源文件的问题了？？？</span></span> \r\n</p>\r\n<p style=\"color:#000000;font-family:Helvetica, Tahoma, Arial, sans-serif;font-size:14px;font-style:normal;font-weight:normal;text-align:left;text-indent:0px;background-color:#FFFFFF;\">\r\n	<span style=\"color:#000000;font-size:12px;\">想到前此因为在MYECLIPSE里面看中文是乱码，我曾经调整过CONTENT TYPES(即window->preferences->general->content types)，更改过text的编码格式，即default encode，检查之下，果然如此，于是我把默认的JAVA SOURCES源下的GBK给删除了，然后重新编译，乱码问题解决，呵呵，放在此处，供有心之人在遇到此类问题的时候提个醒.</span>\r\n</p>\r\n<br />',3);

/*Table structure for table `meeting` */

DROP TABLE IF EXISTS `meeting`;

CREATE TABLE `meeting` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `content` varchar(2000) default NULL,
  `endDate` date default NULL,
  `explains` varchar(200) default NULL,
  `host` varchar(20) NOT NULL,
  `isTrace` bit(1) default NULL,
  `locale` varchar(20) NOT NULL,
  `notes` varchar(20) NOT NULL,
  `number` varchar(20) NOT NULL,
  `participants` varchar(50) default NULL,
  `time` datetime default NULL,
  `title` varchar(20) NOT NULL,
  `traceDate` date default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `meeting` */

/*Table structure for table `motto` */

DROP TABLE IF EXISTS `motto`;

CREATE TABLE `motto` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `mottoText` varchar(2000) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `motto` */

insert  into `motto`(`id`,`mottoText`) values (1,'<ul>\r\n	<li class=\"MsoNormal\">\r\n		态度决定一切<span>,</span>细节决定成败\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		一个成功的公司：\r\n	</li>\r\n	<ul>\r\n		<li class=\"MsoNormal\">\r\n			所有问题的发现，都是公司的重大资产\r\n		</li>\r\n		<li class=\"MsoNormal\">\r\n			不要让它成为历史，我们要将学习的经验留下来\r\n		</li>\r\n		<li class=\"MsoNormal\">\r\n			个人跟公司都因这些经验而成长\r\n		</li>\r\n	</ul>\r\n	<li>\r\n		一个失败的公司：\r\n	</li>\r\n	<ul>\r\n		<li class=\"MsoNormal\">\r\n			问题没被解决\r\n		</li>\r\n		<li class=\"MsoNormal\">\r\n			问题一再发生\r\n		</li>\r\n		<li class=\"MsoNormal\">\r\n			个人成长但是团队失败\r\n		</li>\r\n	</ul>\r\n	<li class=\"MsoNormal\">\r\n		最好的伙伴关系就是为共同优势而有的互信与互重关系，进而创造超越任何一方独自能够达到的成果\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		先问自己能贡献给团队什么，再问团队能给你什么\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		成功来自于团队创意得到纪律般的执行力\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		要用心及大脑做事，不要用体力及时间来做事。前者客户满意，后者自己都不满意\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		合格的人讲方法<span>,</span>不合格的人讲疏忽\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		日日清，过程监控，结果导向\r\n	</li>\r\n	<li class=\"MsoNormal\">\r\n		以诚做事，用情做人，以理服人，以义交友，我们以<span>\'</span>诚情理义<span>\'</span>服务我们的客户双赢\r\n	</li>\r\n</ul>\r\n<hr />');

/*Table structure for table `process` */

DROP TABLE IF EXISTS `process`;

CREATE TABLE `process` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `actor` varchar(15) default NULL,
  `assignType` tinyint(4) unsigned NOT NULL,
  `icon` varchar(36) default NULL,
  `nodeCode` varchar(10) NOT NULL,
  `nodeName` varchar(20) default NULL,
  `nodeOrder` int(10) NOT NULL,
  `type` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `process` */

insert  into `process`(`id`,`actor`,`assignType`,`icon`,`nodeCode`,`nodeName`,`nodeOrder`,`type`) values (1,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Apply','申请人',1,3),(2,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Director','直接主管',2,3),(3,'sherry',0,'253534dc6b794874aa048d57ec62544c.jpg','Personnel','离职审核人事专员',3,3),(4,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Receiver','工作接收人',4,3),(5,'sherry',0,'253534dc6b794874aa048d57ec62544c.jpg','Financial','离职财务结算专员',5,3),(6,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Adjustment','工作接收人责任调整',6,3),(7,'basis.adminIT',4,'253534dc6b794874aa048d57ec62544c.jpg','Technology','IT管理员',7,3),(8,'departure.ftl',4,'253534dc6b794874aa048d57ec62544c.jpg','Email','发送邮件',8,3),(9,'Close',4,'50edc203b1ad41239836ab524ae840d2.jpg','End','流程结束',9,3),(10,'',3,'253534dc6b794874aa048d57ec62544c.jpg','newEntry','新职员',1,2),(11,'entrant.HR',4,'253534dc6b794874aa048d57ec62544c.jpg','Personnel','人事审核资料',2,2),(12,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Director','主管分配职责',3,2),(13,'basis.adminIT',4,'253534dc6b794874aa048d57ec62544c.jpg','Technology','IT管理员开通帐号',4,2),(14,'entrant.ftl',4,'253534dc6b794874aa048d57ec62544c.jpg','Email','发送入职邮件',5,2),(15,'Close',4,'50edc203b1ad41239836ab524ae840d2.jpg','End','流程结束',6,2),(16,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Apply','申请人',1,0),(17,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Agent','代理人',2,0),(18,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Director','直接主管',3,0),(19,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Manager','上级管理者',4,0),(20,'leave.ftl',4,'253534dc6b794874aa048d57ec62544c.jpg','Email','发送邮件',5,0),(21,'Close',4,'50edc203b1ad41239836ab524ae840d2.jpg','End','流程结束',6,0),(22,'wendy,sherry',1,'253534dc6b794874aa048d57ec62544c.jpg','AddTask','添加工作',1,1),(23,'wendy,sherry',1,'253534dc6b794874aa048d57ec62544c.jpg','Allocation','分配工作',2,1),(24,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Executor','执行者',3,1),(25,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Help','需要帮忙',4,1),(26,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Director','审核者',5,1),(27,'Close',4,'50edc203b1ad41239836ab524ae840d2.jpg','End','结束',6,1),(28,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Submit','异常提交',1,4),(29,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Director','直接主管',2,4),(30,'',3,'253534dc6b794874aa048d57ec62544c.jpg','Indirect','间接主管',3,4),(31,'',3,'email.png','Email','发送邮件',4,4),(32,'Close',4,'50edc203b1ad41239836ab524ae840d2.jpg','End','流程结束',5,4);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `explains` varchar(200) NOT NULL,
  `num` int(10) NOT NULL,
  `outputDate` date default NULL,
  `productName` varchar(12) NOT NULL,
  `productType` tinyint(4) unsigned default NULL,
  `unit` varchar(10) NOT NULL,
  `version` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`id`,`explains`,`num`,`outputDate`,`productName`,`productType`,`unit`,`version`) values (1,'GOM（General Operation Management）日常操作管理系统实现办公自动化，更好的为企业用户提供服务。公司管理者或项目成员可透过本系统来了解组织及项目内部的运转及绩效表现。对于管理责任的分配及交接，以动态管理模式来记录现行的管理及其可能的缺陷。系统提供了个性化的工作界面，方便用户设置个人信息幷根据自身的业务分工设置工作日程，合理安排时间，避免工作的无条理和盲目性。',1,'2012-09-20','GOM',0,'个','v3.0'),(2,'用于日常工作',1,'2013-01-08','新GOM ',0,'套','01');

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `actualEnd` date default NULL,
  `actualTime` varchar(10) default NULL,
  `des` varchar(200) default NULL,
  `director` varchar(15) NOT NULL,
  `endDate` date default NULL,
  `expectedTime` varchar(10) default NULL,
  `projectName` varchar(30) NOT NULL,
  `projectNo` varchar(30) default NULL,
  `startDate` date default NULL,
  `state` tinyint(4) unsigned default NULL,
  `type` tinyint(4) unsigned default NULL,
  `updateDate` date default NULL,
  `version` varchar(10) default NULL,
  `parentid` int(10) unsigned default NULL,
  `project_product_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK50C8E2F92C5EF48` (`project_product_fk`),
  KEY `FK_PROJECT_PARENTID` (`parentid`),
  CONSTRAINT `FK50C8E2F92C5EF48` FOREIGN KEY (`project_product_fk`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_PROJECT_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `project` */

insert  into `project`(`id`,`actualEnd`,`actualTime`,`des`,`director`,`endDate`,`expectedTime`,`projectName`,`projectNo`,`startDate`,`state`,`type`,`updateDate`,`version`,`parentid`,`project_product_fk`) values (1,NULL,NULL,'GOM（General Operation Management）日常操作管理系统实现办公自动化，更好的为企业用户提供服务。公司管理者或项目成员可透过本系统来了解组织及项目内部的运转及绩效表现。对于管理责任的分配及交接，以动态管理模式来记录现行的管理及其可能的缺陷。系统提供了个性化的工作界面，方便用户设置个人信息幷根据自身的业务分工设置工作日程，合理安排时间，避免工作的无条理和盲目性。','admin','2012-09-30','240','GOM','01','2012-09-01',3,0,'2012-09-27','v3.0',NULL,2);

/*Table structure for table `reportconfig` */

DROP TABLE IF EXISTS `reportconfig`;

CREATE TABLE `reportconfig` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `assets` bit(1) default NULL,
  `daily` bit(1) default NULL,
  `devote` bit(1) default NULL,
  `doing` bit(1) default NULL,
  `help` bit(1) default NULL,
  `how` bit(1) default NULL,
  `login` bit(1) default NULL,
  `perMonth` bit(1) default NULL,
  `quarterly` bit(1) default NULL,
  `repos` bit(1) default NULL,
  `summary` bit(1) default NULL,
  `task` bit(1) default NULL,
  `type` tinyint(4) default NULL,
  `weekDevote` bit(1) default NULL,
  `weekly` bit(1) default NULL,
  `user_report_fk` int(10) unsigned default NULL,
  `cc` varchar(500) default NULL,
  `receiver` varchar(500) default NULL,
  `send` bit(1) default NULL,
  `sendTime` varchar(30) default NULL,
  `ccename` varchar(150) default NULL,
  `ename` varchar(150) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK122C61B6FC2DB18A` (`user_report_fk`),
  CONSTRAINT `FK122C61B6FC2DB18A` FOREIGN KEY (`user_report_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `reportconfig` */

insert  into `reportconfig`(`id`,`assets`,`daily`,`devote`,`doing`,`help`,`how`,`login`,`perMonth`,`quarterly`,`repos`,`summary`,`task`,`type`,`weekDevote`,`weekly`,`user_report_fk`,`cc`,`receiver`,`send`,`sendTime`,`ccename`,`ename`) values (1,'','','','\0','\0','\0','\0','\0','\0','','\0','\0',0,'','\0',1,'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,roger@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','gom-admin@sqeservice.com','\0',NULL,'sherry,wendy,roger,james,sqe_ole','admin'),(2,'\0','','','','','\0','','','','','','',1,'','',1,NULL,NULL,'\0',NULL,NULL,NULL),(3,'','','\0','\0','\0','\0','\0','\0','\0','','\0','\0',2,'\0','\0',1,NULL,NULL,'\0',NULL,NULL,NULL),(4,'','\0','\0','','\0','\0','\0','\0','\0','\0','\0','\0',3,'\0','\0',1,NULL,NULL,'\0',NULL,NULL,NULL),(5,'\0','\0','\0','\0','\0','\0','\0','\0','','','\0','\0',4,'\0','\0',1,NULL,NULL,'\0',NULL,NULL,NULL),(6,'','','\0','\0','','\0','\0','','','\0','\0','\0',3,'','',3,'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','',NULL,'admin,james,sqe_ole','admin,james,sqe_ole'),(7,'\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0',1,'\0','',3,NULL,NULL,'\0',NULL,NULL,NULL),(8,'\0','','\0','','\0','','\0','','','\0','\0','\0',4,'\0','',3,NULL,NULL,'\0',NULL,NULL,NULL),(9,'\0','','\0','','\0','','','','','','','\0',0,'','',3,'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,roger@sqeservice.com,sqe_ole@sqeservice.com','sqe_james@sqeservice.com','',NULL,'sherry,wendy,roger,sqe_ole','james'),(10,'\0','\0','\0','\0','\0','\0','\0','','\0','\0','\0','\0',2,'\0','',3,NULL,NULL,'\0',NULL,NULL,NULL),(11,'','','','','','','','','','','','',0,'','',4,'sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com,sqe_james@sqeservice.com,roger@sqeservice.com','sqe_ole@sqeservice.com','',NULL,'sherry,wendy,james,roger','sqe_ole'),(12,'','','','','','','','\0','\0','','','',1,'','',4,'','sqe_ole@sqeservice.com','','1','','sqe_ole'),(13,'\0','\0','\0','\0','\0','\0','','\0','\0','\0','','\0',2,'\0','\0',4,'','sqe_ole@sqeservice.com','','1','','sqe_ole'),(14,'','\0','','','','','','\0','','','','',3,'','\0',4,'','sqe_ole@sqeservice.com','','30','','sqe_ole'),(15,'','\0','','','','','','\0','','','','',4,'','\0',4,'','sqe_ole@sqeservice.com','','','','sqe_ole'),(16,'','','','','','','','\0','\0','','','',0,'','\0',2,'sqe_wendy@sqeservice.com,roger@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','sqe_sherry@sqeservice.com','',NULL,'wendy,roger,james,sqe_ole','sherry'),(17,'\0','','','','','','','\0','\0','','','',1,'','\0',2,'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com','\0',NULL,'admin,james,sqe_ole','sherry,wendy'),(18,'\0','','\0','\0','\0','\0','\0','','\0','\0','\0','\0',2,'\0','\0',2,'','','\0',NULL,'',''),(19,'\0','','\0','\0','\0','\0','\0','\0','','\0','\0','\0',3,'\0','\0',2,'','','\0',NULL,'',''),(20,'\0','\0','','\0','\0','\0','\0','\0','','\0','\0','\0',4,'\0','\0',2,'','','\0',NULL,'',''),(21,'','','','','','','','','','','','',0,'','',5,'roger@sqeservice.com,sqe_sherry@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','sqe_wendy@sqeservice.com','',NULL,'roger,sherry,james,sqe_ole','wendy'),(22,'','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0',4,'\0','\0',5,'gom-admin@sqeservice.com,sqe_james@sqeservice.com,sqe_ole@sqeservice.com','sqe_sherry@sqeservice.com,sqe_wendy@sqeservice.com','',NULL,'admin,james,sqe_ole','sherry,wendy');

/*Table structure for table `reports` */

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `data` float default NULL,
  `dated` date default NULL,
  `item` tinyint(4) default NULL,
  `type` tinyint(4) default NULL,
  `user_reports_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK413E51BF76962D87` (`user_reports_fk`),
  CONSTRAINT `FK413E51BF76962D87` FOREIGN KEY (`user_reports_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reports` */

/*Table structure for table `resource` */

DROP TABLE IF EXISTS `resource`;

CREATE TABLE `resource` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `attachment` varchar(36) NOT NULL,
  `createDate` date default NULL,
  `des` varchar(500) NOT NULL,
  `downloadDate` date default NULL,
  `isValid` bit(1) default NULL,
  `level` varchar(15) default NULL,
  `maintainDpt` varchar(20) NOT NULL,
  `resourceType` tinyint(4) unsigned default NULL,
  `responsibility` varchar(255) default NULL,
  `score` int(10) NOT NULL,
  `swot` varchar(255) default NULL,
  `title` varchar(50) NOT NULL,
  `updateDate` date default NULL,
  `uploadDate` date default NULL,
  `uploadEname` varchar(16) NOT NULL,
  `version` varchar(15) NOT NULL,
  `category_resource_fk` int(10) unsigned default NULL,
  `number` varchar(15) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKEF86282EE2CDBA35` (`category_resource_fk`),
  CONSTRAINT `FKEF86282EE2CDBA35` FOREIGN KEY (`category_resource_fk`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `resource` */

/*Table structure for table `responsibility` */

DROP TABLE IF EXISTS `responsibility`;

CREATE TABLE `responsibility` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `explanation` varchar(100) NOT NULL,
  `funcode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `parentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_R_PARENTID` (`parentid`),
  CONSTRAINT `FK_R_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `responsibility` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `responsibility` */

insert  into `responsibility`(`id`,`explanation`,`funcode`,`name`,`parentid`) values (1,'所有涉及开发编码的程序开发工作','F2_0','程序开发',NULL),(2,'对需求分析并编写开发文档','F2_1','文档编写',1),(3,'程序的测试（包括单元、集成，压力等所有测试）','F2_2','程序测试',1),(4,'功能的代码编写实现','F2_3','编码开发',1),(5,'对编写程序的再修改或变更','F2_4','程序DEBUG',1),(6,'最终用户UI的白盒测试','F2_5','页面测试',1),(7,'负责公司项目的立项、需要设计、资源分配等','F1_0','项目管理',NULL),(8,'跟踪项目成员的最新进度','F1_1','开发进度追踪',7),(9,'所有项目的需求分析设计文档','F1_2','需求分析设计文档',7),(10,'确定分歧问题，定案解决思路','F1_3','项目研讨定案',7),(11,'根据需求档编写开发文档','F1_4','编写开发文档',7),(12,'为项目成员解决技术难点','F1_5','技术疑难解决',7),(13,'负责公司账务、税费、日常收支等 管理','F3_0','账务、税费收支管理',NULL),(14,'公司所涉及的税收、应缴税款','F3_1','税费统计结算',13),(15,'员工薪酬统计，奖金结算','F3_2','薪酬奖金统计',13),(16,'公司内部的日常','F3_3','日常收支',13),(17,'员工的差旅收支结算','F3_4','差旅结算',13),(18,'所有公司往来账务统计、结算、收支','F3_5','业务帐务',13),(19,'UI图片的PS、DW设计制作','F4_0','UI设计制作',NULL),(20,'按需求制作UI版面','F4_2','UI版面制作',19),(21,'按W3C业界标准优化或整合图片','F4_3','WEB图片优化',19),(22,'按W3C标准优化页面布局','F4_4','CSS样式优化',19),(23,'按需求PS或其他工具制作UI图片','F4_5','UI图片制作',19),(24,'所涉及的界面图片设计','F4_1','UI图片或版面设计',19);

/*Table structure for table `signature` */

DROP TABLE IF EXISTS `signature`;

CREATE TABLE `signature` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `stext` varchar(2000) default NULL,
  `user_signature_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKB76FB8981942EAEE` (`user_signature_fk`),
  CONSTRAINT `FKB76FB8981942EAEE` FOREIGN KEY (`user_signature_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `signature` */

insert  into `signature`(`id`,`stext`,`user_signature_fk`) values (1,'<div class=\"signiture\">\r\n	<h3>\r\n		Best Regards\r\n	</h3>\r\n	<h3>\r\n		admin(管理员)\r\n	</h3>\r\n	<table class=\"ke-zeroborder\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"519\">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan=\"2\" width=\"119\">\r\n					<img alt=\"LOGO\" src=\"http://localhost:88/gom/images/sqe_logo.png\" width=\"119\" height=\"45\" />\r\n				</td>\r\n				<td width=\"240\">\r\n					<b>TEL:</b> +8621-50499035 ext. 17\r\n				</td>\r\n				<td width=\"160\">\r\n					<b>FAX:</b> +8621-50499037\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td>\r\n					<b>EMAIL:</b> gom-admin@sqeservice.com\r\n				</td>\r\n				<td>\r\n					<b>WEB:</b><a href=\"http://www.sqeservice.com\">www.sqeservice.com</a>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p>\r\n		GOM_v3.0 Copyright&copy;2005-2013 上海实名信息科技有限公司 SQE SERVICE 版权所有\r\n	</p>\r\n</div>',1),(2,'',2),(3,'',3),(4,'<div class=\"signiture\">\r\n	<h3>\r\n		Best Regards\r\n	</h3>\r\n	<h3>\r\n		sqe_ole(欧阳智成)\r\n	</h3>\r\n	<table class=\"ke-zeroborder\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"519\">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan=\"2\" width=\"119\">\r\n					<img src=\"http://localhost:88/gom/images/sqe_logo.png\" alt=\"LOGO\" height=\"45\" width=\"119\" />\r\n				</td>\r\n				<td width=\"240\">\r\n					<b>TEL:</b> +8621-50499035 ext. 19\r\n				</td>\r\n				<td width=\"160\">\r\n					<b>FAX:</b> +8621-50499037\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td>\r\n					<b>EMAIL:</b> sqe_ole@sqeservice.com\r\n				</td>\r\n				<td>\r\n					<b>WEB:</b><a href=\"http://www.sqeservice.com\">www.sqeservice.com</a>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p>\r\n		GOM_v3.0 Copyright&copy;2005-2013 上海实名信息科技有限公司 SQE SERVICE 版权所有\r\n	</p>\r\n</div>',4),(5,'<div class=\"signiture\">\r\n	<h3>\r\n		Best Regards\r\n	</h3>\r\n	<h3>\r\n		wendy(陶文秀)\r\n	</h3>\r\n	<table class=\"ke-zeroborder\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"519\">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan=\"2\" width=\"119\">\r\n					<img src=\"http://localhost:88/gom/images/sqe_logo.png\" alt=\"LOGO\" height=\"45\" width=\"119\" />\r\n				</td>\r\n				<td width=\"240\">\r\n					<b>TEL:</b> +8621-50499035 ext. 17\r\n				</td>\r\n				<td width=\"160\">\r\n					<b>FAX:</b> +8621-50499037\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td>\r\n					<b>EMAIL:</b> sqe_wendy@sqeservice.com\r\n				</td>\r\n				<td>\r\n					<b>WEB:</b><a href=\"http://www.sqeservice.com\">www.sqeservice.com</a>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p>\r\n		GOM_v3.0 Copyright&copy;2005-2013 上海实名信息科技有限公司 SQE SERVICE 版权所有\r\n	</p>\r\n</div>',5);

/*Table structure for table `statistics` */

DROP TABLE IF EXISTS `statistics`;

CREATE TABLE `statistics` (
  `data` float default NULL,
  `item` tinyint(4) default NULL,
  `dated` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `statistics` */

/*Table structure for table `summary` */

DROP TABLE IF EXISTS `summary`;

CREATE TABLE `summary` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `data` float default NULL,
  `dateMark` tinyint(4) default NULL,
  `dated` date default NULL,
  `config_summarys_fk` int(10) unsigned default NULL,
  `user_summarys_fk` int(10) unsigned default NULL,
  `week` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKF47F3F86373AA707` (`config_summarys_fk`),
  KEY `FKF47F3F86FCA3B91` (`user_summarys_fk`),
  CONSTRAINT `FKF47F3F86373AA707` FOREIGN KEY (`config_summarys_fk`) REFERENCES `swotconfig` (`id`),
  CONSTRAINT `FKF47F3F86FCA3B91` FOREIGN KEY (`user_summarys_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `summary` */

insert  into `summary`(`id`,`data`,`dateMark`,`dated`,`config_summarys_fk`,`user_summarys_fk`,`week`) values (1,1,NULL,'2013-03-09',31,1,NULL),(2,1,NULL,'2013-03-16',31,1,NULL),(3,1,NULL,'2013-03-16',31,2,NULL),(4,1,NULL,'2013-03-16',31,8,NULL),(5,1,NULL,'2013-03-16',31,3,NULL);

/*Table structure for table `swotconfig` */

DROP TABLE IF EXISTS `swotconfig`;

CREATE TABLE `swotconfig` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `centerline` float NOT NULL,
  `colorO` varchar(6) NOT NULL,
  `colorS` varchar(6) NOT NULL,
  `colorT` varchar(6) NOT NULL,
  `colorW` varchar(6) NOT NULL,
  `continuousChange` float default NULL,
  `continuousDistanceGtOne` float default NULL,
  `continuousDistanceLtOne` float default NULL,
  `continuousSameSide` float default NULL,
  `continuousStaggered` float default NULL,
  `datum` int(10) default NULL,
  `datumO` float default NULL,
  `datumS` float default NULL,
  `datumT` float default NULL,
  `datumW` float default NULL,
  `distanceCenter` float default NULL,
  `distanceGtOne` float default NULL,
  `distanceGtTwo` float default NULL,
  `improveTarget` float default NULL,
  `isContinuousChange` bit(1) default NULL,
  `isContinuousDistanceGtOne` bit(1) default NULL,
  `isContinuousDistanceLtOne` bit(1) default NULL,
  `isContinuousSameSide` bit(1) default NULL,
  `isContinuousStaggered` bit(1) default NULL,
  `isDistanceCenter` bit(1) default NULL,
  `isDistanceGtOne` bit(1) default NULL,
  `isDistanceGtTwo` bit(1) default NULL,
  `method` tinyint(4) unsigned default NULL,
  `model` tinyint(4) unsigned default NULL,
  `tolerance` float default NULL,
  `item` tinyint(4) default NULL,
  `lower` float NOT NULL,
  `upper` float NOT NULL,
  `date_range` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Data for the table `swotconfig` */

insert  into `swotconfig`(`id`,`centerline`,`colorO`,`colorS`,`colorT`,`colorW`,`continuousChange`,`continuousDistanceGtOne`,`continuousDistanceLtOne`,`continuousSameSide`,`continuousStaggered`,`datum`,`datumO`,`datumS`,`datumT`,`datumW`,`distanceCenter`,`distanceGtOne`,`distanceGtTwo`,`improveTarget`,`isContinuousChange`,`isContinuousDistanceGtOne`,`isContinuousDistanceLtOne`,`isContinuousSameSide`,`isContinuousStaggered`,`isDistanceCenter`,`isDistanceGtOne`,`isDistanceGtTwo`,`method`,`model`,`tolerance`,`item`,`lower`,`upper`,`date_range`) values (1,12,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,0,0,24,0),(2,35,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,1,0,70,1),(3,35,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,2,0,72,1),(4,2,'yellow','green','blue','red',25,25,25,25,25,4,0,0,0,0,25,25,25,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,3,0,4,1),(5,2,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,4,0,4,1),(6,1,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,5,0,3,1),(7,1,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,6,0,3,1),(8,1,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,7,0,3,1),(9,140,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,0,0,280,2),(10,600,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,0,0,1200,4),(11,140,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,1,0,280,2),(12,500,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,1,0,1000,4),(13,140,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,2,0,280,2),(14,600,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,2,0,1200,4),(15,6,'yellow','green','blue','red',25,25,25,25,25,4,0,0,0,0,25,25,25,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,3,0,12,2),(16,12,'yellow','green','blue','red',25,25,25,25,25,4,0,0,0,0,25,25,25,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,3,0,24,4),(17,12,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,4,2,24,2),(18,12,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,4,2,24,4),(19,6,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,5,1,12,2),(20,12,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,5,1,25,4),(21,3,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,6,0,6,2),(22,6,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,6,0,12,4),(23,5,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,7,0,10,2),(24,6,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,7,0,12,4),(25,35,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,0,0,70,1),(27,8,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,1,0,11,0),(28,6,'yellow','green','blue','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,2,0,12,0),(29,2,'yellow','green','blue','red',25,25,25,25,25,4,0,0,0,0,25,25,25,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,3,0,4,0),(30,2,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,4,0,4,0),(31,1,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,5,0,3,0),(32,2,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,6,0,4,0),(33,2,'blue','green','yellow','red',NULL,NULL,NULL,NULL,NULL,4,0,0,0,0,NULL,NULL,NULL,0,'\0','\0','\0','\0','\0','\0','\0','\0',0,0,NULL,7,0,4,0);

/*Table structure for table `task` */

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `actualEnd` datetime default NULL,
  `actualHours` float default NULL,
  `actualStart` datetime default NULL,
  `assignor` varchar(15) default NULL,
  `completedRate` varchar(10) default NULL,
  `createDate` datetime default NULL,
  `des` varchar(500) default NULL,
  `executor` varchar(15) default NULL,
  `expectedEnd` datetime default NULL,
  `expectedHours` float default NULL,
  `expectedStart` datetime default NULL,
  `occupyRate` varchar(10) default NULL,
  `state` tinyint(4) unsigned default NULL,
  `taskTitle` varchar(35) NOT NULL,
  `taskType` tinyint(4) unsigned default NULL,
  `task_fixed_fk` int(10) unsigned default NULL,
  `task_project_fk` int(10) unsigned default NULL,
  `task_respon_fk` int(10) unsigned default NULL,
  `needHelp` bit(1) default NULL,
  `needState` int(11) default NULL,
  `delay` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK27A9A5935E11C` (`task_project_fk`),
  KEY `FK27A9A58B77D80B` (`task_respon_fk`),
  KEY `FK27A9A55936A5E1` (`task_fixed_fk`),
  CONSTRAINT `FK27A9A55936A5E1` FOREIGN KEY (`task_fixed_fk`) REFERENCES `fixedtask` (`id`),
  CONSTRAINT `FK27A9A58B77D80B` FOREIGN KEY (`task_respon_fk`) REFERENCES `responsibility` (`id`),
  CONSTRAINT `FK27A9A5935E11C` FOREIGN KEY (`task_project_fk`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `task` */

/*Table structure for table `trace` */

DROP TABLE IF EXISTS `trace`;

CREATE TABLE `trace` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `actor` varchar(15) default NULL,
  `arrow` varchar(25) default NULL,
  `attachment` varchar(37) default NULL,
  `deliverTime` datetime default NULL,
  `icon` varchar(20) NOT NULL,
  `opinion` varchar(500) default NULL,
  `processId` int(10) NOT NULL,
  `state` tinyint(4) unsigned default NULL,
  `process_trace_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK4D501253C486DEA` (`process_trace_fk`),
  CONSTRAINT `FK4D501253C486DEA` FOREIGN KEY (`process_trace_fk`) REFERENCES `process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `trace` */

/*Table structure for table `training` */

DROP TABLE IF EXISTS `training`;

CREATE TABLE `training` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `endDate` date NOT NULL,
  `fee` double NOT NULL,
  `lecturer` varchar(12) NOT NULL,
  `otherFee` double NOT NULL,
  `qualification` varchar(100) NOT NULL,
  `startDate` date NOT NULL,
  `tcontent` varchar(500) NOT NULL,
  `tprogram` varchar(30) NOT NULL,
  `trainingTime` float NOT NULL,
  `trainingType` tinyint(4) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `training` */

/*Table structure for table `ugroup` */

DROP TABLE IF EXISTS `ugroup`;

CREATE TABLE `ugroup` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `cname` varchar(20) NOT NULL,
  `ename` varchar(15) NOT NULL,
  `type` tinyint(4) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `ugroup` */

insert  into `ugroup`(`id`,`cname`,`ename`,`type`) values (1,'普通用户','User',0),(2,'管理员','Admin',0),(3,'人事部','Personnel',1),(4,'财务部','Financial',1),(5,'IT部','Technology',1),(6,'助理','Assistant',2),(7,'主管','Director',2),(8,'经理','Manager',2),(9,'员工','Employee',2),(10,'董事长','CEO',2),(11,'行政部','Logistics',1);

/*Table structure for table `usergroup` */

DROP TABLE IF EXISTS `usergroup`;

CREATE TABLE `usergroup` (
  `uid` int(10) unsigned NOT NULL,
  `gid` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`uid`,`gid`),
  KEY `FK12E9C174B3D6F19E` (`uid`),
  KEY `FK12E9C174C60C751E` (`gid`),
  CONSTRAINT `FK12E9C174B3D6F19E` FOREIGN KEY (`uid`) REFERENCES `guser` (`id`),
  CONSTRAINT `FK12E9C174C60C751E` FOREIGN KEY (`gid`) REFERENCES `ugroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `usergroup` */

insert  into `usergroup`(`uid`,`gid`) values (1,2),(1,5),(1,10),(2,2),(2,10),(2,11),(3,1),(3,5),(3,8),(4,1),(4,5),(4,9),(5,1),(5,3),(5,8),(6,1),(6,3),(6,9),(7,1),(7,4),(7,6),(8,1),(8,4),(8,9);

/*Table structure for table `userresp` */

DROP TABLE IF EXISTS `userresp`;

CREATE TABLE `userresp` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `expected` int(10) NOT NULL,
  `node` varchar(10) NOT NULL,
  `resp_user_fk` int(10) unsigned default NULL,
  `user_resp_fk` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKF3F7425B3A92013A` (`resp_user_fk`),
  KEY `FKF3F7425B502D886E` (`user_resp_fk`),
  CONSTRAINT `FKF3F7425B3A92013A` FOREIGN KEY (`resp_user_fk`) REFERENCES `responsibility` (`id`),
  CONSTRAINT `FKF3F7425B502D886E` FOREIGN KEY (`user_resp_fk`) REFERENCES `guser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `userresp` */

/*Table structure for table `usertree` */

DROP TABLE IF EXISTS `usertree`;

CREATE TABLE `usertree` (
  `uid` int(10) unsigned NOT NULL,
  `zid` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`uid`,`zid`),
  KEY `user_ztree_FK` (`uid`),
  KEY `ztree_user_FK` (`zid`),
  CONSTRAINT `user_ztree_FK` FOREIGN KEY (`uid`) REFERENCES `guser` (`id`),
  CONSTRAINT `ztree_user_FK` FOREIGN KEY (`zid`) REFERENCES `ztree` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `usertree` */

insert  into `usertree`(`uid`,`zid`) values (0,8),(0,9),(0,15),(0,17),(0,18),(0,23),(0,24),(0,27),(0,28),(0,30),(0,32),(0,34),(0,35),(0,36),(0,37),(0,39),(0,40),(0,41),(0,42),(0,43),(0,44),(0,45),(0,46),(0,60),(0,61),(0,64),(1,29),(1,47),(1,48),(1,49),(1,50),(1,51),(1,52),(1,53),(1,54),(1,56),(1,57),(1,58),(1,59),(1,62),(1,63),(2,1),(2,2),(2,3),(2,4),(2,10),(2,11),(2,12),(2,13),(2,14),(2,16),(2,19),(2,20),(2,21),(2,22),(2,25),(2,26),(2,38),(2,65),(2,66),(3,1),(3,2),(3,3),(3,5),(3,10),(3,11),(3,12),(3,13),(3,14),(3,16),(3,19),(3,20),(3,21),(3,22),(3,25),(3,26),(3,29),(3,31),(3,33),(3,38),(3,47),(3,52),(3,65),(3,66),(4,1),(4,2),(4,13),(4,14),(4,16),(4,22),(4,25),(4,26),(4,38),(4,47),(4,58),(5,1),(5,2),(5,3),(5,4),(5,6),(5,10),(5,12),(5,13),(5,14),(5,16),(5,22),(5,25),(5,26),(5,38),(6,1),(6,7),(6,13),(6,14),(6,22),(6,26),(6,38),(7,22),(7,25),(7,26),(7,38),(7,47),(7,62),(7,63),(8,1),(8,7),(8,22),(8,25),(8,26),(8,38);

/*Table structure for table `ztree` */

DROP TABLE IF EXISTS `ztree`;

CREATE TABLE `ztree` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ico` varchar(30) default NULL,
  `name` varchar(30) NOT NULL,
  `node` varchar(10) NOT NULL,
  `position` varchar(30) default NULL,
  `role` varchar(30) default NULL,
  `title` varchar(30) default NULL,
  `url` varchar(50) default NULL,
  `parentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_Z_PARENTID` (`parentid`),
  CONSTRAINT `FK_Z_PARENTID` FOREIGN KEY (`parentid`) REFERENCES `ztree` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

/*Data for the table `ztree` */

insert  into `ztree`(`id`,`ico`,`name`,`node`,`position`,`role`,`title`,`url`,`parentid`) values (1,'','审批中心','1','Employee','manager','task center of user','../app/index.htm',NULL),(2,'','会议记录','1.1','Employee','manager','Meeting Information','../app/meeting.htm',1),(3,'','待批请假','1.2','Employee','manager','the leave waitting for approve','../app/leaves.htm',1),(4,'','待批申领','1.3','Manager','manager','DaiPi explain get','../app/handle_asset.htm',1),(5,'','开设邮箱','1.4','Employee','manager','为新员工开设邮箱','../app/entrant_mail.htm',1),(6,'','入职审核','1.5','Employee','manager','审核新入职员工资料','../app/approved_entrant.htm',1),(7,'','离职审核','1.6','Director','manager','Departure Audit','../app/departures.htm',1),(8,'','工作管理','2','Employee','user','WorkTask management','../app/index.htm',NULL),(9,'','我的任务','2.1','Employee','user','My Task','../app/my_task.htm',8),(10,'','工作任务','2.2','Manager','manager','Work Task','../app/task.htm',8),(11,'','工作命令','2.3','Director','manager','Work Task Order','../app/order_task.htm',8),(12,'','追踪执行','2.4','Employee','manager','Execution Trace','../app/approval_task.htm',8),(13,'','固定工作','2.5','Employee','manager','Fixed Task','../app/fixed_task.htm',8),(14,'','需要帮忙','2.6','Employee','manager','Need Help','../app/get_help.htm',8),(15,'','培训管理','3','Employee','user','Training management','',NULL),(16,'','人力培训','3.1','Manager','manager','Human training','../app/training.htm',15),(17,'','心得收获','3.2','Employee','user','Experience harvest','../app/get_experiences.htm',15),(18,'','如何做','3.3','Employee','user','How to do','../app/howtodo.htm',15),(19,'','项目管理','4','Manager','parent','System management','',NULL),(20,'','项目','4.1','Manager','manager','Project management','../app/projects.htm',19),(21,'','产品','4.2','Manager','manager','Product management','../app/products.htm',19),(22,'','资产管理','5','Manager','manager','Asset Management','',NULL),(23,'','物资申请','5.1','Employee','user','Material apply for','../app/apply_assets.htm',22),(24,'','申领回执','5.2','Employee','user','For receipt','../app/receipt_asset.htm',22),(25,'','资产清单','5.3','Manager','manager','Assets list','../app/get_assets.htm',22),(26,'','领用记录','5.4','Manager','manager','Use record','../app/borrows.htm',22),(27,'','文管中心','6','Employee','user','File management','../app/resource.htm',NULL),(28,'','文件','6.1','Employee','user','File management','../app/resource.htm',27),(29,'','分组','6.2','Employee','manager','Category management','../admin/category.htm',27),(30,'','责任管理','7','Employee','user','Responsibility management','',NULL),(31,'','主管分配','7.1','Director','manager','Responsibility management','../app/responsibilitys.htm',30),(32,'','我的责任','7.2','Employee','user','User Responsibility','../app/my_responsibility.htm',30),(33,'','责任配置','7.3','Manager','manager','Responsibility Config','../app/respon_config.htm',30),(34,'','私人秘书','8','Employee','user','personal secretary','',NULL),(35,'','请假','8.1','Employee','user','user leave','',34),(36,'','申请','8.1.1','Employee','user','user for leave','../app/leave.htm',35),(37,'','回执','8.1.2','Employee','user','receipt for leave','../app/get_leave.htm',35),(38,'','记录','8.1.3','Employee','manager','record for leave','../app/leave_record.htm',35),(39,'','个人资料','8.2','Employee','user','update user information','',34),(40,'','基本信息','8.2.1','Employee','user','user basic information','../app/edit_user.htm',39),(41,'','教育经历','8.2.2','Employee','user','Education for user','../app/education.htm',39),(42,'','地址列表','8.2.3','Employee','user','list of address for user','../app/address.htm',39),(43,'','修改密码','8.2.4','Employee','user','update user password','../app/update_pwd.htm',39),(44,'','离职','9','Employee','user','Departure Application','',NULL),(45,'','申请','9.1','Employee','user','Departure Application','../app/departure.htm',44),(46,'','回执','9.2','Employee','user','Departure Receipt','../app/get_departure.htm',44),(47,'','系统管理','10','Manager','manager','manager the system user','',NULL),(48,'','左侧菜单','10.1','Manager','parent','ZTree  Management','',47),(49,'','全局配置','10.1.1','Manager','manager','ZTree Management','../admin/trees.htm',48),(50,'','通用配置','10.1.2','Manager','manager','ZTree Basic  Management','../admin/basic_tree.htm',48),(51,'','用户定制','10.1.3','Manager','manager','ZTree User Management','../admin/tree_config.htm',48),(52,'','用户配置','10.2','Manager','manager','Users Config management','../admin/user_config.htm',47),(53,'','系统参数','10.3','Manager','manager','config the system parameter','../admin/config.htm',47),(54,'','组管理','10.4','Manager','manager','System of Group Manager','../admin/group.htm',47),(55,'','用户清单','10.5','Manager','manager','Basic information','../admin/list_users.htm',47),(56,'','流程配置','10.6','Manager','manager','Process','../admin/process.htm',47),(57,'','SWOT配置','10.7','Director','manager','Department Task','../app/swotconfig.htm',47),(58,'','日志记录','10.8','Manager','manager','Logs','../admin/logs.htm',47),(59,'','文件管理','6.3','Manager','manager','后台文件管理','../admin/resources.htm',27),(60,'','邮件配置','8.3','Employee','user','Email Report Config Manager','../app/report_config.htm',34),(61,'','调休','8.1.4','Employee','user','Lieu Manager','../app/lieu.htm',35),(62,'','节假日配置','10.9','Manager','manager','Holidays Config','../app/holidays.htm',47),(63,'','公司格言','10.10','Manager','manager','Motto','../app/motto.htm',47),(64,'','报表预览','8.4','Employee','user','Preview Report','../app/summary.htm',34),(65,'','异常审核','1.7','Manager','manager','Abnormal Manager','../app/abnormals.htm',1),(66,'','职责分配','1.8','Manager','manager','Responsibility Assign','../app/responsibilities.htm',1);

/* Function  structure for function  `insert_attendance` */

/*!50003 DROP FUNCTION IF EXISTS `insert_attendance` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `insert_attendance`(userId INT, date_range INT, in_range INT, jobNo VARCHAR(20), ename VARCHAR(15)) RETURNS int(11)
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
END */$$
DELIMITER ;

/* Function  structure for function  `insert_data` */

/*!50003 DROP FUNCTION IF EXISTS `insert_data` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `insert_data`(in_range INT, in_date DATE, in_item INT, quantity INT, userId INT) RETURNS int(11)
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
END */$$
DELIMITER ;

/* Function  structure for function  `sum_item` */

/*!50003 DROP FUNCTION IF EXISTS `sum_item` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `sum_item`(in_range INT, in_date DATE, in_var INT, in_userId INT, in_item INT) RETURNS int(11)
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `attendance` */

/*!50003 DROP PROCEDURE IF EXISTS  `attendance` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `attendance`(userId INT)
BEGIN
DECLARE jobNo VARCHAR(20);
DECLARE ename VARCHAR(15);
TRUNCATE TABLE attendance_tb;		
SELECT u.jobNo, u.ename INTO jobNo, ename FROM guser AS u WHERE u.id=userId;
select insert_attendance(userId, 0, 0, jobNo, ename);
select insert_attendance(userId, 1, 7, jobNo, ename);
select insert_attendance(userId, 2, 30, jobNo, ename);
select insert_attendance(userId, 4, 365, jobNo, ename);
END */$$
DELIMITER ;

/* Procedure structure for procedure `tj_summary` */

/*!50003 DROP PROCEDURE IF EXISTS  `tj_summary` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `tj_summary`(in_range INT, in_date DATE, userId INT, quantity INT, in_contribution INT, in_plan INT, in_practical INT, in_leave INT, in_lieu INT, in_late INT, in_early INT, in_delay INT)
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
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
