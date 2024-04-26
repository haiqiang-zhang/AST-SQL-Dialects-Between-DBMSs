
-- We need InnoDB tables for some of the tests.

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc


-- Clean up resources used in this test case.
--disable_warnings
SET DEBUG_SYNC= 'RESET';

--
-- Test the case of when a exclusive lock request waits for a
-- shared lock being upgraded to a exclusive lock.
--

connect (con1,localhost,root,,test,,);
drop table if exists t1,t2,t3;

create table t1 (i int);
create table t2 (i int);
set debug_sync='mdl_upgrade_lock SIGNAL parked WAIT_FOR go';
set debug_sync= 'now WAIT_FOR parked';
set debug_sync='mdl_acquire_lock_wait SIGNAL go';
drop table t3;

-- Clean up resources used in this test case.
--disable_warnings
SET DEBUG_SYNC= 'RESET';
drop table if exists t1, t2, t3;
set debug_sync= 'RESET';
create table t1 (c1 int);
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1);
insert low_priority into t1 values (1);
alter table t1 add index (not_exist);
select count(*) from t1;
alter table t1 add primary key (c1);
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
alter table t1 drop column c2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
alter table t1 drop column c2;
set debug_sync= 'after_open_table_mdl_shared_to_fetch_stats SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1), (1);
delete low_priority from t1 limit 1;
alter table t1 add index (not_exist);
select count(*) from t1;
alter table t1 add primary key (c1);
delete from t1 limit 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
set debug_sync= 'now SIGNAL finish';
set debug_sync= 'after_open_table_mdl_shared_to_fetch_stats SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
set debug_sync= 'now SIGNAL finish';
alter table t1 drop column c2;
set debug_sync= 'after_open_table_mdl_shared_to_fetch_stats SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
set debug_sync= 'now SIGNAL finish';
alter table t1 drop column c2;
select count(*) from t1;
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1), (1);
delete low_priority from t1 limit 1;
alter table t1 add index (not_exist);
select count(*) from t1;
alter table t1 add primary key (c1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and 
        info = "lock table t1 write";
delete from t1 limit 1;
select count(*) from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
select count(*) from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
alter table t1 drop column c2;
insert into t1 values (1);
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select * from t1;
insert into t1 values (1);
delete low_priority from t1 limit 1;
alter table t1 add index (not_exist);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 read";
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
delete from t1 limit 2;
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
insert low_priority into t1 values (1), (1);
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select * from t1;
delete from t1 limit 1;
delete low_priority from t1 limit 1;
alter table t1 add index (not_exist);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 read";
insert low_priority into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
delete low_priority from t1 limit 2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
insert low_priority into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
set debug_sync= 'alter_opened_table SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1);
delete low_priority from t1 limit 2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
set debug_sync= 'now SIGNAL finish';
set debug_sync= 'alter_opened_table SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
set debug_sync= 'now SIGNAL finish';
insert into t1 values (1);
set debug_sync= 'alter_opened_table SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
set debug_sync= 'now SIGNAL finish';
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete from t1 limit 2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert low_priority into t1 values (1)";
alter table t1 add index (not_exist);
alter table t1 add primary key (c1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
alter table t1 drop column c2;
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete from t1 limit 1";
set debug_sync= 'now SIGNAL finish';
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete low_priority from t1 limit 1";
set debug_sync= 'now SIGNAL finish';
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
set debug_sync= 'now SIGNAL finish';
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
set debug_sync= 'now SIGNAL finish';
insert into t1 values (1);
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
set debug_sync= 'now SIGNAL finish';
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select count(*) from t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete from t1 limit 2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert low_priority into t1 values (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 read";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
create table t2 (c1 int);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "handler t1 open";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info like "select table_name, table_type, auto_increment%";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and 
      info = "select count(*) from t1";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert low_priority into t1 values (1)";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t3";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t1 values (1)";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
alter table t1 add index (not_exist);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 2";
alter table t1 add primary key (c1);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert low_priority into t1 values (1)";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
alter table t1 add index (not_exist);
alter table t1 add primary key (c1);
insert into t1 values (1);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
delete from t1 limit 1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete low_priority from t1 limit 1";
insert into t1 values (1);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
alter table t1 add index (not_exist);
insert into t1 values (1);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 1";
insert into t1 values (1);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete low_priority from t1 limit 1";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t1";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t1 values (1),(1)";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete low_priority from t1 limit 1";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
alter table t1 add index (not_exist);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
alter table t1 add primary key (c1);
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "handler t1 open";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t1";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 2";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert low_priority into t1 values (1)";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add index (not_exist)";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) from t1;
insert into t2 values (1), (1);
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
select count(*) from t2;
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t2 values (1)";
set debug_sync= 'now SIGNAL finish';
select count(*) from t1;
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t1 values (1)";
set debug_sync= 'now SIGNAL finish';
insert into t1 values (1);
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
select count(*) from t1;
delete from t1 limit 1;
select count(*) from t1;
select count(*) from t2;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t2 add column c2 int";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t2";
select count(*) from t1;
select count(*) from t2;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t2 drop column c2";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t2 values (1)";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add column c2 int";
select count(*) from t1;
delete from t1 limit 1;
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t2";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t2 limit 1";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) from t1;
delete from t1 limit 1;
delete from t1 limit 1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) from t1;
insert into t1 values (1, 1);
select count(*) from t1;
select count(*) from t2;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t2 to t3";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t2";
select count(*) from t1;
select count(*) from t2;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t2 to t3";
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t2 limit 1";
select count(*) from t1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) from t1;
delete from t1 limit 1;
delete from t1 limit 1;
let $wait_condition=
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) from t1;
insert into t1 values (1, 1);
set debug_sync= 'RESET';
drop table t1, t2;
drop table if exists t1, t2;
create table t1 (i int);
create table t2 (j int);
insert into t1 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t2 values (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 drop column j";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t1 values (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t2 values (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t2 set j=3";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t2 set j=3";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "handler t2 read first";
alter table t1 drop column j;
drop tables t1, t2;
drop tables if exists t0, t1, t2, t3, t4, t5;
set debug_sync= 'RESET';
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
create table t4 (k int);
insert into t1 values (1);
insert into t2 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t2 to t0, t3 to t2, t0 to t3";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select * from t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t0, t3 to t1, t0 to t3";
insert into t2 values (2);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t2 to t0, t1 to t2, t0 to t1";
select * from t1;
insert into t2 values (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and info = "select * from t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t0, t2 to t1, t0 to t2";

drop tables t1, t2, t3, t4;
create table t1 (i int);
insert into t1 values (1);
select * from t1;
select * from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int, rename to t2";
select * from t2;

drop table t2;
create table t1 (i int);
create table t2 (j int);
set debug_sync= 'after_open_table_mdl_shared SIGNAL locked WAIT_FOR finish';
set debug_sync= 'now WAIT_FOR locked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock tables t1 write, t2 write";
set debug_sync= 'now SIGNAL finish';

drop tables t1, t2;
create table t1 (i int);
set debug_sync='alter_table_copy_after_lock_upgrade SIGNAL parked1 WAIT_FOR go1';
set debug_sync='now WAIT_FOR parked1';
set debug_sync='mdl_acquire_lock_wait SIGNAL parked2 WAIT_FOR go2';
set debug_sync='now WAIT_FOR parked2';
set debug_sync='now SIGNAL go1';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 drop column j";
set debug_sync='now SIGNAL go2';

drop table t1;
create table t1(i int);
create table t2(j int);
select * from t1, t2;
set debug_sync= 'RESET';
set debug_sync='open_tables_after_open_and_process_table SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables t1, t2 with read lock";
set debug_sync='now SIGNAL go';
set debug_sync= 'RESET';
set debug_sync='flush_tables_with_read_lock_after_acquire_locks SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select * from t1 where i in (select j from t2 for update)";
set debug_sync='now SIGNAL go';
set debug_sync= 'RESET';
set debug_sync='open_tables_after_open_and_process_table SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables t2 with read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "drop tables t1, t2";
set debug_sync='now SIGNAL go';
set debug_sync= 'RESET';
create table t1(i int);
create table t2(j int);
create table t3(j int);
create trigger t3_bi before insert on t3 for each row insert into t1 values (1);
select * from t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t0, t2 to t1, t3 to t2, t0 to t3";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t3 write";
select * from t3;
drop trigger t3_bi;
drop tables t1, t2, t3;
drop tables if exists t1, t2;
set debug_sync= 'RESET';
create table t1(i int);
create table t2(j int);
select * from t1, t2;
set debug_sync='open_tables_after_open_and_process_table SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables";
set debug_sync='now SIGNAL go';
drop tables t1, t2;
set debug_sync= 'RESET';
drop tables if exists t1, t2, t3, t4, t5;
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
create table t4 (l int);
create trigger t1_bi before insert on t1 for each row
  insert into t2 values (new.i);
create trigger t2_bi before insert on t2 for each row
  insert into t3 values (new.j);
let $wait_condition= select count(*)= 1 from information_schema.processlist
                       where state= 'Waiting for table metadata lock' and
                             info='rename table t3 to t5, t4 to t3';
let $wait_condition= select count(*)= 1 from information_schema.processlist
                       where state= 'Waiting for table metadata lock' and
                             info='insert into t1 values (1)';
drop tables t1, t2, t3, t5;
DROP TABLE IF EXISTS t1;
set @save_log_output=@@global.log_output;
set global log_output=file;
SET DEBUG_SYNC= 'after_open_table_mdl_shared SIGNAL locked WAIT_FOR finish';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL finish';
SET DEBUG_SYNC= 'RESET';
DROP TABLE IF EXISTS t1;

CREATE TABLE t2 (c1 INT, c2 VARCHAR(100), KEY(c1));
SET DEBUG_SYNC= 'after_open_table_mdl_shared SIGNAL locked WAIT_FOR finish';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL finish';
SET DEBUG_SYNC= 'RESET';

DROP TABLE t2;
DROP TABLE IF EXISTS t1;

set global log_output=@save_log_output;
drop tables if exists t1, t2;
create table t1 (i int);
insert into t1 values(1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock tables t1 write";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create table t2 select * from t1";
select column_name from information_schema.columns
  where table_schema='test' and table_name='t2';
select table_name, table_type, auto_increment, table_comment
  from information_schema.tables where table_schema='test' and table_name='t2';
drop table t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create table t2 select * from t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "show fields from t2";
drop table t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create table t2 select * from t1";
select column_name from information_schema.columns where table_schema='test' and table_name='t2';
drop table t2;
create table t3 like t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info like "rename table t1 to t2%";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info like "select table_name, table_type, auto_increment, table_comment from information_schema.tables%";
drop table t3;
drop table t1;
drop table if exists t1;
set debug_sync= 'RESET';
create table t1 (c1 int primary key, c2 int, c3 int);
insert into t1 values (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0);
select * from t1 where c2 = 3;
set debug_sync='alter_table_copy_after_lock_upgrade SIGNAL alter_table_locked WAIT_FOR alter_go';
set debug_sync='now WAIT_FOR alter_table_locked';
set debug_sync='mdl_acquire_lock_wait SIGNAL alter_go';
update t1 set c3=c3+1 where c2 = 3;
set debug_sync= 'RESET';
drop table t2;
drop tables if exists t1;
create table t1 (i int);
insert into t1 values (1);
delete from t1 where i = 1;
drop table t1;
SET DEBUG_SYNC= 'after_acquiring_mdl_lock_on_routine SIGNAL routine_locked WAIT_FOR grlwait';
SET DEBUG_SYNC= 'now WAIT_FOR routine_locked';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL grlwait';
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'after_acquiring_mdl_lock_on_routine SIGNAL routine_locked WAIT_FOR grlwait';
SET DEBUG_SYNC= 'now WAIT_FOR routine_locked';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL grlwait';
SET DEBUG_SYNC= 'RESET';
DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (i INT);
CREATE TABLE t2 (i INT);

SET @old_general_log= @@global.general_log;
SET @@global.general_log= 1;

SET @old_log_output= @@global.log_output;
SET @@global.log_output= 'TABLE';

SET @old_sql_log_off= @@session.sql_log_off;
SET @@session.sql_log_off= 1;
SET @@session.sql_log_off= 1;
SET DEBUG_SYNC= 'thr_multi_lock_after_thr_lock SIGNAL parked WAIT_FOR go';

-- The below statement will block on the debug sync point
-- after it gets write lock on mysql.general_log table.
--echo -- Sending:
--send SELECT 1

--echo -- connection: con3
connection con3;
SET DEBUG_SYNC= 'now WAIT_FOR parked';
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table level lock" and info = "SELECT 1";
ALTER TABLE t1 ADD COLUMN j INT;
SET DEBUG_SYNC= 'now SIGNAL go';
DROP TABLE t1, t2;
SET DEBUG_SYNC= 'RESET';
SET @@global.general_log= @old_general_log;
SET @@global.log_output= @old_log_output;
SET @@session.sql_log_off= @old_sql_log_off;
drop table if exists t1;
set debug_sync= 'RESET';
create table t1 (i int) engine=InnoDB;
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL parked WAIT_FOR go';
set debug_sync= 'now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "truncate table t1";
set debug_sync= 'now SIGNAL go';
set debug_sync= 'RESET';
drop table t1;
drop table if exists t1;
set debug_sync= 'RESET';
create table t1 (i int);
select * from t1;
select * from t1;
set debug_sync= 'alter_table_copy_after_lock_upgrade SIGNAL parked WAIT_FOR go';
set debug_sync= 'now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 2 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t1 values (1)";
set debug_sync= 'now SIGNAL go';
set debug_sync= 'RESET';
drop table t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1),(2),(3);
SET debug_sync='upgrade_lock_for_truncate SIGNAL parked_truncate WAIT_FOR go_truncate';
SET debug_sync='now WAIT_FOR parked_truncate';
SET debug_sync='after_acquiring_mdl_shared_to_fetch_stats SIGNAL parked_show WAIT_FOR go_show';
SET debug_sync='now WAIT_FOR parked_show';
SET debug_sync='after_flush_unlock SIGNAL parked_flush WAIT_FOR go_flush';
SET debug_sync='now WAIT_FOR parked_flush';
SET debug_sync='now SIGNAL go_truncate';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for table metadata lock' AND info='TRUNCATE TABLE t1';
SET debug_sync= 'now SIGNAL go_show';
SET debug_sync= 'now SIGNAL go_flush';
SET debug_sync= 'RESET';
DROP TABLE t1;
DROP DATABASE IF EXISTS db1;
DROP DATABASE IF EXISTS db2;
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND info='CREATE DATABASE db1';
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
SET DEBUG_SYNC= 'now SIGNAL blocked';
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock'
  AND info='ALTER DATABASE db1 DEFAULT CHARACTER SET utf8mb3';
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
SET DEBUG_SYNC= 'now SIGNAL blocked';
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND info='DROP DATABASE db1';
SET DEBUG_SYNC= 'now SIGNAL blocked';
CREATE DATABASE db1;
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND info='DROP DATABASE db1';
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
SET DEBUG_SYNC= 'now SIGNAL blocked';
CREATE DATABASE db1;
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock'
  AND info='ALTER DATABASE db1 DEFAULT CHARACTER SET utf8mb3';
SET DEBUG_SYNC= 'now SIGNAL blocked';
CREATE DATABASE db1;
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND
        info='CREATE TABLE db1.t1 (a INT)';
SET DEBUG_SYNC= 'now SIGNAL blocked';
CREATE DATABASE db1;
CREATE TABLE db1.t1 (a INT);
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND
        info='RENAME TABLE db1.t1 TO test.t1';
SET DEBUG_SYNC= 'now SIGNAL blocked';
CREATE DATABASE db1;
CREATE TABLE test.t2 (a INT);
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND
        info='RENAME TABLE test.t2 TO db1.t2';
SET DEBUG_SYNC= 'now SIGNAL blocked';
DROP TABLE test.t2;
CREATE DATABASE db1;
CREATE TABLE db1.t1 (a INT);
SET DEBUG_SYNC= 'after_wait_locked_schema_name SIGNAL locked WAIT_FOR blocked';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for schema metadata lock' AND info='DROP TABLE db1.t1';
SET DEBUG_SYNC= 'now SIGNAL blocked';
SET DEBUG_SYNC= 'RESET';

CREATE DATABASE db1;
CREATE TABLE db1.t1(a INT);
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for global read lock'
  AND info='CREATE TABLE db1.t2(a INT)';
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for global read lock'
  AND info='ALTER DATABASE db1 DEFAULT CHARACTER SET utf8mb3';
DROP DATABASE db1;
DROP TABLE IF EXISTS t1, t2, m1;

CREATE TABLE t1(a INT) engine=MyISAM;
CREATE TABLE t2(a INT) engine=MyISAM;
CREATE TABLE m1(a INT) engine=MERGE UNION=(t1, t2);

INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (3), (4);
SET DEBUG_SYNC= 'mdl_upgrade_lock SIGNAL upgrade WAIT_FOR continue EXECUTE 2';
SET DEBUG_SYNC= 'now WAIT_FOR upgrade';
SET DEBUG_SYNC= 'now SIGNAL continue';
SET DEBUG_SYNC= 'now WAIT_FOR upgrade';
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "DELETE FROM t2 WHERE a = 3";
SELECT * FROM m1;
SET DEBUG_SYNC= 'now SIGNAL continue';
DROP TABLE m1, t1, t2;
SET DEBUG_SYNC= 'RESET';
CREATE TABLE t1(c1 INT NOT NULL) ENGINE = csv;
CREATE TABLE t2(c1 INT NOT NULL);
INSERT INTO t1 VALUES(0);
SELECT * FROM t2;
SET DEBUG_SYNC='recover_ot_repair SIGNAL parked WAIT_FOR go';
SET DEBUG_SYNC='now WAIT_FOR parked';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DROP TABLES t1, t2";
SET DEBUG_SYNC='now SIGNAL go';
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(i INT);
INSERT INTO t1 VALUES (0), (1);
SELECT i FROM t1 WHERE i = 0 AND GET_LOCK(i, 0);
SELECT i FROM t1 WHERE i = 1 AND GET_LOCK(i, 0);
SET DEBUG_SYNC='mdl_acquire_lock_wait SIGNAL wait0 WAIT_FOR go0';
SET DEBUG_SYNC='mdl_acquire_lock_wait SIGNAL wait1 WAIT_FOR go1';
SET DEBUG_SYNC='now WAIT_FOR wait0';
SET DEBUG_SYNC='now WAIT_FOR wait1';
SET DEBUG_SYNC='now SIGNAL go0';
SET DEBUG_SYNC='now SIGNAL go1';

DROP TABLE t1;

SET DEBUG_SYNC= 'RESET';
CREATE TABLE t1 (f1 INT, f2 INT);
CREATE TABLE t2 (g1 INT, g2 INT);
CREATE VIEW v1 AS SELECT f2 FROM t1, t2;
SET DEBUG_SYNC= 'after_updating_view_metadata SIGNAL
                 after_view_update WAIT_FOR continue_alter';
SET DEBUG_SYNC= 'now WAIT_FOR after_view_update';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "REPAIR TABLE t2";

SET DEBUG_SYNC= 'now SIGNAL continue_alter';

DROP VIEW v1;
DROP TABLE t1;
DROP TABLE t2;
