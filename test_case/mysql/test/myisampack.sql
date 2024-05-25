SELECT COUNT(*) FROM t1;
DROP TABLE t1;
CREATE DATABASE mysql_db1;
CREATE TABLE mysql_db1.t1 (c1 VARCHAR(5), c2 int);
DROP DATABASE mysql_db1;
CREATE TABLE t1(a CHAR(4), FULLTEXT(a));
INSERT INTO t1 VALUES('aaaa'),('bbbb'),('cccc');
SELECT * FROM t1 WHERE MATCH(a) AGAINST('aaaa' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(a) AGAINST('aaaa');
DROP TABLE t1;
CREATE TABLE t1(a CHAR(30), FULLTEXT(a));
DROP TABLE t1;
CREATE DATABASE db1;
CREATE TABLE db1.t1(c1 INT) ENGINE=MyISAM;
DROP DATABASE db1;
CREATE TABLE t1(a CHAR(4)) ENGINE=MYISAM;
SELECT table_rows, row_format, table_comment FROM information_schema.tables
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
INSERT INTO t1 VALUES('aaaa'),('bbbb'),('cccc');
SELECT table_rows, row_format, table_comment FROM information_schema.tables
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
SELECT COUNT(*) FROM t1;
SELECT table_rows, row_format, table_comment FROM information_schema.tables
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
SELECT table_rows, row_format, table_comment FROM information_schema.tables
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
SELECT COUNT(*) FROM t1;
SELECT table_rows, row_format, table_comment FROM information_schema.tables
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
DROP TABLE t1;
