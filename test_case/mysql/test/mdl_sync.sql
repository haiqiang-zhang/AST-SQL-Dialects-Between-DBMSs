lock tables t2 read;
unlock tables;
drop table if exists t1, t2, t3;
create table t1 (c1 int);
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1);
insert low_priority into t1 values (1);
lock table t1 read;
select count(*) from t1;
unlock tables;
lock table t1 write;
insert into t1 values (1);
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
unlock tables;
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1), (1);
delete low_priority from t1 limit 1;
lock table t1 read;
select count(*) from t1;
unlock tables;
lock table t1 write;
delete from t1 limit 1;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
unlock tables;
select count(*) from t1;
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1), (1);
delete low_priority from t1 limit 1;
lock table t1 read;
select count(*) from t1;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and 
        info = "lock table t1 write";
delete from t1 limit 1;
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
insert into t1 values (1);
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select * from t1;
insert into t1 values (1);
delete low_priority from t1 limit 1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 read";
unlock tables;
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
delete from t1 limit 2;
unlock tables;
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
insert low_priority into t1 values (1), (1);
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select * from t1;
delete from t1 limit 1;
delete low_priority from t1 limit 1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 read";
unlock tables;
insert low_priority into t1 values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
delete low_priority from t1 limit 2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
unlock tables;
insert low_priority into t1 values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
insert into t1 values (1);
delete low_priority from t1 limit 2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
lock tables t1 read;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
insert into t1 values (1);
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
lock table t1 read;
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete from t1 limit 2";
unlock tables;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert low_priority into t1 values (1)";
unlock tables;
lock table t1 read;
lock table t1 read;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
unlock tables;
insert into t1 values (1);
unlock tables;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
unlock tables;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c2 int";
unlock tables;
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete from t1 limit 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete low_priority from t1 limit 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
lock tables t1 read;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
insert into t1 values (1);
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
lock table t1 write;
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select count(*) from t1";
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "delete from t1 limit 2";
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert low_priority into t1 values (1)";
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add primary key (c1)";
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 read";
unlock tables;
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t1 write";
unlock tables;
insert into t1 values (1);
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
unlock tables;
create table t2 (c1 int);
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "handler t1 open";
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info like "select table_name, table_type, auto_increment%";
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and 
      info = "select count(*) from t1";
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 2";
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert low_priority into t1 values (1)";
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
unlock tables;
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
unlock tables;
unlock tables;
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t3";
unlock tables;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t1 values (1)";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
unlock tables;
unlock tables;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 2";
unlock tables;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert low_priority into t1 values (1)";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
lock table t1 read;
unlock tables;
unlock tables;
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
delete from t1 limit 1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete low_priority from t1 limit 1";
unlock tables;
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
unlock tables;
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 1";
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete low_priority from t1 limit 1";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t1";
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t1 values (1),(1)";
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete low_priority from t1 limit 1";
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
unlock tables;
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select column_name from information_schema.columns where
  table_schema='test' and table_name='t1';
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "handler t1 open";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t1";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t1 limit 2";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert low_priority into t1 values (1)";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add index (not_exist)";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 read";
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
unlock tables;
select count(*) from t1;
insert into t2 values (1), (1);
select count(*) from t2;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t2 values (1)";
select count(*) from t1;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t1 values (1)";
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add primary key (c1)";
select count(*) from t1;
delete from t1 limit 1;
select count(*) from t1;
select count(*) from t2;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t2 add column c2 int";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t2";
select count(*) from t1;
select count(*) from t2;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t2 drop column c2";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "insert into t2 values (1)";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "alter table t1 add column c2 int";
select count(*) from t1;
delete from t1 limit 1;
select count(*) from t1;
lock table t2 write;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t2";
unlock tables;
select count(*) from t1;
lock table t2 write;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t2 limit 1";
unlock tables;
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) from t1;
delete from t1 limit 1;
unlock tables;
delete from t1 limit 1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "lock table t1 write";
select count(*) from t1;
unlock tables;
select count(*) from t1;
select count(*) from t2;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t2 to t3";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "select count(*) from t2";
select count(*) from t1;
select count(*) from t2;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t2 to t3";
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "delete from t2 limit 1";
select count(*) from t1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) from t1;
delete from t1 limit 1;
delete from t1 limit 1;
select count(*) = 1 from information_schema.processlist
where state = "Waiting for table metadata lock" and
      info = "rename table t1 to t2";
