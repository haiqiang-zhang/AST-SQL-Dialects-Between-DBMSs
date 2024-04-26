
-- This does not work for RBR yet.
--source include/force_binlog_format_statement.inc

--disable_query_log
CALL mtr.add_suppression("Unsafe statement written to the binary log using statement format since BINLOG_FORMAT = STATEMENT");

CREATE TABLE t1 ( a int );
INSERT INTO t1 VALUES (1),(2),(1);
CREATE TABLE t2 ( PRIMARY KEY (a) ) ENGINE=INNODB SELECT a FROM t1;
select * from t2;
CREATE TEMPORARY TABLE t2 ( PRIMARY KEY (a) ) ENGINE=INNODB SELECT a FROM t1;
select * from t2;
drop table t1;
