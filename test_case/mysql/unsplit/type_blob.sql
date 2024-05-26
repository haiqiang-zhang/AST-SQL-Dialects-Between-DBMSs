drop table if exists t1,t2,t3,t4,t5,t6,t7;
CREATE TABLE t1 (a blob, b text, c blob(250), d text(70000), e text(70000000));
create table t3 (a long, b long byte);
drop table if exists t1,t2;
create table t1 (nr int(5) not null auto_increment,b blob,str char(10), primary key (nr));
insert into t1 values (null,"a","A");
insert into t1 values (null,"bbb","BBB");
insert into t1 values (null,"ccc","CCC");
select last_insert_id();
select * from t1,t1 as t2;
drop table t1;
create table t1 (a text);
insert into t1 values ('where');
update t1 set a='Where';
select * from t1;
drop table t1;
create table t1 (t text,c char(10),b blob, d varbinary(10));
insert into t1 values (NULL,NULL,NULL,NULL);
insert into t1 values ("","","","");
insert into t1 values ("hello","hello","hello","hello");
insert into t1 values ("HELLO","HELLO","HELLO","HELLO");
insert into t1 values ("HELLO MY","HELLO MY","HELLO MY","HELLO MY");
insert into t1 values ("a","a","a","a");
insert into t1 values (1,1,1,1);
insert into t1 values (NULL,NULL,NULL,NULL);
update t1 set c="",b=null where c="1";
lock tables t1 READ;
lock tables t1 WRITE;
unlock tables;
select t from t1 where t like "hello";
select c from t1 where c like "hello";
select b from t1 where b like "hello";
select d from t1 where d like "hello";
select c from t1 having c like "hello";
select d from t1 having d like "hello";
select t from t1 where t like "%HELLO%";
select c from t1 where c like "%HELLO%";
select b from t1 where b like "%HELLO%";
select d from t1 where d like "%HELLO%";
select c from t1 having c like "%HELLO%";
select d from t1 having d like "%HELLO%";
select d from t1 having d like "%HE%LLO%";
select t from t1 order by t;
select c from t1 order by c;
select b from t1 order by b;
select d from t1 order by d;
select distinct t from t1;
select distinct b from t1;
select distinct t from t1 order by t;
select distinct b from t1 order by b;
select t from t1 group by t;
select b from t1 group by b;
select distinct t from t1;
select distinct b from t1;
select distinct t from t1 order by t;
select distinct b from t1 order by b;
select distinct c from t1;
select distinct d from t1;
select distinct c from t1 order by c;
select distinct d from t1 order by d;
select c from t1 group by c;
select d from t1 group by d;
select distinct * from t1;
select t,count(*) from t1 group by t;
drop table t1;
CREATE TABLE t1 (
  t1_id bigint(21) NOT NULL auto_increment,
  _field_72 varchar(128) DEFAULT '' NOT NULL,
  _field_95 varchar(32),
  _field_115 tinyint(4) DEFAULT '0' NOT NULL,
  _field_122 tinyint(4) DEFAULT '0' NOT NULL,
  _field_126 tinyint(4),
  _field_134 tinyint(4),
  PRIMARY KEY (t1_id),
  UNIQUE _field_72 (_field_72),
  KEY _field_115 (_field_115),
  KEY _field_122 (_field_122)
);
INSERT INTO t1 VALUES (1,'admin','21232f297a57a5a743894a0e4a801fc3',0,1,NULL,NULL);
INSERT INTO t1 VALUES (2,'hroberts','7415275a8c95952901e42b13a6b78566',0,1,NULL,NULL);
INSERT INTO t1 VALUES (3,'guest','d41d8cd98f00b204e9800998ecf8427e',1,0,NULL,NULL);
CREATE TABLE t2 (
  seq_0_id bigint(21) DEFAULT '0' NOT NULL,
  seq_1_id bigint(21) DEFAULT '0' NOT NULL,
  PRIMARY KEY (seq_0_id,seq_1_id)
);
INSERT INTO t2 VALUES (1,1);
INSERT INTO t2 VALUES (2,1);
INSERT INTO t2 VALUES (2,2);
CREATE TABLE t4 (
  seq_0_id bigint(21) DEFAULT '0' NOT NULL,
  seq_1_id bigint(21) DEFAULT '0' NOT NULL,
  PRIMARY KEY (seq_0_id,seq_1_id)
);
INSERT INTO t4 VALUES (1,1);
INSERT INTO t4 VALUES (2,1);
CREATE TABLE t5 (
  t5_id bigint(21) NOT NULL auto_increment,
  _field_149 tinyint(4),
  _field_156 varchar(128) DEFAULT '' NOT NULL,
  _field_157 varchar(128) DEFAULT '' NOT NULL,
  _field_158 varchar(128) DEFAULT '' NOT NULL,
  _field_159 varchar(128) DEFAULT '' NOT NULL,
  _field_160 varchar(128) DEFAULT '' NOT NULL,
  _field_161 varchar(128) DEFAULT '' NOT NULL,
  PRIMARY KEY (t5_id),
  KEY _field_156 (_field_156),
  KEY _field_157 (_field_157),
  KEY _field_158 (_field_158),
  KEY _field_159 (_field_159),
  KEY _field_160 (_field_160),
  KEY _field_161 (_field_161)
);
INSERT INTO t5 VALUES (1,0,'tomato','','','','','');
INSERT INTO t5 VALUES (2,0,'cilantro','','','','','');
CREATE TABLE t6 (
  seq_0_id bigint(21) DEFAULT '0' NOT NULL,
  seq_1_id bigint(21) DEFAULT '0' NOT NULL,
  PRIMARY KEY (seq_0_id,seq_1_id)
);
INSERT INTO t6 VALUES (1,1);
INSERT INTO t6 VALUES (1,2);
INSERT INTO t6 VALUES (2,2);
CREATE TABLE t7 (
  t7_id bigint(21) NOT NULL auto_increment,
  _field_143 tinyint(4),
  _field_165 varchar(32),
  _field_166 smallint(6) DEFAULT '0' NOT NULL,
  PRIMARY KEY (t7_id),
  KEY _field_166 (_field_166)
);
INSERT INTO t7 VALUES (1,0,'High',1);
INSERT INTO t7 VALUES (2,0,'Medium',2);
INSERT INTO t7 VALUES (3,0,'Low',3);
drop table t1,t2,t3,t4,t5,t6,t7;
create table t1 (a blob);
insert into t1 values ("empty"),("");
select a,reverse(a) from t1;
drop table t1;
create table t1 (a blob, key (a(10)));
insert into t1 values ("bye"),("hello"),("hello"),("hello word");
select * from t1 where a like "hello%";
drop table t1;
CREATE TABLE t1 (
       f1 int(11) DEFAULT '0' NOT NULL,
       f2 varchar(16) DEFAULT '' NOT NULL,
       f5 text,
       KEY index_name (f1,f2,f5(16))
    );
