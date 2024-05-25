SELECT * FROM t1;
prepare st_1180 from 'SELECT * FROM t1 WHERE ?="1111" and session_id = "abc"';
drop table t1;
create table t1 (
  c_01 char(6), c_02 integer, c_03 real, c_04 int(3), c_05 varchar(20),
  c_06 date,    c_07 char(1), c_08 real, c_09 int(11), c_10 time,
  c_11 char(6), c_12 integer, c_13 real, c_14 int(3), c_15 varchar(20),
  c_16 date,    c_17 char(1), c_18 real, c_19 int(11), c_20 text);
prepare st_1644 from 'insert into t1 values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
select * from t1;
drop table t1;
create table t1(
   cola varchar(50) not null,
   colb varchar(8) not null,
   colc varchar(12) not null,
   cold varchar(2) not null,
   primary key (cola, colb, cold));
create table t2(
   cola varchar(50) not null,
   colb varchar(8) not null,
   colc varchar(2) not null,
   cold float,
   primary key (cold));
insert into t1 values ('aaaa', 'yyyy', 'yyyy-dd-mm', 'R');
insert into t2 values ('aaaa', 'yyyy', 'R', 203), ('bbbb', 'zzzz', 'C', 201);
prepare st_1676 from 'select a.cola, a.colb, a.cold from t1 a, t2 b where a.cola = ? and a.colb = ? and a.cold = ? and b.cola = a.cola and b.colb = a.colb and b.colc = a.cold';
drop table t1, t2;
create table t1 (a int primary key);
insert into t1 values (1);
select * from t1 where 3 in (select (1+1) union select 1);
prepare st_18492 from 'select * from t1 where 3 in (select (1+1) union select 1)';
drop table t1;
create table t1 (a int, b varchar(4));
create table t2 (a int, b varchar(4), primary key(a));
prepare stmt1 from 'insert into t1 (a, b) values (?, ?)';
prepare stmt2 from 'insert into t2 (a, b) values (?, ?)';
select * from t1;
select * from t2;
drop table t1;
drop table t2;
CREATE TABLE t1 (a INT);
PREPARE stmt FROM 'select 1 from `t1` where `a` = any (select (@@tmpdir))';
DEALLOCATE PREPARE stmt;
DROP TABLE t1;
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t2 VALUES (400000), (400001);
DROP TABLE t2;
SELECT CONCAT(@@sort_buffer_size);
SELECT LEFT("12345", @@ft_boolean_syntax);
create table t6(a decimal(3,2));
prepare s from 'select a<cast(? as signed) from t6';
insert into t6 values(6.2);
drop table t6;
