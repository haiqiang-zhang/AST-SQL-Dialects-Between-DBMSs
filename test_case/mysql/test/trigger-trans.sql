select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' and event_object_table = 't1';
insert into t1 values ('The Lion', 10);
select * from t1;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' and event_object_table = 't1';
insert into t1 values ('The Unicorn', 20);
select * from t1;
alter table t1 add column c int default 0;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' and event_object_table = 't1';
insert into t1 values ('Alice', 30, 1);
select * from t1;
alter table t1 rename to t1;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' and event_object_table = 't1';
insert into t1 values ('The Crown', 40, 1);
select * from t1;
alter table t1 rename to t1, add column d int default 0;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' and event_object_table = 't1';
insert into t1 values ('The Pie', 50, 1, 1);
select * from t1;
alter table t1 add primary key(b), algorithm=copy;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' and event_object_table = 't1';
insert into t1 values ('The Mirror', 60, 1, 1);
select * from t1;
drop table t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(a INT PRIMARY KEY) ENGINE=innodb;
CREATE TABLE t2(b INT, FOREIGN KEY(b) REFERENCES t1(a)) ENGINE=innodb;
INSERT INTO t1 VALUES (1);
SELECT @a, @b;
DELETE FROM t1;
SELECT @a, @b;
INSERT INTO t1 VALUES (1);
DELETE FROM t1;
SELECT @a, @b;
DROP TABLE t2, t1;
create table t1 (a int, val char(1)) engine=InnoDB;
create table t2 (b int auto_increment primary key,
 val char(1)) engine=InnoDB;
insert into t1 values ( 123, 'a'), ( 123, 'b'), ( 123, 'c'),
 (123, 'd'), (123, 'e'), (123, 'f'), (123, 'g');
insert into t1 values ( 654, 'a'), ( 654, 'b'), ( 654, 'c'),
 (654, 'd'), (654, 'e'), (654, 'f'), (654, 'g');
select * from t2 order by b;
drop table t1,t2;
CREATE TABLE t1 (id int unsigned PRIMARY KEY, val int DEFAULT 0)
ENGINE=InnoDB;
INSERT INTO t1 (id) VALUES (1), (2);
CREATE TABLE t2 (id int PRIMARY KEY);
CREATE TABLE t3 LIKE t2;
UPDATE t1 SET val = val + 1;
UPDATE t1 SET val = val + 1;
INSERT INTO t2 (id) VALUES (1);
DROP TABLE t3, t2, t1;
