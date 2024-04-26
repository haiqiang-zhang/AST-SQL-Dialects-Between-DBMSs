drop table if exists t1,t2,t3,t4,t5,t6,t7;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';

--
-- Check syntax for creating BLOB/TEXT
--
CREATE TABLE t1 (a blob, b text, c blob(250), d text(70000), e text(70000000));
CREATE TABLE t2 (a char(255), b varbinary(70000), c varchar(70000000));
CREATE TABLE t4 (c varchar(65530) character set utf8mb3 not null);
create table t3 (a long, b long byte);
drop table t1,t2,t3,t4;

--
-- Check errors with blob
--

--error 1074
CREATE TABLE t1 (a char(257) default "hello");
CREATE TABLE t2 (a char(256));
CREATE TABLE t1 (a varchar(70000) default "hello");
CREATE TABLE t2 (a blob default "hello");

-- Safety to be able to continue with other tests if above fails
--disable_warnings
drop table if exists t1,t2;

--
-- test of full join with blob
--

create table t1 (nr int(5) not null auto_increment,b blob,str char(10), primary key (nr));
insert into t1 values (null,"a","A");
insert into t1 values (null,"bbb","BBB");
insert into t1 values (null,"ccc","CCC");
select last_insert_id();
select * from t1,t1 as t2;

drop table t1;

--
-- Test of changing TEXT column
--

create table t1 (a text);
insert into t1 values ('where');
update t1 set a='Where';
select * from t1;
drop table t1;

--
-- test of blob, text, char and varbinary
--
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
set big_tables=1;
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
set big_tables=0;
select distinct * from t1;
select t,count(*) from t1 group by t;
select b,count(*) from t1 group by b;
select c,count(*) from t1 group by c;
select d,count(*) from t1 group by d;
drop table t1;

--
-- Test of join with blobs and min
--

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

CREATE TABLE t3 (
  t3_id bigint(21) NOT NULL auto_increment,
  _field_131 varchar(128),
  _field_133 tinyint(4) DEFAULT '0' NOT NULL,
  _field_135 datetime DEFAULT '0000-00-00 00:00:00' NOT NULL,
  _field_137 tinyint(4),
  _field_139 datetime DEFAULT '0000-00-00 00:00:00' NOT NULL,
  _field_140 blob,
  _field_142 tinyint(4) DEFAULT '0' NOT NULL,
  _field_145 tinyint(4) DEFAULT '0' NOT NULL,
  _field_148 tinyint(4) DEFAULT '0' NOT NULL,
  PRIMARY KEY (t3_id),
  KEY _field_133 (_field_133),
  KEY _field_135 (_field_135),
  KEY _field_139 (_field_139),
  KEY _field_142 (_field_142),
  KEY _field_145 (_field_145),
  KEY _field_148 (_field_148)
);


INSERT INTO t3 VALUES (1,'test job 1',0,'0000-00-00 00:00:00',0,'1999-02-25 22:43:32','test\r\njob\r\n1',0,0,0);
INSERT INTO t3 VALUES (2,'test job 2',0,'0000-00-00 00:00:00',0,'1999-02-26 21:08:04','',0,0,0);


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

select replace(t3._field_140, "\r","^M"),t3_id,min(t3._field_131), min(t3._field_135), min(t3._field_139), min(t3._field_137), min(link_alias_142._field_165), min(link_alias_133._field_72), min(t3._field_145), min(link_alias_148._field_156), replace(min(t3._field_140), "\r","^M"),t3.t3_id from t3 left join t4 on t4.seq_0_id = t3.t3_id left join t7 link_alias_142 on t4.seq_1_id = link_alias_142.t7_id left join t6 on t6.seq_0_id = t3.t3_id left join t1 link_alias_133 on t6.seq_1_id = link_alias_133.t1_id left join t2 on t2.seq_0_id = t3.t3_id left join t5 link_alias_148 on t2.seq_1_id = link_alias_148.t5_id where t3.t3_id in (1) group by t3.t3_id order by link_alias_142._field_166, _field_139, link_alias_133._field_72, _field_135, link_alias_148._field_156;
drop table t1,t2,t3,t4,t5,t6,t7;

