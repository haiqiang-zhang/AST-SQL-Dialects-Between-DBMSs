
-- source include/force_binlog_format_statement.inc

RESET BINARY LOGS AND GTIDS;
SET NAMES gb18030;

CREATE TABLE t1 (
  f1 BLOB
) DEFAULT CHARSET=gb18030;
CREATE PROCEDURE p1(IN val BLOB)
BEGIN
     SET @tval = val;
     SET @sql_cmd = CONCAT_WS(' ', 'INSERT INTO t1(f1) VALUES(?)');
     PREPARE stmt FROM @sql_cmd;
     EXECUTE stmt USING @tval;
     DEALLOCATE PREPARE stmt;

SET @`tcontent`:='测试binlog复制，测试四字节编码:㐂㐃㐄,焊䏷菡釬';
DROP PROCEDURE p1;

let $MYSQLD_DATADIR= `select @@datadir`;
SELECT hex(f1), f1 FROM t2;
SELECT hex(f1), f1 FROM t1;

DROP PROCEDURE p1;
DROP TABLE t1;
DROP TABLE t2;
