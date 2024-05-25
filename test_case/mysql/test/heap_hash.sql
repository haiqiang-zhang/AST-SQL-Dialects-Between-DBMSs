delete from t1 where a=1 or a=0;
select * from t1;
select * from t1 where a=4;
update t1 set b=5 where a=4;
update t1 set b=b+1 where a>=3;
select * from t1;
alter table t1 add c int not null, add key using HASH (c,a);
drop table t1;
create table t1 (a int not null,b int not null, primary key using HASH (a)) engine=heap comment="testing heaps";
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a > 0;
select * from t1;
drop table t1;
create table t1 (x int not null, y int not null, key x  using HASH (x), unique y  using HASH (y))
engine=heap;
insert into t1 values (1,1),(2,2),(1,3),(2,4),(2,5),(2,6);
select * from t1 where x=1;
select * from t1,t1 as t2 where t1.x=t2.y;
drop table t1;
create table t1 (a int) engine=heap;
insert into t1 values(1);
select max(a) from t1;
drop table t1;
CREATE TABLE t1 ( a int not null default 0, b int not null default 0,  key  using HASH (a),  key  using HASH (b)  ) ENGINE=HEAP;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
drop table t1;
create table t1 (id int unsigned not null, primary key  using HASH (id)) engine=HEAP;
insert into t1 values(1);
select max(id) from t1;
insert into t1 values(2);
select max(id) from t1;
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
create table t1 (btn char(10) not null, key using HASH (btn)) charset utf8mb4 engine=heap;
insert into t1 values ("hello"),("hello"),("hello"),("hello"),("hello"),("a"),("b"),("c"),("d"),("e"),("f"),("g"),("h"),("i");
select * from t1 where btn like "q%";
alter table t1 add column new_col char(1) not null, add key using HASH (btn,new_col), drop key btn;
update t1 set new_col=left(btn,1);
drop table t1;
CREATE TABLE t1 (
  a int default NULL,
  b int default NULL,
  KEY a using HASH (a),
  UNIQUE b using HASH (b)
) engine=heap;
INSERT INTO t1 VALUES (NULL,99),(99,NULL),(1,1),(2,2),(1,3);
SELECT * FROM t1 WHERE a=NULL;
SELECT * FROM t1 WHERE a<=>NULL;
SELECT * FROM t1 WHERE b=NULL;
SELECT * FROM t1 WHERE b<=>NULL;
DROP TABLE t1;
CREATE TABLE t1 (a int not null, primary key using HASH (a)) engine=heap;
INSERT into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11);
DELETE from t1 where a < 100;
SELECT * from t1;
DROP TABLE t1;
create table t1
(
  a char(8) not null,
  b char(20) not null,
  c int not null,
  key (a)
) charset utf8mb4 engine=heap;
insert into t1 values ('aaaa', 'prefill-hash=5',0);
insert into t1 values ('aaab', 'prefill-hash=0',0);
insert into t1 values ('aaac', 'prefill-hash=7',0);
insert into t1 values ('aaad', 'prefill-hash=2',0);
insert into t1 values ('aaae', 'prefill-hash=1',0);
insert into t1 values ('aaaf', 'prefill-hash=4',0);
insert into t1 values ('aaag', 'prefill-hash=3',0);
insert into t1 values ('aaah', 'prefill-hash=6',0);
insert into t1 select * from t1;
create table t2 as select * from t1;
delete from t1;
insert into t1 select * from t2;
drop table t1, t2;
create table t1 (
  id int unsigned not null primary key auto_increment, 
  name varchar(20) not null,
  index heap_idx(name),
  index btree_idx using btree(name)
) charset latin1 engine=heap;
create table t2 (
  id int unsigned not null primary key auto_increment, 
  name varchar(20) not null,
  index btree_idx using btree(name),
  index heap_idx(name)
) charset latin1 engine=heap;
insert into t1 (name) values ('Matt'), ('Lilu'), ('Corbin'), ('Carly'), 
  ('Suzy'), ('Hoppy'), ('Burrito'), ('Mimi'), ('Sherry'), ('Ben'), ('Phil'), 
  ('Emily');
insert into t2 select * from t1;
insert into t1 (name) select name from t2;
insert into t1 (name) select name from t2;
insert into t1 (name) select name from t2;
insert into t1 (name) select name from t2;
insert into t1 (name) select name from t2;
insert into t1 (name) select name from t2;
select count(*) from t1 where name='Matt';
create table t3
(
  a varchar(20) not null,
  b varchar(20) not null,
  key (a,b)
) charset latin1 engine=heap;
insert into t3 select name, name from t1;
drop table t1, t2, t3;
create temporary table t1 ( a int, index (a) ) engine=memory;
insert into t1 values (1),(2),(3),(4),(5);
select a from t1 where a in (1,3);
drop table t1;
CREATE TABLE t1(col1 VARCHAR(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL, 
                col2 VARCHAR(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL, 
                UNIQUE KEY key1 USING HASH (col1, col2)) ENGINE=MEMORY;
INSERT INTO t1 VALUES('A', 'A');
DROP TABLE t1;
CREATE TABLE t1(col1 VARCHAR(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL, 
                col2 VARCHAR(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL, 
                UNIQUE KEY key1 USING HASH (col1, col2)) ENGINE=MEMORY;
INSERT INTO t1 VALUES('A', 'A');
DROP TABLE t1;
CREATE TABLE t1 (col_int_nokey INT,
                 col_int_key INT,
		 INDEX(col_int_key) USING HASH) ENGINE = HEAP;
INSERT INTO t1 (col_int_nokey, col_int_key) VALUES (3, 0), (4, 0), (3, 1);
DELETE FROM t1 WHERE col_int_nokey = 5 ORDER BY col_int_key LIMIT 2;
DROP TABLE t1;
CREATE TABLE t1
(
   pk INT PRIMARY KEY,
   val INT,
   UNIQUE KEY USING HASH(val)
) ENGINE=MEMORY;
INSERT INTO t1 VALUES (1, NULL);
INSERT INTO t1 VALUES (2, NULL);
INSERT INTO t1 VALUES (3, NULL);
INSERT INTO t1 VALUES (4, NULL);
SELECT * FROM t1 WHERE val IS NULL;
DROP TABLE t1;
CREATE TABLE t1(
  id INT AUTO_INCREMENT PRIMARY KEY,
  c1 INT NOT NULL,
  c2 INT NOT NULL,
  UNIQUE KEY USING HASH (c2,c1)) ENGINE = MEMORY;
INSERT INTO t1(c1,c2) VALUES (5,1), (4,1), (3,5), (2,3), (1,3);
SELECT c2, COUNT(c1) FROM t1 GROUP BY c2;
DROP TABLE t1;
CREATE TABLE t1 (
  f1 int NOT NULL,
  f2 int NOT NULL,
  f3 date NOT NULL,
  KEY k1 (f2,f3) USING HASH
) ENGINE=MEMORY;
INSERT INTO t1 VALUES
(1, 15409, '2019-02-25'), (2, 15911, '2019-02-25'), (3, 15929, '2019-02-25'), (4, 15936, '2019-02-25'),
(5, 16004, '2019-02-25'), (6, 16005, '2019-02-25'), (7, 16007, '2019-02-25'),(8, 16029, '2019-02-25'),
(9, 16031, '2019-02-25'), (10, 16052, '2019-02-25'), (11, 16054, '2019-02-25'), (12, 16040, '2019-02-25'),
(13, 12485, '2019-02-25'), (14, 15892, '2019-02-25'), (15, 16035, '2019-02-25'), (16, 16060, '2019-02-25'),
(17, 16066, '2019-02-25'), (18, 16093, '2019-02-25'), (19, 16057, '2019-02-25'), (20, 16027, '2019-02-25'),
(21, 15988, '2019-02-25');
DROP TABLE t1;
