

--
-- Bug#41049 does syntax "grant" case insensitive?
--
create database db1;
CREATE USER user_1@localhost, USER_1@localhost;
CREATE TABLE t1(f1 int);
SELECT * FROM t1;
SELECT * FROM t1;
CREATE TABLE t2(f1 int);
DROP USER user_1@localhost;
DROP USER USER_1@localhost;
DROP DATABASE db1;
use test;
