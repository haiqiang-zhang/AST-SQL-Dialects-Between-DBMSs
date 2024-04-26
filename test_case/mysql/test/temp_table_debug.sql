
-- It also requires various storage engines.
--source include/have_archive.inc
--source include/have_blackhole.inc
--source include/have_myisam.inc

-- windows does not support symlink
--source include/not_windows.inc

--echo -- Create temporary tables in various storage engines.
create temporary table ta (i int not null) engine=archive;
create temporary table tb (i int not null) engine=blackhole;
create temporary table tc (i int not null) engine=csv;
create temporary table th (i int not null) engine=heap;
create temporary table ti (i int not null) engine=innodb;
create temporary table tm (i int not null) engine=myisam;
create temporary table tg (i int not null) engine=merge union=();
let $MYSQLD_DATADIR= `select @@datadir`;
create database mysqltest;
create table mysqltest.t1 (i int not null) engine=myisam;
select * from ti;
set session debug="+d,crash_commit_before";
drop database mysqltest;