--
-- Test of reverse with empty blob
--

create table t1 (a blob);
insert into t1 values ("empty"),("");
select a,reverse(a) from t1;
drop table t1;

--
-- Test of BLOB:s with NULL keys.
--

create table t1 (a blob, key (a(10)));
insert into t1 values ("bye"),("hello"),("hello"),("hello word");
select * from t1 where a like "hello%";
drop table t1;

--
-- Test of found bug in group on text key
--

CREATE TABLE t1 (
       f1 int(11) DEFAULT '0' NOT NULL,
       f2 varchar(16) DEFAULT '' NOT NULL,
       f5 text,
       KEY index_name (f1,f2,f5(16))
    );
INSERT INTO t1 VALUES (0,'traktor','1111111111111');
INSERT INTO t1 VALUES (1,'traktor','1111111111111111111111111');
select count(*) from t1 where f2='traktor';
drop table t1;

--
-- Test of found bug when blob is first key part
--

create table t1 (foobar tinyblob not null, boggle smallint not null, key (foobar(32), boggle));
insert into t1 values ('fish', 10),('bear', 20);
select foobar, boggle from t1 where foobar = 'fish';
select foobar, boggle from t1 where foobar = 'fish' and boggle = 10;
drop table t1;

--
-- Bug when blob is updated
--

create table t1 (id integer auto_increment unique,imagem LONGBLOB not null default '');
insert into t1 (id) values (1);
select if(imagem is null, "ERROR", "OK"),length(imagem) from t1 where id = 1;
drop table t1;
drop table t1;

