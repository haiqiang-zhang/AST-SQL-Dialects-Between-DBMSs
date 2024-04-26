CREATE TABLE t1 (a SERIAL) ENGINE = InnoDB
PARTITION BY KEY ALGORITHM = 1 () PARTITIONS 3;
INSERT INTO t1 VALUES (10);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (5);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
INSERT INTO t1 VALUES (10);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (NULL);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES (10);
INSERT INTO t2 VALUES (3), (NULL), (4);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release TIMEOUT 2";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (5);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
INSERT INTO t1 VALUES (10);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release TIMEOUT 2";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (NULL);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
DROP TABLE t1, t2;
SET DEBUG_SYNC='RESET';
