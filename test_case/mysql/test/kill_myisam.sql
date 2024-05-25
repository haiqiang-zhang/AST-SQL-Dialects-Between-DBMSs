CREATE TABLE t1 (f1 INT);
SELECT * FROM t1;
INSERT INTO t1 VALUES(0);
SELECT * FROM t1;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
SELECT * FROM t1;
CREATE TABLE t2 (f2 INT) engine myisam;
INSERT INTO t2 VALUES(0);
INSERT INTO t2 VALUES(1);
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;
create table t1 (i int primary key) engine myisam;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "drop table t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create trigger t1_bi before insert on t1 for each row set @a:=1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 rename to t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 disable keys";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 alter column i set default 100";
unlock tables;
create table t2 (i int primary key) engine=merge union=(t1);
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t2 alter column i set default 100";
unlock tables;
lock tables t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "truncate table t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t1 values (1)";
unlock tables;
lock tables t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "select * from t1";
unlock tables;
drop table t1;
drop table t2;
