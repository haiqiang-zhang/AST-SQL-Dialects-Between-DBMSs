select 2 || 3;
select 2 or 3;
select concat(2,3);
select 2 || 3;
select 2 or 3;
create table t1 (v varchar(10) binary);
drop table t1;
create table t1 (v varchar(10) character set latin1 binary);
drop table t1;
create table t1 (v varchar(10) binary character set latin1);
drop table t1;
create table t1 (v varchar(10) binary ascii);
drop table t1;
create table t1 (v varchar(10) ascii binary);
drop table t1;
create table t1 (v varchar(10) binary unicode);
drop table t1;
create table t1 (v varchar(10) unicode binary);
drop table t1;
create table t1 (v varchar(10));
alter table t1 modify v varchar(10) binary character set latin1;
alter table t1 modify v varchar(10) unicode binary;
alter table t1 modify v varchar(10) binary ascii;
drop table t1;
select collation(cast('a' as char(2))), collation(cast('a' as char(2) binary));
select collation(convert('a', char(2))), collation(convert('a', char(2) binary));
select collation(convert('a',char(2) ascii)), collation(convert('a',char(2) ascii binary));
create table t1 (v binary(10));
drop table t1;
create table t1 (v varchar(10)) character set binary;
drop table t1;
create table t1 (v varchar(10));
alter table t1 character set binary;
drop table t1;
create database mysqltest2 default character set = binary;
drop database mysqltest2;
create database mysqltest2 default character set = latin1;
alter database mysqltest2 default character set = binary;
drop database mysqltest2;
select @@character_set_client;
select @@character_set_client;
select @@character_set_client;
select @@character_set_client;
select convert("123" using binary);
select char(123 using binary);
select collation(char(123)), collation(char(123 using binary));
create table t1 (v varchar(10) byte);
insert into t1 values("xyz");
select * from t1;
drop table t1;
CREATE SCHEMA testdb;
CREATE TABLE testdb.t1 (
    a VARCHAR (10000),
    b VARCHAR (25),
    c VARCHAR (10),
    PRIMARY KEY (a(10),b,c(2))
) PARTITION BY KEY() PARTITIONS 2;
CREATE TABLE testdb.t2 (
    a VARCHAR (200),
    b VARCHAR (10),
    PRIMARY KEY (a(2),b)
) PARTITION BY KEY() PARTITIONS 2;
CREATE TABLE testdb.t3 (
    a VARCHAR (200),
    b VARCHAR (10),
    PRIMARY KEY (a(2),b)
) PARTITION BY KEY() PARTITIONS 10;
CREATE TABLE testdb.t4 (
    a VARCHAR (200),
    b VARCHAR (10),
    c VARCHAR (100),
    KEY (a),
    KEY (b(5))
) PARTITION BY KEY(c) PARTITIONS 10;
ALTER TABLE testdb.t1 COMMENT='t1';
CREATE TABLE testdb.t5 (
    a VARCHAR (10000),
    b VARCHAR (25),
    c VARCHAR (10),
    PRIMARY KEY (a(10),b,c(2))
);
ALTER TABLE testdb.t5 PARTITION BY KEY() PARTITIONS 10;
ALTER TABLE testdb.t5 REMOVE PARTITIONING;
CREATE TABLE testdb.t6 (
    a VARCHAR (200),
    b VARCHAR (10),
    PRIMARY KEY (a(200),b)
) PARTITION BY KEY() PARTITIONS 10;
CREATE TABLE testdb.t7 (
    a VARCHAR (200),
    b VARCHAR (10),
    c VARCHAR (100),
    KEY (a),
    KEY (b(5))
) PARTITION BY KEY(B) PARTITIONS 2;
CREATE TABLE testdb.t8 (
    A VARCHAR (200),
    B VARCHAR (10),
    C VARCHAR (100),
    KEY (A),
    KEY (B(5))
) PARTITION BY KEY(b) PARTITIONS 2;
CREATE TABLE testdb.m1 (
    firstname VARCHAR (25) NOT NULL,
    lastname VARCHAR (25) NOT NULL,
    username VARCHAR (16) NOT NULL,
    email VARCHAR (35),
    joined DATE NOT NULL
) PARTITION BY KEY(joined) PARTITIONS 6;
CREATE TABLE testdb.m2 (
    firstname VARCHAR (25) NOT NULL,
    lastname VARCHAR (25) NOT NULL,
    username VARCHAR (16) NOT NULL,
    email VARCHAR (35),
    joined DATE NOT NULL
) PARTITION BY RANGE(YEAR(joined)) (
    PARTITION p0 VALUES LESS THAN (1960),
    PARTITION p1 VALUES LESS THAN (1970),
    PARTITION p2 VALUES LESS THAN (1980),
    PARTITION p3 VALUES LESS THAN (1990),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
CREATE TABLE testdb.m3 (
    firstname VARCHAR (25) NOT NULL,
    lastname VARCHAR (25) NOT NULL,
    username VARCHAR (16) NOT NULL,
    email VARCHAR (35),
    joined DATE NOT NULL,
    PRIMARY KEY(firstname(5),joined)
) PARTITION BY RANGE(YEAR(joined)) (
    PARTITION p0 VALUES LESS THAN (1960),
    PARTITION p1 VALUES LESS THAN (1970),
    PARTITION p2 VALUES LESS THAN (1980),
    PARTITION p3 VALUES LESS THAN (1990),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
CREATE TABLE testdb.t_char_linear_alg1 (
    prefix_col CHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_varchar_linear_alg1 (
    prefix_col VARCHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_binary_linear_alg1 (
    prefix_col BINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_varbinary_linear_alg1 (
    prefix_col VARBINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_char_nonlinear_alg1 (
    prefix_col CHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_varchar_nonlinear_alg1 (
    prefix_col VARCHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_binary_nonlinear_alg1 (
    prefix_col BINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_varbinary_nonlinear_alg1 (
    prefix_col VARBINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=1 () PARTITIONS 3;
CREATE TABLE testdb.t_char_linear_alg2 (
    prefix_col CHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_varchar_linear_alg2 (
    prefix_col VARCHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_binary_linear_alg2 (
    prefix_col BINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_varbinary_linear_alg2 (
    prefix_col VARBINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY LINEAR KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_char_nonlinear_alg2 (
    prefix_col CHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_varchar_nonlinear_alg2 (
    prefix_col VARCHAR (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_binary_nonlinear_alg2 (
    prefix_col BINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=2 () PARTITIONS 3;
CREATE TABLE testdb.t_varbinary_nonlinear_alg2 (
    prefix_col VARBINARY (100),
    other_col VARCHAR (5),
    PRIMARY KEY (prefix_col(10), other_col)
) PARTITION BY KEY ALGORITHM=2 () PARTITIONS 3;
DROP SCHEMA testdb;
SELECT * FROM INFORMATION_SCHEMA.TABLESPACES;
SELECT * FROM INFORMATION_SCHEMA.tablespaces;
SELECT * FROM INFORMATION_SCHEMA.TABLES JOIN INFORMATION_SCHEMA.TABLESPACES;
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLESPACES);