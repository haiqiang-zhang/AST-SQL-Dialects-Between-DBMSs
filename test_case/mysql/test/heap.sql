drop table if exists t1,t2,t3;
create table t1 (a int not null,b int not null, primary key (a)) engine=heap comment="testing heaps" avg_row_length=100 min_rows=1 max_rows=100;
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a=1 or a=0;
select * from t1;
select * from t1 where a=4;
update t1 set b=5 where a=4;
update t1 set b=b+1 where a>=3;
select * from t1;
alter table t1 add c int not null, add key (c,a);
drop table t1;
create table t1 (a int not null,b int not null, primary key (a)) engine=memory comment="testing heaps";
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a > 0;
select * from t1;
drop table t1;
create table t1 (a int not null,b int not null, primary key (a)) engine=heap comment="testing heaps";
insert into t1 values(1,1),(2,2),(3,3),(4,4);
alter table t1 modify a int not null auto_increment, engine=innodb, comment="new innodb table";
select * from t1;
drop table t1;
create table t1 (a int not null) engine=heap;
insert into t1 values (869751),(736494),(226312),(802616),(728912);
select * from t1 where a > 736494;
alter table t1 add unique uniq_id(a);
select * from t1 where a > 736494;
select * from t1 where a = 736494;
select * from t1 where a=869751 or a=736494;
select * from t1 where a in (869751,736494,226312,802616);
alter table t1 engine=innodb;
drop table t1;
create table t1 (x int not null, y int not null, key x (x), unique y (y))
engine=heap;
insert into t1 values (1,1),(2,2),(1,3),(2,4),(2,5),(2,6);
select * from t1 where x=1;
select * from t1,t1 as t2 where t1.x=t2.y;
drop table t1;
create table t1 (a int) engine=heap;
insert into t1 values(1);
select max(a) from t1;
drop table t1;
CREATE TABLE t1 ( a int not null default 0, b int not null default 0,  key(a),  key(b)  ) ENGINE=HEAP;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
drop table t1;
create table t1 (id int unsigned not null, primary key (id)) engine=HEAP;
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
create table t1 (btn char(10) not null, key(btn)) charset utf8mb4 engine=heap;
insert into t1 values ("hello"),("hello"),("hello"),("hello"),("hello"),("a"),("b"),("c"),("d"),("e"),("f"),("g"),("h"),("i");
select * from t1 where btn like "q%";
alter table t1 add column new_col char(1) not null, add key (btn,new_col), drop key btn;
update t1 set new_col=left(btn,1);
drop table t1;
CREATE TABLE t1 (
  a int default NULL,
  b int default NULL,
  KEY a (a),
  UNIQUE b (b)
) engine=heap;
INSERT INTO t1 VALUES (NULL,99),(99,NULL),(1,1),(2,2),(1,3);
SELECT * FROM t1 WHERE a=NULL;
SELECT * FROM t1 WHERE a<=>NULL;
SELECT * FROM t1 WHERE b=NULL;
SELECT * FROM t1 WHERE b<=>NULL;
DROP TABLE t1;
CREATE TABLE t1 (
  a int default NULL,
  key a (a)
) ENGINE=HEAP;
INSERT INTO t1 VALUES (10), (10), (10);
SELECT * FROM t1 WHERE a=10;
DROP TABLE t1;
CREATE TABLE t1 (a int not null, primary key(a)) engine=heap;
INSERT into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11);
DELETE from t1 where a < 100;
SELECT * from t1;
DROP TABLE t1;
CREATE TABLE `job_titles` (
  `job_title_id` int(6) unsigned NOT NULL default '0',
  `job_title` char(18) NOT NULL default '',
  PRIMARY KEY  (`job_title_id`),
  UNIQUE KEY `job_title_id` (`job_title_id`,`job_title`)
) ENGINE=HEAP;
SELECT MAX(job_title_id) FROM job_titles;
DROP TABLE job_titles;
CREATE TABLE t1 (a INT NOT NULL, B INT, KEY(B)) ENGINE=HEAP;
INSERT INTO t1 VALUES(1,1), (1,NULL);
SELECT * FROM t1 WHERE B is not null;
DROP TABLE t1;
CREATE TABLE t1 (pseudo char(35) PRIMARY KEY, date int(10) unsigned NOT NULL) ENGINE=HEAP;
INSERT INTO t1 VALUES ('massecot',1101106491),('altec',1101106492),('stitch+',1101106304),('Seb Corgan',1101106305),('beerfilou',1101106263),('flaker',1101106529),('joce8',5),('M4vrick',1101106418),('gabay008',1101106525),('Vamp irX',1101106291),('ZoomZip',1101106546),('rip666',1101106502),('CBP ',1101106397),('guezpard',1101106496);
DELETE FROM t1 WHERE date<1101106546;
SELECT * FROM t1;
DROP TABLE t1;
create table t1(a char(2)) engine=memory;
insert into t1 values (NULL), (NULL);
delete from t1 where a is null;
insert into t1 values ('2'), ('3');
select * from t1;
drop table t1;
create table t1 (v varchar(10), c char(10), t varchar(50)) charset utf8mb4;
insert into t1 values('+ ', '+ ', '+ ');
insert into t1 values (concat('+',@a),concat('+',@a),concat('+',@a));
select concat('*',v,'*',c,'*',t,'*') from t1;
create table t2 like t1;
create table t3 charset utf8mb4 select * from t1;
alter table t1 modify c varchar(10);
alter table t1 modify v char(10);
alter table t1 modify t varchar(10);
select concat('*',v,'*',c,'*',t,'*') from t1;
drop table t1,t2,t3;
create table t1 (v varchar(10), c char(10), t varchar(50), key(v), key(c), key(t(10))) charset latin1;
insert into t1 values(concat(@char,@space),concat(@char,@space),concat(@char,@space));
select count(*) from t1;
insert into t1 values(concat('a','!'),concat('a','!'),concat('a','!'));
select count(*) from t1 where v='a';
select count(*) from t1 where c='a';
select count(*) from t1 where t='a';
select count(*) from t1 where v='a  ';
select count(*) from t1 where c='a  ';
select count(*) from t1 where t='a  ';
select count(*) from t1 where v between 'a' and 'a ';
select count(*) from t1 where v between 'a' and 'a ' and v between 'a  ' and 'b\n';
select count(*) from t1 where v like 'a%';
select count(*) from t1 where c like 'a%';
select count(*) from t1 where t like 'a%';
select count(*) from t1 where v like 'a %';
alter table t1 add unique(v);
select concat('*',v,'*',c,'*',t,'*') as qq from t1 where v='a' order by length(concat('*',v,'*',c,'*',t,'*'));
select v,count(*) from t1 group by v order by v limit 9;
select v,count(t) from t1 group by v order by v limit 10;
select v,count(c) from t1 group by v order by v limit 10;
select sql_big_result trim(v),count(t) from t1 group by v order by v limit 10;
select sql_big_result trim(v),count(c) from t1 group by v order by v limit 10;
select c,count(*) from t1 group by c order by c limit 10;
select c,count(t) from t1 group by c order by c limit 10;
select sql_big_result c,count(t) from t1 group by c order by c limit 10;
select t,count(*) from t1 group by t order by t limit 10;
select t,count(t) from t1 group by t order by t limit 10;
select sql_big_result trim(t),count(t) from t1 group by t order by t limit 10;
drop table t1;
create table t1 (a char(10), unique (a)) charset latin1;
insert into t1 values ('a');
alter table t1 modify a varchar(10);
update t1 set a='a      ' where a like 'a ';
update t1 set a='a  ' where a like 'a      ';
drop table t1;
create table t1 (v varchar(10), c char(10), t varchar(50), key using btree (v), key using btree (c), key using btree (t(10))) charset latin1;
insert into t1 values(concat(@char,@space),concat(@char,@space),concat(@char,@space));
select count(*) from t1;
insert into t1 values(concat('a',char(1)),concat('a',char(1)),concat('a',char(1)));
select count(*) from t1 where v='a';
select count(*) from t1 where c='a';
select count(*) from t1 where t='a';
select count(*) from t1 where v='a  ';
select count(*) from t1 where c='a  ';
select count(*) from t1 where t='a  ';
select count(*) from t1 where v between 'a' and 'a ';
select count(*) from t1 where v between 'a' and 'a ' and v between 'a  ' and 'b\n';
alter table t1 add unique(v);
select concat('*',v,'*',c,'*',t,'*') as qq from t1 where v='a' order by length(concat('*',v,'*',c,'*',t,'*'));
drop table t1;
create table t1 (a char(10), unique using btree (a)) charset latin1 engine=heap;
insert into t1 values ('a');
alter table t1 modify a varchar(10);
update t1 set a='a      ' where a like 'a ';
update t1 set a='a  ' where a like 'a      ';
drop table t1;
create table t1 (v varchar(10), c char(10), t varchar(50), key(v(5)), key(c(5)), key(t(5))) charset utf8mb4;
drop table t1;
create table t1 (v varchar(65530), key(v(10))) charset latin1;
insert into t1 values(repeat('a',65530));
select length(v) from t1 where v=repeat('a',65530);
drop table t1;
create table t1 (a bigint unsigned auto_increment primary key, b int,
  key (b, a)) engine=heap;
