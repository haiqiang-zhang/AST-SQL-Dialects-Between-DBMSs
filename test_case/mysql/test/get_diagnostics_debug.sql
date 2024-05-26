PREPARE stmt FROM 'INSERT INTO t1 VALUES (1)';
SELECT @varErrorMessage, @varErrorNo;
SELECT @varErrorMessage, @varErrorNo;
DROP TABLE t1;
DROP PREPARE stmt;