INSERT INTO t1 VALUES (0,'traktor','1111111111111');
INSERT INTO t1 VALUES (1,'traktor','1111111111111111111111111');
drop table t1;
create table t1 (foobar tinyblob not null, boggle smallint not null, key (foobar(32), boggle));
insert into t1 values ('fish', 10),('bear', 20);
select foobar, boggle from t1 where foobar = 'fish';
select foobar, boggle from t1 where foobar = 'fish' and boggle = 10;
drop table t1;
create table t1 (id integer primary key auto_increment, txt text not null, unique index txt_index (txt (20))) charset latin1;
alter table t1 drop index txt_index, add index txt_index (txt(20));
insert into t1 (txt) values ('Chevy ');
select * from t1 where txt='Chevy';
select * from t1 where txt='Chevy ';
select * from t1 where txt='Chevy ' or txt='Chevy';
select * from t1 where txt='Chevy' or txt='Chevy ';
select * from t1 where id='1' or id='2';
insert into t1 (txt) values('Ford');
select * from t1 where txt='Chevy' or txt='Chevy ' or txt='Ford';
select * from t1 where txt='Chevy' or txt='Chevy ';
select * from t1 where txt='Chevy' or txt='Chevy ' or txt=' Chevy';
select * from t1 where txt in ('Chevy ','Chevy');
select * from t1 where txt in ('Chevy');
select * from t1 where txt between 'Chevy' and 'Chevy';
select * from t1 where txt between 'Chevy' and 'Chevy' or txt='Chevy ';
select * from t1 where txt between 'Chevy' and 'Chevy ';
select * from t1 where txt < 'Chevy ';
select * from t1 where txt <= 'Chevy';
select * from t1 where txt > 'Chevy';
select * from t1 where txt >= 'Chevy';
drop table t1;
create table t1 (id integer primary key auto_increment, txt text, index txt_index (txt (20))) charset latin1;
insert into t1 (txt) values ('Chevy'), ('Chevy '), (NULL);
select * from t1 where txt='Chevy' or txt is NULL;
select * from t1 where txt='Chevy ';
select * from t1 where txt='Chevy ' or txt='Chevy';
select * from t1 where txt='Chevy' or txt='Chevy ';
select * from t1 where id='1' or id='2';
insert into t1 (txt) values('Ford');
select * from t1 where txt='Chevy' or txt='Chevy ' or txt='Ford';
select * from t1 where txt='Chevy' or txt='Chevy ';
select * from t1 where txt='Chevy' or txt='Chevy ' or txt=' Chevy';
select * from t1 where txt in ('Chevy ','Chevy');
select * from t1 where txt in ('Chevy');
select * from t1 where txt between 'Chevy' and 'Chevy';
select * from t1 where txt between 'Chevy' and 'Chevy' or txt='Chevy ';
select * from t1 where txt between 'Chevy' and 'Chevy ';
select * from t1 where txt < 'Chevy ';
select * from t1 where txt < 'Chevy ' or txt is NULL;
select * from t1 where txt <= 'Chevy';
select * from t1 where txt > 'Chevy';
select * from t1 where txt >= 'Chevy';
alter table t1 modify column txt blob;
select * from t1 where txt='Chevy' or txt is NULL;
select * from t1 where txt='Chevy' or txt is NULL order by txt;
drop table t1;
CREATE TABLE t1 ( i int(11) NOT NULL default '0',    c text NOT NULL, d varchar(1) NOT NULL DEFAULT ' ', PRIMARY KEY  (i), KEY (c(1),d));
INSERT t1 (i, c) VALUES (1,''),(2,''),(3,'asdfh'),(4,'');
select max(i) from t1 where c = '';
drop table t1;
create table t1 (a int, b int, c tinyblob, d int, e int);
alter table t1 add primary key (a,b,c(255),d);
alter table t1 add key (a,b,d,e);
drop table t1;
CREATE table t1 (a blob);
insert into t1 values ('b'),('a\0'),('a'),('a '),('aa'),(NULL);
select hex(a) from t1 order by a;
select hex(concat(a,'\0')) as b from t1 order by concat(a,'\0');
alter table t1 modify a varbinary(5);
alter table t1 modify a char(5);
alter table t1 modify a binary(5);
drop table t1;
CREATE TABLE t (c TEXT CHARSET ASCII);
INSERT INTO t (c) VALUES (REPEAT('3',65535));
SELECT LENGTH(c), CHAR_LENGTH(c) FROM t;
DROP TABLE t;
drop table if exists b15776;
create table b15776 (data blob(2147483647));
drop table b15776;
create table b15776 (data blob(2147483648));
drop table b15776;
create table b15776 (data blob(4294967294));
drop table b15776;
create table b15776 (data blob(4294967295));
drop table b15776;
CREATE TABLE b15776 (a blob(2147483647), b blob(2147483648), c blob(4294967295), a1 text(2147483647), b1 text(2147483648), c1 text(4294967295) );
drop table b15776;
CREATE TABLE b15776 (a int(0));
INSERT INTO b15776 values (NULL), (1), (42), (654);
SELECT * from b15776 ORDER BY a;
DROP TABLE b15776;
CREATE TABLE b15776 (a int(255));
DROP TABLE b15776;
CREATE TABLE b15776 (a year(4));
INSERT INTO b15776 VALUES (42);
SELECT * FROM b15776;
DROP TABLE b15776;
CREATE TABLE t1(id INT NOT NULL);
CREATE TABLE t2(id INT NOT NULL, c TEXT NOT NULL);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, '');
SELECT LENGTH(c) FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1(a CHAR(1));
INSERT INTO t1 VALUES ('0'), ('0');
DROP TABLE t1;
CREATE TABLE tab(c1 int NOT NULL PRIMARY KEY,c2 POINT NOT NULL,
                 c3 LINESTRING NOT NULL,c4 POLYGON NOT NULL,
                 c5 GEOMETRY NOT NULL);
