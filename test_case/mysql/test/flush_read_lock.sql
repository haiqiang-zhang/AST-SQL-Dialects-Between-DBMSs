--

-- We need InnoDB for COMMIT/ROLLBACK related tests.
-- We need the Debug Sync Facility.
--source include/have_debug_sync.inc
-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Needs --xa_detach_on_prepare to hit debug sync points
--let $option_name = xa_detach_on_prepare
--let $option_value = 1
--source include/only_with_option.inc

--echo -- FTWRL takes two global metadata locks -- a global shared
--echo -- metadata lock and the commit blocker lock.
--echo -- The first lock prevents DDL from taking place.
--echo -- Let's say that all DDL statements that take metadata
--echo -- locks form class #1 -- incompatible with FTWRL because
--echo -- take incompatible MDL table locks.
--echo -- The first global lock doesn't, however, prevent standalone
--echo -- COMMITs (or implicit COMMITs) from taking place, since a
--echo -- COMMIT doesn't take table locks. It doesn't prevent
--echo -- DDL on temporary tables either, since they don't
--echo -- take any table locks either.
--echo -- Most DDL statements do not perform an implicit commit
--echo -- if operate on a temporary table. Examples are CREATE
--echo -- TEMPORARY TABLE and DROP TEMPORARY TABLE. 
--echo -- Thus, these DDL statements can go through in presence
--echo -- of FTWRL. This is class #2 -- compatible because
--echo -- do not take incompatible MDL locks and do not issue
--echo -- implicit commit..
--echo -- (Although these operations do not commit, their effects
--echo -- cannot be rolled back either.)
--echo -- ALTER TABLE, ANALYZE, OPTIMIZE and some others always
--echo -- issue an implicit commit, even if its argument is a
--echo -- temporary table. 
--echo -- *Howewer* an implicit commit is a no-op if all engines
--echo -- used since the start of transactiona are non-
--echo -- transactional. Thus, for non-transactional engines,
--echo -- these operations are not blocked by FTWRL.
--echo -- This is class #3 -- compatible because do not take
--echo -- MDL table locks and are non-transactional. 
--echo -- On the contrary, for transactional engines, there
--echo -- is always a commit, regardless of whether a table
--echo -- is temporary or not. Thus, for example, ALTER TABLE
--echo -- for a transactional engine will wait for FTWRL, 
--echo -- even if the subject table is temporary.
--echo -- Thus ALTER TABLE <temporary> is incompatible
--echo -- with FTWRL. This is class #4 -- incompatible
--echo -- becuase issue implicit COMMIT which is not a no-op.
--echo -- Finally, there are administrative statements (such as 
--echo -- RESET SLAVE) that do not take any locks and do not
--echo -- issue COMMIT.
--echo -- This is class #5.
--echo -- The goal of this coverage is to test statements
--echo -- of all classes.
--echo -- @todo: documents the effects of @@autocommit,
--echo -- DML and temporary transactional tables.

--echo -- Use MyISAM engine for the most of the tables
--echo -- used in this test in order to be able to 
--echo -- check that DDL statements on temporary tables
--echo -- are compatible with FTRWL. 
--disable_warnings
drop tables if exists t1_base, t2_base, t3_trans;
drop tables if exists tm_base, tm_base_temp;
drop database if exists mysqltest1;
drop database if exists `--mysql50#mysqltest-2`;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists v1;
drop procedure if exists p2;
drop function if exists f2_base;
drop event if exists e1;
drop event if exists e2;
create table t1_base(i int) engine=myisam;
create table t2_base(j int) engine=myisam;
create table t3_trans(i int) engine=innodb;
create temporary table t1_temp(i int) engine=myisam;
create temporary table t2_temp(j int) engine=myisam;
create temporary table t3_temp_trans(i int) engine=innodb;
create database mysqltest1;
create database `--mysql50#mysqltest-2`;
create procedure p1() begin end;
create function f1() returns int return 0;
create view v1 as select 1 as i;
create procedure p2(i int) begin end;
create function f2_base() returns int
begin
  insert into t1_base values (1);
create event e1 on schedule every 1 minute do begin end;

