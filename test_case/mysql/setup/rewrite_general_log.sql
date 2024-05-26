CREATE TABLE     t1(f1 INT, f2 INT, f3 INT, f4 INT);
CREATE PROCEDURE proc_rewrite_1() INSERT INTO test.t1 VALUES ("hocus pocus");
DROP PROCEDURE proc_rewrite_1;
DROP TABLE     t1;
CREATE TABLE test_log (argument TEXT);