INSERT INTO tab(c1,c2,c3,c4,c5)
VALUES(1,ST_GeomFromText('POINT(10 10)'),
       ST_GeomFromText('LINESTRING(5 5,20 20,30 30)'),
       ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))'),
       ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))'));
INSERT INTO tab(c1,c2,c3,c4,c5)
VALUES(2,ST_GeomFromText('POINT(20 20)'),
       ST_GeomFromText('LINESTRING(20 20,30 30,40 40)'),
       ST_GeomFromText('POLYGON((40 50,40 70,50 100,70 100,80 80,70 50,40 50))'),
       ST_GeomFromText('POLYGON((40 50,40 70,50 100,70 100,80 80,70 50,40 50))'));
SELECT c1,ST_Astext(c4) FROM tab WHERE
  c4=ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
drop table tab;
select @g1 < @g2;
select @g1 = @g2;
select @g1 > @g2;
select @g1 + @g2;
select @g1=ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 = ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 != ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select crc32(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select @g1=@g2;
select @g1 < @g2;
select @g1 = @g2;
select @g1 > @g2;
select @g1 > @g3;
CREATE TABLE t1(a LONGBLOB NOT NULL) engine=innodb default charset=latin1;
INSERT INTO t1 VALUES (''),(''),(''),('');
CREATE TABLE t2 (b LONGTEXT) engine=innodb default charset=latin1;
INSERT INTO t2 VALUES ('a');
SELECT ( SELECT ( b <> 1 ) FROM t2) <> ALL(SELECT 1681007452 FROM t1) FROM t1;
SELECT ( SELECT ( b <> 1 ) FROM t2) <> ALL(SELECT 1681007452 FROM t1) FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (c1 INTEGER PRIMARY KEY, c2 TEXT, c3 INTEGER);
INSERT INTO t1(c1) VALUES(0);
INSERT INTO t1(c1) VALUES(0) ON DUPLICATE KEY
UPDATE c2 = VALUES(c2), c3 = NULL;
SELECT * FROM t1;
DROP TABLE t1;