let $con_aux1=con1;
let $con_aux2=con2;
let $cleanup_stmt2= ;
let $skip_3rd_check= ;
let $statement= alter table t1_base add column c1 int;
let $cleanup_stmt1= alter table t1_base drop column c1;
let $statement= alter table t1_temp add column c1 int;
let $cleanup_stmt= alter table t1_temp drop column c1;
let $statement= alter database mysqltest1 default character set utf8mb3;
let $cleanup_stmt1= alter database mysqltest1 default character set latin1;
let $statement= alter procedure p1 comment 'a';
let $cleanup_stmt1= alter procedure p1 comment '';
let $statement= alter function f1 comment 'a';
let $cleanup_stmt1= alter function f1 comment '';
let $statement= alter view v1 as select 2 as j;
let $cleanup_stmt1= alter view v1 as select 1 as i;
let $statement= alter event e1 comment 'test';
let $cleanup_stmt1= alter event e1 comment '';
let $statement= analyze table t1_base;
let $cleanup_stmt= ;
insert into t3_trans values (1);
insert into t3_trans values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "commit";
delete from t3_trans;
insert into t3_trans values (1);
set debug_sync='RESET';
set debug_sync='ha_commit_trans_after_acquire_commit_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "flush tables with read lock";
set debug_sync='now SIGNAL go';
delete from t3_trans;
set debug_sync= "RESET";
let $statement= BINLOG '
MfmqTBMBAAAALgAAAN0AAAAAACgAAAAAAAEABHRlc3QAB3QxX2Jhc2UAAQMAAQ==
MfmqTBcBAAAAIgAAAP8AAAAAACgAAAAAAAEAAf/+AQAAAA==
';
let $cleanup_stmt1= delete from t1_base where i = 1 limit 1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= call p2((select count(*) from t1_base));
let $cleanup_stmt1= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= call p2(f2_base());
let $cleanup_stmt1= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= check table t1_base;
let $cleanup_stmt= ;
let $statement= checksum table t1_base;
let $cleanup_stmt= ;
let $statement= create table t3_base(i int);
let $cleanup_stmt1= drop table t3_base;
let $statement= create temporary table t3_temp(i int);
let $cleanup_stmt= drop temporary tables t3_temp;
let $statement= create table t3_base like t1_temp;
let $cleanup_stmt1= drop table t3_base;
let $statement= create temporary table t3_temp like t1_base;
let $cleanup_stmt= drop temporary table t3_temp;
let $statement= create table t3_base select 1 as i;
let $cleanup_stmt1= drop table t3_base;
let $statement= create temporary table t3_temp select 1 as i;
let $cleanup_stmt= drop temporary table t3_temp;
let $statement= create index i on t1_base (i);
let $cleanup_stmt1= drop index i on t1_base;
let $statement= create index i on t1_temp (i);
let $cleanup_stmt= drop index i on t1_temp;
let $statement= create database mysqltest2;
let $cleanup_stmt1= drop database mysqltest2;
let $statement= create view v2 as select 1 as j;
let $cleanup_stmt1= drop view v2;
let $statement= create trigger t1_bi before insert on t1_base for each row begin end;
let $cleanup_stmt1= drop trigger t1_bi;
let $statement= create function f2() returns int return 0;
let $cleanup_stmt1= drop function f2;
let $statement= create procedure p3() begin end;
let $cleanup_stmt1= drop procedure p3;
let $statement= create event e2 on schedule every 1 minute do begin end;
let $cleanup_stmt1= drop event e2;
let $statement= create user mysqltest_u1;
let $cleanup_stmt1= drop user mysqltest_u1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= prepare stmt1 from 'insert into t1_base values (1)';
let $cleanup_stmt= deallocate prepare stmt1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= prepare stmt1 from 'update t1_base, t2_base set t1_base.i= 1 where t1_base.i = t2_base.j';
let $cleanup_stmt= deallocate prepare stmt1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= prepare stmt1 from 'delete t1_base from t1_base, t2_base where t1_base.i = t2_base.j';
let $cleanup_stmt= deallocate prepare stmt1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= execute stmt1;
let $cleanup_stmt= ;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1_base values (1)";
set debug_sync='RESET';
set debug_sync='execute_command_after_close_tables SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
set debug_sync='now SIGNAL go';
set debug_sync= "RESET";
delete from t1_base;
let $statement= deallocate prepare stmt1;
let $cleanup_stmt= prepare stmt1 from 'insert into t1_base values (1)';
let $statement= delete from t1_base;
let $cleanup_stmt1= ;
let $statement= delete from t1_temp;
let $cleanup_stmt= ;
let $statement= delete t1_base from t1_base, t2_base where t1_base.i = t2_base.j;
let $cleanup_stmt1= ;
let $statement= delete t1_temp from t1_temp, t2_temp where t1_temp.i = t2_temp.j;
let $cleanup_stmt= ;
let $statement= describe t1_base;
let $cleanup_stmt= ;
let $statement= do (select count(*) from t1_base);
let $cleanup_stmt= ;
let $statement= do f2_base();
let $cleanup_stmt1= delete from t1_base limit 1;
let $statement= drop table t2_base;
let $cleanup_stmt1= create table t2_base(j int);
let $statement= drop table t2_temp;
let $cleanup_stmt= create temporary table t2_temp(j int);
let $statement= drop temporary table t2_temp;
let $cleanup_stmt= create temporary table t2_temp(j int);
create index i on t1_base (i);
let $statement= drop index i on t1_base;
let $cleanup_stmt1= create index i on t1_base (i);
drop index i on t1_base;
create index i on t1_temp (i);
let $statement= drop index i on t1_temp;
let $cleanup_stmt= create index i on t1_temp (i);
drop index i on t1_temp;
let $statement= drop database mysqltest1;
let $cleanup_stmt1= create database mysqltest1;
let $statement= drop function f1;
let $cleanup_stmt1= create function f1() returns int return 0;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= drop procedure p1;
let $cleanup_stmt1= create procedure p1() begin end;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
create user mysqltest_u1;
let $statement= drop user mysqltest_u1;
let $cleanup_stmt1= create user mysqltest_u1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= drop view v1;
let $cleanup_stmt1= create view v1 as select 1 as i;
let $statement= drop event e1;
let $cleanup_stmt1= create event e1 on schedule every 1 minute do begin end;
create trigger t1_bi before insert on t1_base for each row begin end;
let $statement= drop trigger t1_bi;
let $cleanup_stmt1= create trigger t1_bi before insert on t1_base for each row begin end;
drop trigger t1_bi;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables with read lock";
let $statement= flush tables;
let $cleanup_stmt= ;
let $statement= flush table t1_base, t2_base;
let $cleanup_stmt= ;
let $statement= flush privileges;
let $cleanup_stmt= ;
let $statement= grant all privileges on t1_base to mysqltest_u1;
let $cleanup_stmt1= revoke all privileges on t1_base from mysqltest_u1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
drop user mysqltest_u1;
let $statement= help no_such_topic;
let $cleanup_stmt= ;
let $statement= insert into t1_base values (1);
let $cleanup_stmt1= delete from t1_base limit 1;
let $statement= insert into t1_temp values (1);
let $cleanup_stmt= delete from t1_temp limit 1;
let $statement= insert into t1_base select * from t1_temp;
let $cleanup_stmt1= ;
let $statement= insert into t1_temp select * from t1_base;
let $cleanup_stmt= ;
set @id:= connection_id();
set debug_sync='RESET';
set debug_sync='execute_command_after_close_tables SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
set debug_sync='now SIGNAL go';
set debug_sync='RESET';
let $statement= load data infile '../../std_data/rpl_loaddata.dat' into table t1_base (@dummy, i);
let $cleanup_stmt1= delete from t1_base;
let $statement= load data infile '../../std_data/rpl_loaddata.dat' into table t1_temp (@dummy, i);
let $cleanup_stmt= delete from t1_temp;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "lock tables t1_base write";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "optimize table t1_base";
let $statement= optimize table t1_temp;
let $cleanup_stmt= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= cache index t1_base in default;
let $cleanup_stmt= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= load index into cache t1_base;
let $cleanup_stmt= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
insert into t3_trans values (1);
insert into t3_trans values (2);
insert into t3_trans values (1);
set debug_sync='RESET';
set debug_sync='execute_command_after_close_tables SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
set debug_sync='now SIGNAL go';
insert into t3_trans values (2);
set debug_sync='execute_command_after_close_tables SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
set debug_sync='now SIGNAL go';
set debug_sync='execute_command_after_close_tables SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
set debug_sync='now SIGNAL go';
set debug_sync= "RESET";
let $statement= rename table t1_base to t3_base;
let $cleanup_stmt1= rename table t3_base to t1_base;
create user mysqltest_u1;
let $statement= rename user mysqltest_u1 to mysqltest_u2;
let $cleanup_stmt1= rename user mysqltest_u2 to mysqltest_u1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
drop user mysqltest_u1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "repair table t1_base";
let $statement= repair table t1_temp;
let $cleanup_stmt= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= replace into t1_base values (1);
let $cleanup_stmt1= delete from t1_base limit 1;
let $statement= replace into t1_temp values (1);
let $cleanup_stmt= delete from t1_temp limit 1;
let $statement= replace into t1_base select * from t1_temp;
let $cleanup_stmt1= ;
let $statement= replace into t1_temp select * from t1_base;
let $cleanup_stmt= ;
create user mysqltest_u1;
let $statement= revoke all privileges on t1_base from mysqltest_u1;
let $cleanup_stmt1= grant all privileges on t1_base to mysqltest_u1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= revoke all privileges, grant option from mysqltest_u1;
let $cleanup_stmt1= grant all privileges on t1_base to mysqltest_u1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
drop user mysqltest_u1;
let $statement= select count(*) from t1_base;
let $cleanup_stmt= ;
let $statement= select count(*) from t1_base for update;
let $cleanup_stmt1= ;
let $statement= select count(*) from t1_base lock in share mode;
let $cleanup_stmt= ;
let $statement= select f2_base();
let $cleanup_stmt1= delete from t1_base limit 1;
let $statement= set @a:= (select count(*) from t1_base);
let $cleanup_stmt= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= set @a:= f2_base();
let $cleanup_stmt1= delete from t1_base limit 1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
create user mysqltest_u1;
let $statement= ALTER USER 'mysqltest_u1' IDENTIFIED BY '';
let $waitfor= ALTER USER 'mysqltest_u1'@'%' IDENTIFIED BY <secret>;
let $cleanup_stmt1= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
drop user mysqltest_u1;
let $statement= set global read_only= 1;
let $cleanup_stmt= set global read_only= 0;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
set autocommit= 0;
insert into t3_temp_trans values (1);
set autocommit= 1;
delete from t3_temp_trans;
set autocommit= 0;
insert into t3_trans values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "set autocommit= 1";
delete from t3_trans;
set autocommit= 0;
insert into t3_trans values (1);
set debug_sync='RESET';
set debug_sync='ha_commit_trans_after_acquire_commit_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "flush tables with read lock";
set debug_sync='now SIGNAL go';
delete from t3_trans;
set debug_sync= "RESET";
let $statement= show tables from test;
let $cleanup_stmt= ;
let $statement= show tables from test;
let $cleanup_stmt= ;
let $statement= show events from test;
let $cleanup_stmt= ;
create user mysqltest_u1;
let $statement= show grants for mysqltest_u1;
let $cleanup_stmt= ;
drop user mysqltest_u1;
let $statement= show create table t1_base;
let $cleanup_stmt= ;
let $statement= show create function f1;
let $cleanup_stmt= ;
let $statement= signal sqlstate '01000';
let $cleanup_stmt= ;
let $statement= truncate table t1_base;
let $cleanup_stmt1= ;
let $statement= truncate table t1_temp;
let $cleanup_stmt= ;
let $statement= update t1_base set i= 1 where i = 0;
let $cleanup_stmt1= ;
let $statement= update t1_temp set i= 1 where i = 0;
let $cleanup_stmt= ;
let $statement= update t1_base, t2_base set t1_base.i= 1 where t1_base.i = t2_base.j;
let $cleanup_stmt1= ;
let $statement= update t1_temp, t2_temp set t1_temp.i= 1 where t1_temp.i = t2_temp.j;
let $cleanup_stmt= ;
let $statement= use mysqltest1;
let $cleanup_stmt= use test;
insert into t3_trans values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa prepare 'test1'";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa rollback 'test1'";
insert into t3_trans values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa prepare 'test1'";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa commit 'test1'";
delete from t3_trans;
insert into t3_trans values (1);
insert into t3_trans values (2);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa rollback 'test1'";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa commit 'test2'";
delete from t3_trans;
insert into t3_trans values (1);
set debug_sync='RESET';
set debug_sync='detached_xa_commit_after_acquire_commit_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "flush tables with read lock";
set debug_sync='now SIGNAL go';
delete from t3_trans;
set debug_sync= "RESET";
let $statement= delete from t3_temp_trans;
let $cleanup_stmt= ;

