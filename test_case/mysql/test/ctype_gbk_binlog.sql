
-- source include/force_binlog_format_statement.inc

RESET BINARY LOGS AND GTIDS;
SET NAMES gbk;

CREATE TABLE t1 (
  f1 BLOB
) DEFAULT CHARSET=gbk;
CREATE PROCEDURE p1(IN val BLOB)
BEGIN
     SET @tval = val;
     SET @sql_cmd = CONCAT_WS(' ', 'insert into t1(f1) values(?)');
     PREPARE stmt FROM @sql_cmd;
     EXECUTE stmt USING @tval;
     DEALLOCATE PREPARE stmt;

SET @`tcontent`:=_binary 0x50434B000900000000000000E9000000 COLLATE `binary`/*!*/;
DROP PROCEDURE p1;

let $MYSQLD_DATADIR= `select @@datadir`;
SELECT hex(f1) FROM t2;
SELECT hex(f1) FROM t1;

DROP PROCEDURE p1;
DROP TABLE t1;
DROP TABLE t2;
