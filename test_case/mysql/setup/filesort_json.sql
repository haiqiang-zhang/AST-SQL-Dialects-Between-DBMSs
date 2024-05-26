CREATE TABLE `F` (
  `col_int_key` int(11) DEFAULT NULL,
  `col_date_key` date DEFAULT NULL,
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `col_varchar_10_utf8` varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  `col_int` int(11) DEFAULT NULL,
  `col_varchar_255_latin1` varchar(255) DEFAULT NULL,
  `col_varchar_255_latin1_key` varchar(255) DEFAULT NULL,
  `col_datetime` datetime DEFAULT NULL,
  `col_varchar_255_utf8_key` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `col_int_key` (`col_int_key`),
  KEY `col_date_key` (`col_date_key`),
  KEY `col_varchar_255_latin1_key` (`col_varchar_255_latin1_key`),
  KEY `col_varchar_255_utf8_key` (`col_varchar_255_utf8_key`)
);
CREATE TABLE `H` (
  `col_date_key` date DEFAULT NULL,
  `col_int` int(11) DEFAULT NULL,
  `col_int_key` int(11) DEFAULT NULL,
  `col_varchar_255_latin1` varchar(255) DEFAULT NULL,
  `col_varchar_255_utf8_key` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `col_varchar_10_utf8` varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `col_datetime` datetime DEFAULT NULL,
  `col_varchar_255_latin1_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `col_date_key` (`col_date_key`),
  KEY `col_int_key` (`col_int_key`),
  KEY `col_varchar_255_utf8_key` (`col_varchar_255_utf8_key`),
  KEY `col_varchar_255_latin1_key` (`col_varchar_255_latin1_key`)
);
