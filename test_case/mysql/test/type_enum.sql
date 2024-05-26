select field from t1 group by field;
drop table t1;
create table t1 (a enum (' ','a','b') not null);
drop table t1;
create table t1 (a enum (' ','a','b ') not null default 'b ');
drop table t1;
create table t1 (a enum ('0','1'));
select * from t1;
update t1 set a = replace(a,'x','y');
select * from t1;
drop table t1;
create table t1 (a enum(0xE4, '1', '2') not null default 0xE4) character set latin1;
drop table t1;
CREATE TABLE t1 (c enum('a', 'A') BINARY);
INSERT INTO t1 VALUES ('a'),('A');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (c enum('ae','oe','ue','ss') collate latin1_german2_ci);
SELECT * FROM t1;
DROP TABLE t1;
create table t1 (a enum ('Y','N') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin);
insert into t1 values ('Y');
alter table t1 add b set ('Y','N') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin;
alter table t1 add c enum ('Y','N') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin;
select * from t1;
drop table t1;
create table t1 (a enum('x','y') default 'x');
drop table t1;
create table t1 (a set('x','y') default 'x');
drop table t1;
create table t1 (f1 int);
alter table t1 add f2 enum(0xFFFF);
drop table t1;
create table t1(denormal enum('E','F','E,F','F,E') NOT NULL DEFAULT'E');
drop table t1;
CREATE TABLE t1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  c1 ENUM('a', '', 'b')
);
SELECT id, c1 + 0, c1 FROM t1;
ALTER TABLE t1 CHANGE c1 c1 ENUM('a', '') NOT NULL;
SELECT id, c1 + 0, c1 FROM t1;
DROP TABLE t1;
create table t1(f1 set('a','b'), index(f1));
insert into t1 values(''),(''),('a'),('b');
select * from t1 where f1='';
drop table t1;
CREATE TABLE t1 (c1 ENUM('a', '', 'b'));
INSERT INTO t1 (c1) VALUES ('b');
INSERT INTO t1 (c1) VALUES ('');
INSERT INTO t1 (c1) VALUES ('');
SELECT c1 + 0, COUNT(c1) FROM t1 GROUP BY c1;
CREATE TABLE t2 SELECT * FROM t1;
SELECT c1 + 0 FROM t2;
DROP TABLE t1,t2;
CREATE TABLE t1(a enum('a','b','c','d'));
SELECT a FROM t1;
SELECT a FROM t1 WHERE a=0;
ALTER TABLE t1 ADD PRIMARY KEY (a);
SELECT a FROM t1 WHERE a=0;
DROP TABLE t1;
select ROUTINE_SCHEMA, ROUTINE_NAME, ROUTINE_TYPE
  from INFORMATION_SCHEMA.ROUTINES
  where ROUTINE_TYPE = 'FUNCTION'
  order by  ROUTINE_SCHEMA, ROUTINE_NAME;
CREATE TABLE grants (
  USER char(32),
  HOST char(60),
  PRIV char(32),
  WITH_GRANT_OPTION enum('N','Y'),
  PRIMARY KEY (WITH_GRANT_OPTION,`USER`,`HOST`, `PRIV`)
) engine innodb;
insert into grants values ('root','localhost','AXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','BXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','CXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','DXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','EXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','FXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','GXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','HXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','IXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','JXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','KXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','LXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','MXA_RECOVER_ADMIN','Y');
insert into grants values ('root','localhost','XA_RECOVER_ADMIN','Y');
drop table grants;
CREATE TABLE t_double (a double not null);
INSERT INTO t_double (a) VALUES
(-20000000000000000000000000000.0001), (20000000000000000000000000000.0001);
CREATE TABLE t_enum (
  b enum('N','Y')
);
INSERT IGNORE INTO t_enum (b) SELECT a from t_double;
SELECT b FROM t_enum;
DROP TABLE t_double, t_enum;
