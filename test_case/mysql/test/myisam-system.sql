
--
-- Test how DROP TABLE works if the index or data file doesn't exists
-- myisam specific test
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Initialise
--disable_warnings
drop table if exists t1,t2;

create table t1 (a int) engine=myisam;
let $MYSQLD_DATADIR= `select @@datadir`;
drop table t1;
select * from t1;
drop table if exists t1;
create table t1 (a int) engine=myisam;
drop table t1;
select * from t1;
drop table if exists t1;
drop table t1;
