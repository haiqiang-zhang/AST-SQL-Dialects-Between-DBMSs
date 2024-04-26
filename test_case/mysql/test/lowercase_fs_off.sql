
--
-- Specific tests for case sensitive file systems
-- i.e. lower_case_filesystem=OFF
--
-- source include/have_case_sensitive_file_system.inc
-- source include/have_lowercase0.inc

set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
create database d1;
create user 'sample'@'localhost' identified by 'password';
select database();
create database d2;
create database D1;
drop user 'sample'@'localhost';
drop database if exists d1;

-- End of 4.1 tests

--
-- Bug#41049 does syntax "grant" case insensitive?
--
CREATE DATABASE d1;
USE d1;
CREATE USER user_1@localhost;
CREATE TABLE T1(f1 INT);
CREATE TABLE t1(f1 INT);
select * from t1;
select * from T1;
select * from information_schema.table_privileges;
DROP USER user_1@localhost;
DROP DATABASE d1;
USE test;

CREATE DATABASE db1;
USE db1;
CREATE PROCEDURE p1() BEGIN END;
CREATE FUNCTION f1(i INT) RETURNS INT RETURN i+1;
CREATE USER user_1@localhost, USER_1@localhost;
select f1(1);
select f1(1);
DROP FUNCTION f1;
DROP PROCEDURE p1;
DROP USER user_1@localhost;
DROP USER USER_1@localhost;
DROP DATABASE db1;
use test;

set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;

-- End of 5.0 tests


--echo --
--echo -- Extra test coverage for Bug#56595 RENAME TABLE causes assert on OS X
--echo --

CREATE TABLE t1(a INT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET new.a= 1;
ALTER TABLE T1 RENAME t1;
DROP TABLE t1;

let BASEDIR=    `select @@basedir`;
let DDIR=       $MYSQL_TMP_DIR/lctn_test;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
let extra_args= --no-defaults --innodb_dedicated_server=OFF  --secure-file-priv="" --log-error=$MYSQLD_LOG --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL= $MYSQL_TMP_DIR/tiny_bootstrap.sql;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $c_w= grep(/Different lower_case_table_names settings/gi,<FILE>);
