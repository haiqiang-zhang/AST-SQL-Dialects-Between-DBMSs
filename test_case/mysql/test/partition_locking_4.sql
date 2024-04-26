
SET @old_autocommit = @@global.autocommit;
SET @@global.autocommit = 0;
SET @old_lock_wait_timeout= @@global.lock_wait_timeout;
SET @@global.lock_wait_timeout = 1;
SET @old_innodb_lock_wait_timeout= @@global.innodb_lock_wait_timeout;
SET @@global.innodb_lock_wait_timeout = 1;

USE test;

CREATE USER 'mysqltest1'@'localhost';
CREATE USER 'mysqltest2'@'localhost';

CREATE TABLE t1 (a int PRIMARY KEY, b varchar(128), KEY (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;

INSERT INTO t1 VALUES (11, 'First row, p11');
INSERT INTO t1 VALUES (12, 'First row, p12');
INSERT INTO t1 VALUES (13+11, 'Second row, p11');
INSERT INTO t1 VALUES (13+12, 'Second row, p12');
SELECT * FROM t1 ORDER BY a;
INSERT INTO t1 VALUES (13+11, 'Second row, p11');
INSERT INTO t1 VALUES (13+12, 'Second row, p12');
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;
DROP USER 'mysqltest1'@'localhost';
DROP USER 'mysqltest2'@'localhost';
SET @@global.autocommit = @old_autocommit;
SET @@global.lock_wait_timeout= @old_lock_wait_timeout;
SET @@global.innodb_lock_wait_timeout= @old_innodb_lock_wait_timeout;