let $statement= insert into t3_temp_trans values (1);
let $cleanup_stmt= delete from t3_temp_trans limit 1;

let $statement= update t3_temp_trans, t2_temp set t3_temp_trans.i= 1 where t3_temp_trans.i = t2_temp.j;
let $cleanup_stmt= ;
set autocommit= 0;
let $statement= delete from t3_temp_trans;
let $cleanup_stmt= ;

let $statement= insert into t3_temp_trans values (1);
let $cleanup_stmt= delete from t3_temp_trans limit 1;

let $statement= update t3_temp_trans, t2_temp set t3_temp_trans.i= 1 where t3_temp_trans.i = t2_temp.j;
let $cleanup_stmt= ;
set autocommit= 1;
let $statement= check table t3_trans;
let $cleanup_stmt= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= create temporary table t4_temp_trans(i int) engine=innodb;
let $cleanup_stmt= drop temporary tables t4_temp_trans;
let $statement= drop temporary tables t3_temp_trans;
let $cleanup_stmt= create temporary table t3_temp_trans(i int) engine=innodb;
let $statement= repair table t3_temp_trans;
let $cleanup_stmt= ;
let $statement= analyze table t3_temp_trans;
let $cleanup_stmt= ;
let $statement= alter table t3_temp_trans add column c1 int;
let $cleanup_stmt= alter table t3_temp_trans drop column c1;
insert into t3_trans values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "check table t1_base";
delete from t3_trans;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "alter table t1_temp add column c1 int";
alter table t1_temp drop column c1;
insert into t1_base values (1);
insert into t3_trans values (1);
select * from t1_base;
select * from t2_base;
select * from t3_trans;
delete from t1_base;
delete from t3_trans;
set debug_sync='RESET';
set debug_sync='execute_command_after_close_tables SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t2_base values (1)";
set debug_sync='now SIGNAL go';
set debug_sync= "RESET";
delete from t1_base;
delete from t2_base;
select * from t1_base;
select * from t3_trans;
select * from t1_base;
select * from t3_trans;
create table tm_base (i int) engine=merge union=(t1_base) insert_method=last;
let $statement= insert into tm_base values (1);
let $cleanup_stmt1= delete from tm_base;
let $statement= alter table tm_base insert_method=first;
let $cleanup_stmt1= alter table tm_base insert_method=last;
drop table tm_base;
create temporary table tm_temp_base (i int) engine=merge union=(t1_base) insert_method=last;
let $statement= insert into tm_temp_base values (1);
let $cleanup_stmt1= delete from tm_temp_base;
let $statement= drop temporary tables tm_temp_base;
let $cleanup_stmt= create temporary table tm_temp_base (i int) engine=merge union=(t1_base) insert_method=last;
let $statement= alter table tm_temp_base insert_method=first;
let $cleanup_stmt1= alter table tm_temp_base insert_method=last;
drop table tm_temp_base;
create temporary table tm_temp_temp (i int) engine=merge union=(t1_temp) insert_method=last;
let $statement= insert into tm_temp_temp values (1);
let $cleanup_stmt= delete from tm_temp_temp;
let $statement= alter table tm_temp_temp union=(t1_temp) insert_method=first;
let $cleanup_stmt= alter table tm_temp_temp union=(t1_temp) insert_method=last;
drop table tm_temp_temp;
create table tm_base_temp (i int) engine=merge union=(t1_temp) insert_method=last;
select * from tm_base_temp;
drop table tm_base_temp;
drop event e1;
drop function f2_base;
drop procedure p2;
drop view v1;
drop function f1;
drop procedure p1;
drop database `--mysql50#mysqltest-2`;
drop database mysqltest1;
drop temporary tables t1_temp, t2_temp;
drop tables t1_base, t2_base, t3_trans;
