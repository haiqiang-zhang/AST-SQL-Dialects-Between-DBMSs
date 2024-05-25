CREATE TABLE `demo` (
  `id` varchar(40) NOT NULL,
  `col_1` varchar(40) NOT NULL,
  `col_2` varchar(40) DEFAULT NULL,
  `col_3` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sec` (`col_2`,`col_3`,`col_1`)
) ENGINE=InnoDB;
INSERT INTO demo (id, col_1, col_2, col_3) VALUES (1, 'same_value_col1', 'same_value_col2', 'different_value');
SELECT COUNT(*) FROM demo WHERE col_1='same_value_col1' AND col_3 IS NOT NULL;
UPDATE demo SET col_3 = NULL WHERE col_1='same_value_col1' AND col_3='same_value_col3';
SELECT COUNT(*) FROM demo WHERE col_1='same_value_col1' AND col_3 IS NOT NULL;
DROP PROCEDURE IF EXISTS insert_demo_data;
DROP TABLE demo;
