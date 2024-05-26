drop table if exists t1;
create table t1 (a int not null,b int not null, primary key using BTREE (a)) engine=heap comment="testing heaps" avg_row_length=100 min_rows=1 max_rows=100;
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a=1 or a=0;
select * from t1;
select * from t1 where a=4;
update t1 set b=5 where a=4;
update t1 set b=b+1 where a>=3;
select * from t1;
alter table t1 add c int not null, add key using BTREE (c,a);
drop table t1;
create table t1 (a int not null,b int not null, primary key using BTREE (a)) engine=heap comment="testing heaps";
insert into t1 values(-2,-2),(-1,-1),(0,0),(1,1),(2,2),(3,3),(4,4);
delete from t1 where a > -3;
select * from t1;
drop table t1;
create table t1 (x int not null, y int not null, key x  using BTREE (x,y), unique y  using BTREE (y))
engine=heap;
insert into t1 values (1,1),(2,2),(1,3),(2,4),(2,5),(2,6);
select * from t1 where x=1;
select * from t1,t1 as t2 where t1.x=t2.y;
drop table t1;
create table t1 (a int) engine=heap;
insert into t1 values(1);
select max(a) from t1;
drop table t1;
CREATE TABLE t1 ( a int not null default 0, b int not null default 0,  key  using BTREE (a,b),  key  using BTREE (b)  ) ENGINE=HEAP;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
select * from t1 where b=1;
drop table t1;
create table t1 (id int unsigned not null, primary key  using BTREE (id)) engine=HEAP;
insert into t1 values(1);
insert into t1 values(2);
drop table t1;
create table t1 (n int) engine=heap;
drop table t1;
create table t1 (n int) engine=heap;
drop table if exists t1;
CREATE table t1(f1 int not null,f2 char(20) not 
null,index(f2)) engine=heap;
INSERT into t1 set f1=12,f2="bill";
INSERT into t1 set f1=13,f2="bill";
INSERT into t1 set f1=14,f2="bill";
INSERT into t1 set f1=15,f2="bill";
INSERT into t1 set f1=16,f2="ted";
INSERT into t1 set f1=12,f2="ted";
INSERT into t1 set f1=12,f2="ted";
INSERT into t1 set f1=12,f2="ted";
INSERT into t1 set f1=12,f2="ted";
delete from t1 where f2="bill";
select * from t1;
drop table t1;
create table t1 (btn char(10) not null, key using BTREE (btn)) charset utf8mb4 engine=heap;
insert into t1 values ("hello"),("hello"),("hello"),("hello"),("hello"),("a"),("b"),("c"),("d"),("e"),("f"),("g"),("h"),("i");
select * from t1 where btn like "ff%";
select * from t1 where btn like " %";
select * from t1 where btn like "q%";
alter table t1 add column new_col char(1) not null, add key using BTREE (btn,new_col), drop key btn;
update t1 set new_col=left(btn,1);
drop table t1;
CREATE TABLE t1 (
  a int default NULL,
  b int default NULL,
  KEY a using BTREE (a),
  UNIQUE b using BTREE (b)
) engine=heap;
INSERT INTO t1 VALUES (NULL,99),(99,NULL),(1,1),(2,2),(1,3);
SELECT * FROM t1 WHERE a=NULL;
SELECT * FROM t1 WHERE a<=>NULL;
SELECT * FROM t1 WHERE b=NULL;
SELECT * FROM t1 WHERE b<=>NULL;
DROP TABLE t1;
CREATE TABLE t1 (a int, b int, c int, key using BTREE (a, b, c)) engine=heap;
INSERT INTO t1 VALUES (1, NULL, NULL), (1, 1, NULL), (1, NULL, 1);
SELECT * FROM t1 WHERE a=1 and b IS NULL;
SELECT * FROM t1 WHERE a=1 and c IS NULL;
SELECT * FROM t1 WHERE a=1 and b IS NULL and c IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (a int not null, primary key using BTREE (a)) engine=heap;
INSERT into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11);
DELETE from t1 where a < 100;
SELECT * from t1;
DROP TABLE t1;
create table t1(a int not null, key using btree(a)) engine=heap;
insert into t1 values (2), (2), (2), (1), (1), (3), (3), (3), (3);
select a from t1 where a > 2 order by a;
delete from t1 where a < 4;
select a from t1 order by a;
insert into t1 values (2), (2), (2), (1), (1), (3), (3), (3), (3);
select a from t1 where a > 4 order by a;
delete from t1 where a > 4;
select a from t1 order by a;
select a from t1 where a > 3 order by a;
delete from t1 where a >= 2;
select a from t1 order by a;
drop table t1;
CREATE TABLE t1 (
  c1 CHAR(3),
  c2 INTEGER,
  KEY USING BTREE(c1),
  KEY USING BTREE(c2)
) ENGINE= MEMORY;
INSERT INTO t1 VALUES ('ABC',0), ('A',0), ('B',0), ('C',0);
UPDATE t1 SET c2= c2 + 1 WHERE c1 = 'A';
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  c1 ENUM('1', '2'),
  UNIQUE USING BTREE(c1)
) ENGINE= MEMORY DEFAULT CHARSET= utf8mb3;
INSERT INTO t1 VALUES('1'), ('2');
DROP TABLE t1;
CREATE TABLE t1 (
  c1 SET('1', '2'),
  UNIQUE USING BTREE(c1)
) ENGINE= MEMORY DEFAULT CHARSET= utf8mb3;
INSERT INTO t1 VALUES('1'), ('2');
DROP TABLE t1;
CREATE TABLE t1 (a INT, KEY USING BTREE(a)) ENGINE=MEMORY;
INSERT INTO t1 VALUES(1),(2),(2);
DELETE FROM t1 WHERE a=2;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(val INT, KEY USING BTREE(val)) ENGINE=memory;
INSERT INTO t1 VALUES(0);
SELECT INDEX_LENGTH FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='t1';
UPDATE t1 SET val=1;
SELECT INDEX_LENGTH FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='t1';
DROP TABLE t1;
CREATE TABLE t1 (a INT, UNIQUE USING BTREE(a)) ENGINE=MEMORY;
INSERT INTO t1 VALUES(NULL),(NULL);
DROP TABLE t1;
create table t1(a varchar(255), b varchar(255), 
                key using btree (a,b)) engine=memory;
insert into t1 values (1, 1), (3, 3), (2, 2), (NULL, 1), (NULL, NULL), (0, 0);
select * from t1 where a is null;
drop table t1;
CREATE TABLE t1(a INT, KEY USING BTREE (a)) ENGINE=MEMORY;
INSERT INTO t1 VALUES(1),(1);
DELETE a1 FROM t1 AS a1, t1 AS a2 WHERE a1.a=a2.a;
DROP TABLE t1;
CREATE TABLE t1(
  id INT AUTO_INCREMENT PRIMARY KEY,
  c1 INT NOT NULL,
  c2 INT NOT NULL,
  UNIQUE KEY USING BTREE (c2,c1)) ENGINE = MEMORY;
INSERT INTO t1(c1,c2) VALUES (5,1), (4,1), (3,5), (2,3), (1,3);
SELECT c2, COUNT(c1) FROM t1 GROUP BY c2;
DROP TABLE t1;
