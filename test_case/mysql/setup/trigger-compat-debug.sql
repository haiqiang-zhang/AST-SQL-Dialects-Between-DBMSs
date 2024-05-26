DROP DATABASE IF EXISTS mysqltest_db1;
CREATE DATABASE mysqltest_db1;
CREATE TABLE t1(num_value INT);
CREATE TABLE t2(user_str TEXT);
CREATE TABLE patch (a blob);
DROP TABLE patch;