--
-- Test blobs with end space (Bug #1651)
-- This is a bit changed since we now have true varchar
--

create table t1 (id integer primary key auto_increment, txt text not null, unique index txt_index (txt (20))) charset latin1;
insert into t1 (txt) values ('Chevy'), ('Chevy ');
insert into t1 (txt) values ('Chevy'), ('CHEVY');
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

-- End of 4.1 tests

--
-- Bug#11657: Creation of secondary index fails
--
create table t1 (a int, b int, c tinyblob, d int, e int);
alter table t1 add primary key (a,b,c(255),d);
alter table t1 add key (a,b,d,e);
drop table t1;

--
-- Test that blob's and varbinary are sorted according to length
--

CREATE table t1 (a blob);
insert into t1 values ('b'),('a\0'),('a'),('a '),('aa'),(NULL);
select hex(a) from t1 order by a;
select hex(concat(a,'\0')) as b from t1 order by concat(a,'\0');
alter table t1 modify a varbinary(5);
select hex(a) from t1 order by a;
select hex(concat(a,'\0')) as b from t1 order by concat(a,'\0');
alter table t1 modify a char(5);
select hex(a) from t1 order by a;
select hex(concat(a,'\0')) as b from t1 order by concat(a,'\0');
alter table t1 modify a binary(5);
select hex(a) from t1 order by a;
select hex(concat(a,'\0')) as b from t1 order by concat(a,'\0');
drop table t1;

--
-- Bug #19489: Inconsistent support for DEFAULT in TEXT columns
--
create table t1 (a text default '');
insert into t1 values (default);
select * from t1;
drop table t1;
set @@sql_mode='TRADITIONAL';
create table t1 (a text default '');
set @@sql_mode='';

--
-- Bug #32282: TEXT silently truncates when value is exactly 65536 bytes
--

CREATE TABLE t (c TEXT CHARSET ASCII);
INSERT INTO t (c) VALUES (REPEAT('1',65537));
INSERT INTO t (c) VALUES (REPEAT('2',65536));
INSERT INTO t (c) VALUES (REPEAT('3',65535));
SELECT LENGTH(c), CHAR_LENGTH(c) FROM t;
DROP TABLE t;
--   raise ER_TOO_BIG_FIELDLENGTH  (suggest using BLOB)
-- If size is too small:
--   raise ER_PARSE_ERROR
-- raise ER_TOO_BIG_DISPLAYWIDTH

-- BLOB and TEXT types
--disable_warnings
drop table if exists b15776;
create table b15776 (data blob(2147483647));
drop table b15776;
create table b15776 (data blob(-1));
create table b15776 (data blob(2147483648));
drop table b15776;
create table b15776 (data blob(4294967294));
drop table b15776;
create table b15776 (data blob(4294967295));
drop table b15776;
create table b15776 (data blob(4294967296));

CREATE TABLE b15776 (a blob(2147483647), b blob(2147483648), c blob(4294967295), a1 text(2147483647), b1 text(2147483648), c1 text(4294967295) );
drop table b15776;
CREATE TABLE b15776 (a blob(4294967296));
CREATE TABLE b15776 (a text(4294967296));
CREATE TABLE b15776 (a blob(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999));
CREATE TABLE b15776 (a text(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999));

-- Int types
-- "Another extension is supported by MySQL for optionally specifying the
-- display width of integer data types in parentheses following the base keyword
-- for the type (for example, INT(4)). This optional display width is used to
-- display integer values having a width less than the width specified for the
-- column by left-padding them with spaces."   § Numeric Types
CREATE TABLE b15776 (a int(0));
INSERT INTO b15776 values (NULL), (1), (42), (654);
SELECT * from b15776 ORDER BY a;
DROP TABLE b15776;
CREATE TABLE b15776 (a int(-1));
CREATE TABLE b15776 (a int(255));
DROP TABLE b15776;
CREATE TABLE b15776 (a int(256));
CREATE TABLE b15776 (data blob(-1));

-- Char types
-- Recommend BLOB
--error ER_TOO_BIG_FIELDLENGTH
CREATE TABLE b15776 (a char(2147483647));
CREATE TABLE b15776 (a char(2147483648));
CREATE TABLE b15776 (a char(4294967295));
CREATE TABLE b15776 (a char(4294967296));


-- Other numeric-ish types
--# For year, only support YEAR(4) or YEAR.
--error ER_INVALID_YEAR_COLUMN_LENGTH
CREATE TABLE b15776 (a year(4294967295));
CREATE TABLE b15776 (a year(4));
INSERT INTO b15776 VALUES (42);
SELECT * FROM b15776;
DROP TABLE b15776;
CREATE TABLE b15776 (a year(4294967296));
CREATE TABLE b15776 (a year(0));
CREATE TABLE b15776 (a year(-2));


-- We have already tested the case, but this should visually show that 
-- widths that are too large to be interpreted cause DISPLAYWIDTH errors.
--error ER_TOO_BIG_DISPLAYWIDTH
CREATE TABLE b15776 (a int(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999));
CREATE TABLE b15776 (a char(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999));
CREATE TABLE b15776 (a year(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999));

--# Do not select, too much memory needed.
--error ER_DATA_OUT_OF_RANGE
CREATE TABLE b15776 select cast(null as char(4294967295));
CREATE TABLE b15776 select cast(null as nchar(4294967295));

CREATE TABLE b15776 select cast(null as binary(4294967295));
drop table b15776;

--
-- Bug #33969: Updating a text field via a left join
--

CREATE TABLE t1(id INT NOT NULL);
CREATE TABLE t2(id INT NOT NULL, c TEXT NOT NULL);

INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, '');

UPDATE t2 SET c = REPEAT('1', 70000);
SELECT LENGTH(c) FROM t2;

UPDATE t1 LEFT JOIN t2 USING(id) SET t2.c = REPEAT('1', 70000) WHERE t1.id = 1;
SELECT LENGTH(c) FROM t2;

DROP TABLE t1, t2;

CREATE FUNCTION f1() RETURNS TINYBLOB RETURN 1;

CREATE TABLE t1(a CHAR(1));
INSERT INTO t1 VALUES ('0'), ('0');

