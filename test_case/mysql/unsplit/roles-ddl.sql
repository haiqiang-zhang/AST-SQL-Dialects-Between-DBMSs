CREATE DATABASE db2;
CREATE DATABASE db1;
DROP DATABASE db1;
SELECT CURRENT_USER(), CURRENT_ROLE();
CREATE TABLE db2.test (c1 int);
CREATE DATABASE db3;
CREATE TABLE db2.t1 (c1 INT);
DROP TABLE db2.t1;
CREATE TABLE db2.t1 (c1 INT);
DROP DATABASE db2;