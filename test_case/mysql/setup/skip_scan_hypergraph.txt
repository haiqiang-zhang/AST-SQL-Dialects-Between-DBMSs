CREATE TABLE `t1` (
  `pk` int NOT NULL AUTO_INCREMENT,
  `col_int_key` int DEFAULT NULL,
  `col_varchar_key` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `idx_t1_col_int_key` (`col_int_key`),
  KEY `idx_t1_col_varchar_key` (`col_varchar_key`));
CREATE TABLE `t2` (
  `pk` int NOT NULL AUTO_INCREMENT,
  `col_varchar_key` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `idx_t2_col_varchar_key` (`col_varchar_key`));