SELECT COUNT(*) FROM t1 GROUP BY f1(), a;

DROP FUNCTION f1;
DROP TABLE t1;
SET sql_mode = default;
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

SET @g1 = ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
SELECT c1,ST_Astext(c4) FROM tab WHERE c4<@g1;
SELECT c1,ST_Astext(c4) FROM tab WHERE
  c4=ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
SELECT c1,ST_Astext(c4) FROM tab WHERE c4>@g1+3;
SELECT * FROM tab WHERE c2+4 > 5;
SELECT * FROM tab WHERE c3-4 > 5;
SELECT * FROM tab WHERE c4*4 > 5;
SELECT * FROM tab WHERE c5/4 > 5;
SELECT * FROM tab WHERE c3%4 > 5;
SELECT * FROM tab WHERE c3 DIV 4 > 5;

-- Aggregate functions.
select count(*) from tab;
select count(distinct c2) from tab;
select sum(c2) from tab;
select sum(distinct c2) from tab;
select avg(c2) from tab;
select avg(distinct c2) from tab;
select min(c2) from tab;
select max(c2) from tab;
select std(c2) from tab;


drop table tab;

set @g1 = 1;
set @g2 = 2;
select @g1 < @g2;
select @g1 = @g2;
select @g1 > @g2;
select @g1 + @g2;

SET @g1 = ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
SET @g2 = ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1=ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');

-- Numeric operators.
--error ER_WRONG_ARGUMENTS
select @g1+ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1-ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1*ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1/ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1%ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select 42 / ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)');
select 42 + ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)');
select -(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select @g1 > ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 >= ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 < ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 <= ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 = ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 != ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 between @g1 and ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select least(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'),
             ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select greatest(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'),
                ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));


-- Numeric functions.
--error ER_WRONG_ARGUMENTS
select abs(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select acos(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select asin(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select atan(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select atan2(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select ceil(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select ceiling(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select conv(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'), 2, 10);
select cos(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select cot(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select crc32(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select degrees(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select exp(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select floor(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select format(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'), 5);
select hex(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select ln(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select log(2, ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select log2(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select log10(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select mod(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'), 7);
select pow(2, ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select power(2, ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select radians(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select rand(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select round(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select sign(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select sin(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select sqrt(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select tan(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'));
select truncate(ST_GEOMFROMTEXT('LINESTRING(-1 -1, 1 -1, -1 -1, -1 1, 1 1)'),0);


-- should have failed with ER_WRONG_ARGUMENTS, but in current implementation
-- a variable's accurate field type is lost after it's assigned.
select @g1=@g2;

set @g1 = 'abc';
set @g2 = 'def';
select @g1 < @g2;
select @g1 = @g2;
select @g1 > @g2;

SET @g3 = ST_GeomFromText('POLYGON((30 30,40 40,50 50,30 50,30 40,30 30))');
select @g1 > @g3;

set sql_mode="";
CREATE TABLE t1(a LONGBLOB NOT NULL) engine=innodb default charset=latin1;
INSERT INTO t1 VALUES (''),(''),(''),('');
CREATE TABLE t2 (b LONGTEXT) engine=innodb default charset=latin1;
INSERT INTO t2 VALUES ('a');
SELECT ( SELECT ( b <> 1 ) FROM t2) <> ALL(SELECT 1681007452 FROM t1) FROM t1;
SELECT ( SELECT ( b <> 1 ) FROM t2) <> ALL(SELECT 1681007452 FROM t1) FROM t1;
DROP TABLE t1,t2;
set sql_mode=default;

CREATE TABLE t1 (c1 INTEGER PRIMARY KEY, c2 TEXT, c3 INTEGER);

INSERT INTO t1(c1) VALUES(0);

INSERT INTO t1(c1) VALUES(0) ON DUPLICATE KEY
UPDATE c2 = VALUES(c2), c3 = NULL;

SELECT * FROM t1;
DROP TABLE t1;
