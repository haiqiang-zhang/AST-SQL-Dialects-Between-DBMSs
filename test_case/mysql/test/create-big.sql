select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t3 to t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "alter table t3 rename to t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "alter table t3 rename to t1, add k int";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "select * from t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values (2)";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create trigger t1_bi before insert on t1 for each row set @a:=1";
select @a;
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "select * from t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values (2)";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create trigger t1_bi before insert on t1 for each row set @a:=1";
select @a;
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
create table t1 (i int);
select @a;
select * from t1;
drop table t1;
drop table if exists t1,t2;
create table t1 (i int);
insert into t1 values (1);
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t2 values (1)";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t2";
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
ALTER TABLE t1 ADD COLUMN too_much int;
DROP TABLE t1;
