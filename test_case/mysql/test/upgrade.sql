drop database if exists `mysqltest1`;
drop database if exists `mysqltest-1`;
drop database if exists `--mysql50#mysqltest-1`;

--
-- Special handling of the #mysql50# prefix has been removed.
-- It is now treated as any other identifier part. I.e. it has to
-- be quoted and will remain part of the identifier name.
--

create database `mysqltest1`;
create database `--mysql50#mysqltest-1`;
create table `mysqltest1`.`t1` (a int);
create table `mysqltest1`.`--mysql50#t-1` (a int);
create table `--mysql50#mysqltest-1`.`t1` (a int);
create table `--mysql50#mysqltest-1`.`#mysql50#t-1` (a int);
drop database `mysqltest1`;
drop database `--mysql50#mysqltest-1`;

--
-- Bug#17142: Crash if create with encoded name
--
--disable_warnings
drop table if exists `txu@0023p@0023p1`;
drop table if exists `txu--p#p1`;
create table `txu--p#p1` (s1 int);
insert into `txu--p#p1` values (1);
select * from `txu@0023p@0023p1`;
create table `txu@0023p@0023p1` (s1 int);
insert into `txu@0023p@0023p1` values (2);
select * from `txu@0023p@0023p1`;
select * from `txu--p#p1`;
drop table `txu@0023p@0023p1`;
drop table `txu--p#p1`;
use test;

-- ... UPGRADE DATA DICTIONARY NAME syntax has been removed.

-- #mysql50# is now treated as any other db name
--error ER_BAD_DB_ERROR
USE `--mysql50#.`;
USE `--mysql50#../blablabla`;

let DATADIR= $MYSQL_TMP_DIR/data_50740_invalid_filenames;
let MYSQLD_LOG= $MYSQL_TMP_DIR/data_50740_invalid_filenames/error.log;
