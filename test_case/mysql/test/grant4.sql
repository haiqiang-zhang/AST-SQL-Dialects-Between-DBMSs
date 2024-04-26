drop database if exists mysqltest_db1;
create database mysqltest_db1;
use mysqltest_db1;
create table t_column_priv_only (a int, b int);
create table t_select_priv like t_column_priv_only;
create table t_no_priv like t_column_priv_only;
create user mysqltest_u1@localhost;
insert into mysqltest_db1.t_column_priv_only (a) VALUES (1);
select column_name as 'Field',column_type as 'Type',is_nullable as 'Null',column_key as 'Key',column_default as 'Default',extra as 'Extra' from information_schema.columns where table_schema='mysqltest_db1' and table_name='t_column_priv_only';
select column_name as 'Field',column_type as 'Type',is_nullable as 'Null',column_key as 'Key',column_default as 'Default',extra as 'Extra' from information_schema.columns where table_schema='mysqltest_db1' and table_name='t_no_priv';
create table test.t_no_priv like mysqltest_db1.column_priv_only;
select * from mysqltest_db1.t_column_priv_only;
drop table if exists test.t_duplicated;
create table test.t_duplicated like mysqltest_db1.t_select_priv;
drop table test.t_duplicated;

--
-- SHOW INDEX
--
use mysqltest_db1;
CREATE TABLE t5 (s1 INT);
CREATE INDEX i ON t5 (s1);
CREATE TABLE t6 (s1 INT, s2 INT);
CREATE VIEW v5 AS SELECT * FROM t5;
CREATE VIEW v6 AS SELECT * FROM t6;
CREATE VIEW v2 AS SELECT * FROM t_select_priv;
CREATE VIEW v3 AS SELECT * FROM t_select_priv;
CREATE INDEX i ON t6 (s1);
use mysqltest_db1;
SELECT * FROM INFORMATION_SCHEMA.STATISTICS WHERE table_name='t5';

-- CHECK TABLE
--echo ** CHECK TABLE requires any privilege on any column combination and should succeed for t6:
CHECK TABLE t6;

-- CHECKSUM
--echo ** CHECKSUM TABLE requires SELECT privileges on the table. The following should fail:
--error 1142
CHECKSUM TABLE t6;

-- SHOW CREATE VIEW
--error 1142
SHOW CREATE VIEW v5;
drop database mysqltest_db1;
drop user mysqltest_u1@localhost;

USE test;

CREATE TEMPORARY TABLE save_user AS SELECT * FROM mysql.user;
CREATE TEMPORARY TABLE save_role_edges AS SELECT * FROM mysql.role_edges;
INSERT INTO mysql.user(user,plugin,ssl_cipher,x509_issuer,x509_subject) VALUES ('foo','bar','','',''),('bar','bar','','',''),('baz','bar','','','');
CREATE ROLE r1,r2,r3;
CREATE USER''@''IDENTIFIED WITH 'server' AS 'user';
UPDATE mysql.user SET plugin='';
CREATE USER plug IDENTIFIED WITH 'server';
DELETE FROM mysql.user;
INSERT INTO mysql.user SELECT * FROM save_user;
DELETE FROM mysql.role_edges;
INSERT INTO mysql.role_edges SELECT * FROM save_role_edges;
CREATE USER testuser@localhost;
CREATE ROLE testrole;
DROP USER testuser@localhost;
DROP USER testrole;
CREATE USER ''@'';
DROP USER ''@'';
