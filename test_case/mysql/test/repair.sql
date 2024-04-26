
--
-- Test of repair table
--

--disable_warnings
drop table if exists t1;

create table t1 SELECT 1,"table 1";
alter table t1 ENGINE=HEAP;
drop table t1;

--
-- disabled keys during repair
--
create table t1(id int PRIMARY KEY, st varchar(10), KEY st_key(st));
insert into t1 values(1, "One");
alter table t1 disable keys;
drop table t1;


-- non-existent table
repair table t1 use_frm;

create table t1 engine=myisam SELECT 1,"table 1";
let $MYSQLD_DATADIR= `select @@datadir`;
drop table t1;

--
-- BUG#22562 - REPAIR TABLE .. USE_FRM causes server crash on Windows and
--             server hangs on Linux
--
CREATE TABLE t1(a INT);
USE mysql;
USE test;
DROP TABLE t1;

--
-- BUG#23175 - MYISAM crash/repair failed during repair
--
CREATE TABLE t1(a CHAR(255), KEY(a)) charset latin1;
SET myisam_sort_buffer_size=4096;
INSERT INTO t1 VALUES
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0');
SET myisam_sort_buffer_size=@@global.myisam_sort_buffer_size;
DROP TABLE t1;

--
-- BUG#31174 - "Repair" command on MyISAM crashes with small 
--              myisam_sort_buffer_size
--
CREATE TABLE t1(a CHAR(255), KEY(a)) charset latin1;
SET myisam_sort_buffer_size=4496;
INSERT INTO t1 VALUES
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),('0'),
('0'),('0'),('0'),('0'),('0'),('0'),('0');
SET myisam_sort_buffer_size=@@global.myisam_sort_buffer_size;
DROP TABLE t1;


--
-- Bug#18775 - Temporary table from alter table visible to other threads
--
-- REPAIR TABLE ... USE_FRM on temporary table crashed the table or server.
--disable_warnings
DROP TABLE IF EXISTS tt1;
CREATE TEMPORARY TABLE tt1 (c1 INT);
DROP TABLE tt1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT);
DROP TABLE t1;
drop tables if exists t1, t2;
create table t1 (i int);
create table t2 (j int);
set @@autocommit= 0;
set @@autocommit= default;
drop tables t1, t2;
