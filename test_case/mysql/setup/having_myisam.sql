CREATE TABLE `t1` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `int_key` int(11) NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `int_key` (`int_key`)
) AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
INSERT INTO `t1` VALUES (1,7),(2,9);