select count(*) from t1;
drop table t1, t2;
drop table if exists t1, t2;
create table t1 (i int);
create table t2 (j int);
insert into t1 values (1);
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
unlock tables;
lock table t1 write, t2 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t2 values (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 drop column j";
unlock tables;
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t1 values (1)";
unlock tables;
lock table t1 write, t2 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t2 values (1)";
unlock tables;
lock table t1 write, t2 read local;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t2 set j=3";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
unlock tables;
lock table t1 write, t2 read local;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t2 set j=3";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "handler t2 read first";
unlock tables;
drop tables t1, t2;
drop tables if exists t0, t1, t2, t3, t4, t5;
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
create table t4 (k int);
insert into t1 values (1);
insert into t2 values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t2 to t0, t3 to t2, t0 to t3";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select * from t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t0, t3 to t1, t0 to t3";
insert into t2 values (2);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t2 to t0, t1 to t2, t0 to t1";
select * from t1;
insert into t2 values (1);
lock table t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and info = "select * from t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t0, t2 to t1, t0 to t2";
unlock tables;
drop tables t1, t2, t3, t4;
create table t1 (i int);
insert into t1 values (1);
select * from t1;
select * from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int, rename to t2";
create table t2 (j int);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock tables t1 write, t2 write";
unlock tables;
drop tables t1, t2;
create table t1 (i int);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 drop column j";
drop table t1;
create table t1(i int);
create table t2(j int);
select * from t1, t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables t1, t2 with read lock";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select * from t1 where i in (select j from t2 for update)";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables t2 with read lock";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "drop tables t1, t2";
unlock tables;
create table t3(j int);
select * from t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t0, t2 to t1, t3 to t2, t0 to t3";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock table t3 write";
select * from t3;
unlock table;
drop tables t1, t2, t3;
drop tables if exists t1, t2;
create table t1(i int);
create table t2(j int);
select * from t1, t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables";
unlock tables;
drop tables t1, t2;
drop tables if exists t1, t2, t3, t4, t5;
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
create table t4 (l int);
lock tables t4 read;
unlock tables;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE t2;
DROP TABLE IF EXISTS t1;
drop tables if exists t1, t2;
create table t1 (i int);
insert into t1 values(1);
lock tables t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "lock tables t1 write";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create table t2 select * from t1";
select column_name from information_schema.columns
  where table_schema='test' and table_name='t2';
select table_name, table_type, auto_increment, table_comment
  from information_schema.tables where table_schema='test' and table_name='t2';
unlock tables;
unlock tables;
lock tables t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create table t2 select * from t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "show fields from t2";
unlock tables;
lock tables t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create table t2 select * from t1";
select column_name from information_schema.columns where table_schema='test' and table_name='t2';
unlock tables;
lock tables t3 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info like "rename table t1 to t2%";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info like "select table_name, table_type, auto_increment, table_comment from information_schema.tables%";
unlock tables;
drop table t3;
drop table t1;
drop table if exists t1;
create table t1 (c1 int primary key, c2 int, c3 int);
insert into t1 values (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0);
select * from t1 where c2 = 3;
update t1 set c3=c3+1 where c2 = 3;
drop tables if exists t1;
create table t1 (i int);
insert into t1 values (1);
unlock tables;
delete from t1 where i = 1;
drop table t1;
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 (i INT);
CREATE TABLE t2 (i INT);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table level lock" and info = "SELECT 1";
ALTER TABLE t1 ADD COLUMN j INT;
DROP TABLE t1, t2;
drop table if exists t1;
create table t1 (i int) engine=InnoDB;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "truncate table t1";
drop table t1;
drop table if exists t1;
create table t1 (i int);
select * from t1;
select * from t1;
select count(*) = 2 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t1 values (1)";
drop table t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1),(2),(3);
LOCK TABLES t1 WRITE;
UNLOCK TABLES;
DROP TABLE t1;
DROP DATABASE IF EXISTS db1;
DROP DATABASE IF EXISTS db2;
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
CREATE DATABASE db1;
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
CREATE TABLE db1.t1 (a INT);
CREATE TABLE test.t2 (a INT);
DROP TABLE test.t2;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
DROP DATABASE db1;
DROP TABLE IF EXISTS t1, t2, m1;
CREATE TABLE t1(a INT) engine=MyISAM;
CREATE TABLE t2(a INT) engine=MyISAM;
CREATE TABLE m1(a INT) engine=MERGE UNION=(t1, t2);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (3), (4);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "DELETE FROM t2 WHERE a = 3";
SELECT * FROM m1;
DROP TABLE m1, t1, t2;
CREATE TABLE t1(c1 INT NOT NULL) ENGINE = csv;
CREATE TABLE t2(c1 INT NOT NULL);
LOCK TABLES t1 WRITE;
INSERT INTO t1 VALUES(0);
UNLOCK TABLES;
SELECT * FROM t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DROP TABLES t1, t2";
INSERT INTO t1 VALUES (0), (1);
DROP TABLE t1;
CREATE TABLE t1 (f1 INT, f2 INT);
CREATE VIEW v1 AS SELECT f2 FROM t1, t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "REPAIR TABLE t2";
DROP VIEW v1;
DROP TABLE t1;
DROP TABLE t2;