insert t1 (b) values (1),(1),(1),(1),(1),(1),(1),(1);
select * from t1;
drop table t1;
create table t1 (a int not null, b int not null auto_increment,
  primary key(a, b), key(b)) engine=heap;
insert t1 (a) values (1),(1),(1),(1),(1),(1),(1),(1);
select * from t1;
drop table t1;
create table t1 (c char(255), primary key(c(90)));
insert into t1 values ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz");
drop table t1;
CREATE TABLE t1 (a int, key(a)) engine=heap;
insert into t1 values (0);
delete from t1;
select * from t1;
insert into t1 values (0), (1);
select * from t1 where a = 0;
drop table t1;
create table t1 (c char(10)) charset utf8mb4 engine=memory;
create table t2 (c varchar(10)) charset utf8mb4 engine=memory;
drop table t1, t2;
CREATE TABLE t1(a VARCHAR(1), b VARCHAR(2), c VARCHAR(256),
                KEY(a), KEY(b), KEY(c)) ENGINE=MEMORY;
INSERT INTO t1 VALUES('a','aa',REPEAT('a', 256)),('a','aa',REPEAT('a',256));
SELECT COUNT(*) FROM t1 WHERE a='a';
SELECT COUNT(*) FROM t1 WHERE b='aa';
SELECT COUNT(*) FROM t1 WHERE c=REPEAT('a',256);
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(100), c2 INT) ENGINE=MEMORY;
INSERT INTO t1 VALUES('', 0);
ALTER TABLE t1 MODIFY c1 VARCHAR(101);
SELECT c2 FROM t1;
DROP TABLE t1;
CREATE TABLE h1 (f1 VARCHAR(1), f2 INT NOT NULL,
                 UNIQUE KEY h1i (f1,f2) USING BTREE ) ENGINE=HEAP;
INSERT INTO h1 VALUES(NULL,0),(NULL,1);
SELECT 'wrong' as 'result' FROM dual WHERE ('h', 0) NOT IN (SELECT * FROM h1);
CREATE TABLE t1 (  
  pk int NOT NULL,  
  col_int_nokey INT,  
  col_varchar_nokey VARCHAR(1),  
  PRIMARY KEY (pk)  
);
INSERT INTO t1 VALUES (19,5,'h'),(20,5,'h');
CREATE TABLE t2 (col_int_nokey INT);
INSERT INTO t2 VALUES (1),(2);
CREATE VIEW v1 AS
  SELECT col_varchar_nokey, COUNT( col_varchar_nokey )
  FROM t1
  WHERE col_int_nokey <= 141 AND pk <= 4;
DROP TABLE t1,t2,h1;
DROP VIEW v1;
CREATE TABLE t1 (
    c1 VARCHAR(10) NOT NULL,
    KEY i1 (c1(3))
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES ('foo1'), ('bar2'), ('baz3');
SELECT * FROM t1 WHERE c1='bar2';
SELECT * FROM t1 IGNORE INDEX (i1) WHERE c1='bar2';
DROP TABLE t1;
