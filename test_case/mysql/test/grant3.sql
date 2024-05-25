drop table if exists t1;
create table t1 (a int);
drop table t1;
CREATE DATABASE mysqltest_1;
CREATE TABLE mysqltest_1.t1 (a INT);
DROP DATABASE mysqltest_1;
CREATE DATABASE temp;
CREATE TABLE temp.t1(a INT, b VARCHAR(10));
DROP DATABASE temp;
