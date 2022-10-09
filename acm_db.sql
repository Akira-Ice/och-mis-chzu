/*
SQLyog  v12.2.6 (64 bit)
MySQL - 8.0.23 : Database - och_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`och_db` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `och_db`;

/*Table structure for table `och_carpool` */

CREATE TABLE `och_carpool` (
  `id` bigint NOT NULL COMMENT 'id',
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发起人',
  `ctime` datetime DEFAULT NULL COMMENT '拼车时间',
  `place` varchar(512) DEFAULT NULL COMMENT '地点',
  `status` int DEFAULT NULL COMMENT '拼车状态',
  `total` int DEFAULT NULL COMMENT '总人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `och_carpool` */

insert  into `och_carpool`(`id`,`username`,`ctime`,`place`,`status`,`total`) values 
(1528591754592452609,'caojiale','2022-05-23 12:20:35','滁州学院-万达',1,1),
(1528625825250664449,'123456','2022-05-23 00:00:00','滁州学院-万达',1,1),
(1528627139649069057,'123456','2022-05-23 14:41:10','滁州学院-苏宁广场',0,3),
(1528650771666399233,NULL,'2022-05-23 16:15:16','1-2',0,3),
(1528656645847871490,'lixin','2022-05-23 16:38:32','lixin-lixin',0,3);

/*Table structure for table `och_discuss` */

CREATE TABLE `och_discuss` (
  `id` bigint NOT NULL COMMENT 'id',
  `cid` bigint DEFAULT NULL COMMENT '拼车id',
  `content` text COMMENT '评论内容',
  `dtime` datetime DEFAULT NULL COMMENT '评论时间',
  `nickname` varchar(128) DEFAULT NULL COMMENT '评论人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `och_discuss` */

insert  into `och_discuss`(`id`,`cid`,`content`,`dtime`,`nickname`) values 
(1528593621456191489,1528591754592452609,'体验很不错！司机人很好！','2022-05-23 12:28:14','李鑫'),
(1528594117659131905,1528591754592452609,'车来的速度很快，挺好','2022-05-23 12:30:12','曹家乐'),
(1528626095418368001,1528591754592452609,'123','2022-05-23 14:37:16','曹家乐');

/*Table structure for table `och_news` */

CREATE TABLE `och_news` (
  `id` bigint NOT NULL COMMENT 'id',
  `title` varchar(128) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `writer` varchar(128) DEFAULT NULL COMMENT '作者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `och_news` */

insert  into `och_news`(`id`,`title`,`content`,`writer`) values 
(0,'关于本市网络预约出租汽车许可延续事项办理的公告','根据《网络预约出租汽车经营服务管理暂行办法》（交通运输部令2019年第46号）和《上海市网络预约出租汽车经营服务管理若干规定》（2016年沪府令第48号）的有关规定，自2020年8月17日起，本市交通行政管理部门将正式受理本市网络预约出租汽车（以下简称“网约车”）经营许可延续及网约车运输证核发（延续）的申请，现将办理流程公告如下：\r\n\r\n一、办理条件\r\n\r\n（一）网络预约出租汽车经营许可延续\r\n\r\n1.具有企业法人资格，非本市注册的企业法人应当在本市设立分支机构；\r\n\r\n2.具备开展网约车经营的互联网平台和与开展业务相适应的信息数据交互及处理能力，具备供交通、通信、公安、税务、网信等相关监管部门依法调取查询相关网络数据信息的条件，网络服务平台数据库接入市交通行政管理部门的行业监管平台；服务器设置在中国内地，有符合规定的网络安全管理制度和安全保护技术措施；\r\n\r\n3.使用电子支付的，应当与银行、非银行支付机构签订提供支付结算服务的协议；\r\n\r\n4.有健全的经营管理制度、安全生产管理制度和服务质量保障制度；\r\n\r\n5.在本市有与注册车辆数和驾驶员人数相适应的办公场所、服务网点和管理人员；\r\n\r\n6.在本市具有依法合规开展经营业务，按规定处理交通行政违法案件等相应服务能力；\r\n\r\n7.投保承运人责任险；\r\n\r\n8.法律法规规定的其他条件。\r\n\r\n外商投资网约车经营的，除符合上述条件外，还应当符合外商投资相关法律法规的规定。\r\n\r\n（二）网络预约出租汽车运输证核发（延续）\r\n\r\n1.在本市注册登记的7座及以下乘用车；\r\n\r\n2.达到本市规定的可予以注册登记的机动车排放标准；\r\n\r\n3.车辆轴距达到2600毫米以上；\r\n\r\n4.通过营业性车辆环保和安全性能检测；\r\n\r\n5.投保营业性交强险、营业性第三者责任险和乘客意外伤害险；\r\n\r\n6.安装符合标准的固定式车载卫星定位装置，数据信息接入行业监管平台；\r\n\r\n7.安装能向公安机关发送应急信息的应急报警装置；\r\n\r\n8.车辆技术性能符合运营安全相关标准要求；\r\n\r\n9.车辆所有人为个人的，车辆所有人持有有效的《道路运输从业人员从业资格证》（网络预约出租汽车驾驶员）；\r\n\r\n10.车辆所有人行驶证名称与营运证件所有人名称相同；\r\n\r\n11.车辆使用期限未满8年；\r\n\r\n12.法律法规规定的其他条件。','123456'),
(1528200517117009921,'滁州申领网约车驾驶员证可网上报名','滁州网讯 自11月末我市网约车细则正式落地开始，不少市民对网约车驾驶员证办理步骤十分关注，究竟在我市开网约车应该符合哪些条件？日前，记者从市运管处了解到，我市已正式开始受理网约车驾驶员报名许可申请，拥有3年以上驾龄且无犯罪记录的本市户籍驾驶员可登录“安徽省出租汽车业务网上申请系统”申请报名，最快本月底可以参加首批从业资格考试。\r\n\r\n酒驾记录者不可开网约车\r\n\r\n根据细则要求，要取得网约车驾驶员许可须满足多项条件，包括取得相应准驾车型机动车驾驶证并具有3年以上驾驶经历、具有本市户籍或者取得市区居住证等。其中，无交通肇事犯罪、无危险驾驶犯罪记录，无暴力犯罪无吸毒记录，无饮酒后驾驶记录，最近连续3个记分周期内没有记满12分记录的材料，由申请人本人提供证明或承诺材料。真实性由运管部门提交公安部门审核。\r\n\r\n拟从事网约车的车辆须同时满足使用本市机动车号牌的7座及以下乘用车，使用未超3年，轴距2550毫米以上等相关条件，再由驾驶员持《巡游出租汽车驾驶员证》或《网约出租汽车驾驶员证》自行或由平台申请网约车运输证，方可营运。\r\n\r\n即日起可进行网上报名\r\n\r\n工作人员告诉记者，申请网约车从业资格考试报名并不复杂，驾驶员只需登录“安徽省出租汽车业务网上申请系统”，然后将驾照、身份证、本人近期两寸蓝底证件照以及细则中提到的无交通肇事犯罪证明或承诺书，上传至报名系统审核，审核通过就可参加考试。\r\n\r\n同时记者了解到，目前滁城部分驾校已开展网约车驾驶员从业资格培训和报名业务，有需求的驾驶员可将以上提到的相关证件和证明复印件，交至驾校统一报名并组织考试。原持有《出租汽车驾驶员从业资格证》的驾驶员，无需进行考试，可直接向市出租车管理机构申请换发《巡游出租汽车驾驶员证》，从事网约车经营。','123456');

/*Table structure for table `och_order` */

CREATE TABLE `och_order` (
  `id` bigint NOT NULL COMMENT 'id',
  `cid` bigint DEFAULT NULL COMMENT '拼车id',
  `paruser` varchar(128) DEFAULT NULL COMMENT '拼车人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `och_order` */

insert  into `och_order`(`id`,`cid`,`paruser`) values 
(1528591817486041090,1528591754592452609,'lixin'),
(1528625979441668097,1528625825250664449,'caojiale'),
(1528627161690136578,1528627139649069057,'caojiale'),
(1528656369124470785,1528627139649069057,'lixin'),
(1528656957975392257,1528656645847871490,'caojiale');

/*Table structure for table `och_user` */

CREATE TABLE `och_user` (
  `id` bigint NOT NULL COMMENT 'id',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `nickname` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `role` int DEFAULT NULL COMMENT '权限代号',
  `status` int DEFAULT NULL COMMENT '激活状态',
  `phone` varchar(128) DEFAULT NULL COMMENT '电话号码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `och_user` */

insert  into `och_user`(`id`,`created_time`,`update_time`,`username`,`password`,`nickname`,`role`,`status`,`phone`) values 
(1526091195033178113,'2022-05-16 14:44:29','2022-05-22 18:43:32','admin','7eecc69a9d7553bc8b6f3ebad7e1a08f','admin',2,1,'15399507439'),
(1526744533861396481,'2022-05-18 10:00:37','2022-05-22 20:33:13','caojiale','7eecc69a9d7553bc8b6f3ebad7e1a08f','曹家乐',1,1,'15399507439'),
(1528330600494374913,'2022-05-22 19:03:05','2022-05-22 19:04:04','lixin','7eecc69a9d7553bc8b6f3ebad7e1a08f','李鑫',1,1,'15399507439'),
(1528330780744589314,'2022-05-22 19:03:48','2022-05-22 19:04:06','libowen','7eecc69a9d7553bc8b6f3ebad7e1a08f','李博文',1,1,'15399507439'),
(1528584765242015746,'2022-05-23 11:53:02','2022-05-23 11:53:43','jinlijuan','7eecc69a9d7553bc8b6f3ebad7e1a08f','金立娟',1,1,'15399507439'),
(1528625525391482882,'2022-05-23 14:35:00','2022-05-23 14:35:29','123456','7eecc69a9d7553bc8b6f3ebad7e1a08f','张三',1,1,'15399507439');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
