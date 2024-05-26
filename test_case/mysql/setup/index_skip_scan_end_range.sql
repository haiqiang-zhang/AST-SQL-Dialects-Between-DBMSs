CREATE TABLE `demo` (
  `id` varchar(40) NOT NULL,
  `col_1` varchar(40) NOT NULL,
  `col_2` varchar(40) DEFAULT NULL,
  `col_3` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sec` (`col_2`,`col_3`,`col_1`)
) ENGINE=InnoDB;
INSERT INTO demo (id, col_1, col_2, col_3) VALUES (1, 'same_value_col1', 'same_value_col2', 'different_value');
