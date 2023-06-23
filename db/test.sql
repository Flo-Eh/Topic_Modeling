DROP DATABASE IF EXISTS `DB`;
CREATE DATABASE `DB`;
USE `DB`;
DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `OrderTime` datetime,
  `Item` varchar(100) NOT NULL
);