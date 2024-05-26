drop table if exists t1,t2,v1,v2;
drop view if exists t1,t2,v1,v2;
CREATE TABLE `t1` (
  a int not null auto_increment,
  `pseudo` varchar(35) character set latin2 NOT NULL default '',
  `email` varchar(60) character set latin2 NOT NULL default '',
  PRIMARY KEY  (a),
  UNIQUE KEY `email` USING BTREE (`email`)
) ENGINE=HEAP CHARSET=latin1 ROW_FORMAT DYNAMIC;
drop table t1;
create table t1 ( min_num   dec(6,6)     default .000001);
drop table t1;
create table t1 ( min_num   dec(6,6)     default 0.000001);
drop table t1;
create table t1 ( min_num   dec(6,6)     default .000001);
drop table t1;
create table t1
(f1 integer auto_increment primary key,
 f2 timestamp not null default current_timestamp on update current_timestamp);
drop table t1;
CREATE TABLE t1 (p int not null auto_increment, a varchar(20), primary key(p)) charset latin1;
INSERT t1 (a) VALUES
('\\'),
('\n'),
('\b'),
('\r'),
('\t'),
('\x'),
('\a'),
('\aa'),
('\\a'),
('\\aa'),
('_'),
('\_'),
('\\_'),
('\\\_'),
('\\\\_'),
('%'),
('\%'),
('\\%'),
('\\\%'),
('\\\\%');
SELECT p, hex(a) FROM t1;
delete from t1 where a in ('\n','\r','\t', '\b');
select
  masks.p,
  masks.a as mask,
  examples.a as example
from
            t1 as masks
  left join t1 as examples on examples.a LIKE masks.a
order by masks.p, example;
DROP TABLE t1;
CREATE TABLE t1 (p int not null auto_increment, a varchar(20), primary key(p)) charset latin1;
INSERT t1 (a) VALUES
('\\'),
('\n'),
('\b'),
('\r'),
('\t'),
('\x'),
('\a'),
('\aa'),
('\\a'),
('\\aa'),
('_'),
('\_'),
('\\_'),
('\\\_'),
('\\\\_'),
('%'),
('\%'),
('\\%'),
('\\\%'),
('\\\\%');
delete from t1 where a in ('\n','\r','\t', '\b');
select
  masks.p,
  masks.a as mask,
  examples.a as example
from
            t1 as masks
  left join t1 as examples on examples.a LIKE masks.a
order by masks.p, example;
DROP TABLE t1;
SELECT 'a\\b', 'a\\\"b', 'a''\\b', 'a''\\\"b';
SELECT "a\\b", "a\\\'b", "a""\\b", "a""\\\'b";
SELECT 'a\\b', 'a\\\"b', 'a''\\b', 'a''\\\"b';
SELECT "a\\b", "a\\\'b", "a""\\b", "a""\\\'b";
create table t1 (a int);
create table t2 (a int);
create view v1 as select a from t1;
create view v2 as select a from t2 where a in (select a from v1);
drop view v2, v1;
drop table t1, t2;
select @@sql_mode;
select @@sql_mode;
select @@sql_mode;
select @@sql_mode;
select @@sql_mode;
create table t1 (a int auto_increment primary key, b char(5));
insert into t1 (b) values('a'),('b\t'),('c ');
select concat('x',b,'x') from t1;
drop table t1;
select current_user();
SELECT @@sql_mode LIKE '%NO_ENGINE_SUBSTITUTION%';
DROP TABLE IF EXISTS t1,t2;
CREATE TABLE t1 (f1 BIGINT);
CREATE TABLE t2 (f1 CHAR(3) NOT NULL, f2 CHAR(20));
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE IF EXISTS test_table;
DROP FUNCTION IF EXISTS test_function;
CREATE TABLE test_table (c1 CHAR(50));
PREPARE insert_stmt FROM 'INSERT INTO test_table VALUES (?)';
PREPARE update_stmt FROM 'UPDATE test_table SET c1= ? WHERE c1= ?';
SELECT * FROM test_table;
SELECT * FROM test_table;
DELETE FROM test_table;
SELECT * FROM test_table;
SELECT * FROM test_table;
DROP TABLE test_table;
SELECT @@sql_mode;
SELECT @@sql_mode;
SELECT @@sql_mode;
SELECT '\'';
CREATE TABLE test(id INT, count DOUBLE);
INSERT INTO test VALUES (1,0), (2,0);
PREPARE stmt FROM 'UPDATE test SET count = count + 1 WHERE id = ?';
SELECT * FROM test;
DROP TABLE test;
