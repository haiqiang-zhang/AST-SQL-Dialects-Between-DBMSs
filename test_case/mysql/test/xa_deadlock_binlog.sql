
CREATE TABLE t1 (c1 INT AUTO_INCREMENT PRIMARY KEY, c2 VARCHAR(5));
INSERT INTO t1(c2) VALUES("a");
INSERT INTO t1(c2) VALUES("b");

XA START 'xa1_t1';
SELECT * FROM t1 WHERE c1 = 2 FOR UPDATE;
UPDATE t1 SET c2 = 'c' WHERE c1 = 2;
SELECT * FROM t1 WHERE c1 = 1 FOR UPDATE;
UPDATE t1 SET c2 = 'd' WHERE c1 = 1;
SELECT * FROM t1 WHERE c1 = 2 FOR UPDATE;
UPDATE t1 SET c2 = 'e' WHERE c1 = 1;
UPDATE t1 SET c2 = 'f' WHERE c1 = 2;
SELECT c1 FROM t1;

-- Successfully rollbacks the transaction.
XA ROLLBACK 'xa2_t1';

-- Assuring that the table holds the right data in its fields.
--let $assert_text= Incorrect content in table t1. c2 should contain 'e'
--let $assert_cond= "[SELECT c2 FROM t1 WHERE c1 = 1]" = \'e\'
--source include/assert.inc
--let $assert_text= Incorrect content in table t1. c2 should contain 'c'
--let $assert_cond= "[SELECT c2 FROM t1 WHERE c1 = 2]" = \'c\'
--source include/assert.inc

--sync_slave_with_master
--source include/rpl_connection_master.inc
--let $binlog_file= LAST
--source include/show_binlog_events.inc

--source include/rpl_connection_master1.inc
CREATE TABLE t2 (c1 int);
DROP TABLE t1, t2;
