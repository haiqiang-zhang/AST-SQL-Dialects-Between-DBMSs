
-- Test for BUG #34982949: dirty reads with repeatable read isolation when "Using index for skip scan"

--echo -- Test setup.

CREATE TABLE `demo` (
  `id` varchar(40) NOT NULL,
  `col_1` varchar(40) NOT NULL,
  `col_2` varchar(40) DEFAULT NULL,
  `col_3` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sec` (`col_2`,`col_3`,`col_1`)
) ENGINE=InnoDB;

INSERT INTO demo (id, col_1, col_2, col_3) VALUES (1, 'same_value_col1', 'same_value_col2', 'different_value');
CREATE PROCEDURE insert_demo_data()
BEGIN
    DECLARE i INT DEFAULT 2;
    DECLARE col_1 VARCHAR(40);
    DECLARE col_2 VARCHAR(40);
    DECLARE col_3 VARCHAR(45);
    WHILE i <= 500 DO
        IF i % 7 = 0 THEN
            SET col_1 = 'another_value_col1';
            SET col_2 = 'another_value_col1';
            SET col_3 = 'another_value_col1';
        ELSE
            SET col_1 = 'same_value_col1';
            SET col_2 = 'same_value_col2';
            SET col_3 = 'same_value_col3';
        END IF;
        INSERT INTO demo (id, col_1, col_2, col_3) VALUES
            (i, col_1, col_2, col_3);
        SET i = i + 1;
    END WHILE;
END |
DELIMITER ;
SET @@autocommit=0;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET @@autocommit=0;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT COUNT(*) FROM demo WHERE col_1='same_value_col1' AND col_3 IS NOT NULL;
UPDATE demo SET col_3 = NULL WHERE col_1='same_value_col1' AND col_3='same_value_col3';
SELECT COUNT(*) FROM demo WHERE col_1='same_value_col1' AND col_3 IS NOT NULL;
DROP PROCEDURE IF EXISTS insert_demo_data;
DROP TABLE demo;