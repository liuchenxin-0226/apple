/*
Navicat MySQL Data Transfer

Source Server         : lcx
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : apple

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2020-10-17 10:40:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `good_name` varchar(20) NOT NULL COMMENT '商品名称',
  `sex` varchar(20) NOT NULL DEFAULT '男' COMMENT '性别',
  `email` varchar(20) DEFAULT NULL,
  `eid` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`,`good_name`,`sex`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `fk_eid` (`eid`),
  CONSTRAINT `fk_eid` FOREIGN KEY (`eid`) REFERENCES `emp` (`empno`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
