drop table if exists t1,t2,t3,t4,t5,t6;
drop database if exists mysqltest;
CREATE TABLE t1 (a varchar(30) binary NOT NULL DEFAULT ' ',
                 b varchar(1) binary NOT NULL DEFAULT ' ',
		 c varchar(4) binary NOT NULL DEFAULT '0000',
		 d tinyblob NULL,
		 e tinyblob NULL,
		 f tinyblob NULL,
		 g tinyblob NULL,
		 h tinyblob NULL,
		 i tinyblob NULL,
		 j tinyblob NULL,
		 k tinyblob NULL,
		 l tinyblob NULL,
		 m tinyblob NULL,
		 n tinyblob NULL,
		 o tinyblob NULL,
		 p tinyblob NULL,
                 q varchar(30) binary NOT NULL DEFAULT ' ',
                 r varchar(30) binary NOT NULL DEFAULT ' ',
		 s tinyblob NULL,
                 t varchar(4) binary NOT NULL DEFAULT ' ',
                 u varchar(1) binary NOT NULL DEFAULT ' ',
                 v varchar(30) binary NOT NULL DEFAULT ' ',
                 w varchar(30) binary NOT NULL DEFAULT ' ',
		 x tinyblob NULL,
                 y varchar(5) binary NOT NULL DEFAULT ' ',
                 z varchar(20) binary NOT NULL DEFAULT ' ',
                 a1 varchar(30) binary NOT NULL DEFAULT ' ',
		 b1 tinyblob NULL)
ENGINE=InnoDB DEFAULT CHARACTER SET = latin1 COLLATE latin1_bin;
INSERT into t1 (b) values ('1');
SELECT * from t1;
CREATE TABLE t2 (a varchar(30) binary NOT NULL DEFAULT ' ',
                 b varchar(1) binary NOT NULL DEFAULT ' ',
		 c varchar(4) binary NOT NULL DEFAULT '0000',
		 d tinyblob NULL,
		 e tinyblob NULL,
		 f tinyblob NULL,
		 g tinyblob NULL,
		 h tinyblob NULL,
		 i tinyblob NULL,
		 j tinyblob NULL,
		 k tinyblob NULL,
		 l tinyblob NULL,
		 m tinyblob NULL,
		 n tinyblob NULL,
		 o tinyblob NULL,
		 p tinyblob NULL,
                 q varchar(30) binary NOT NULL DEFAULT ' ',
                 r varchar(30) binary NOT NULL DEFAULT ' ',
		 s tinyblob NULL,
                 t varchar(4) binary NOT NULL DEFAULT ' ',
                 u varchar(1) binary NOT NULL DEFAULT ' ',
                 v varchar(30) binary NOT NULL DEFAULT ' ',
                 w varchar(30) binary NOT NULL DEFAULT ' ',
		 x tinyblob NULL,
                 y varchar(5) binary NOT NULL DEFAULT ' ',
                 z varchar(20) binary NOT NULL DEFAULT ' ',
                 a1 varchar(30) binary NOT NULL DEFAULT ' ',
		 b1 tinyblob NULL)
DEFAULT CHARACTER SET = latin1 COLLATE latin1_bin;
INSERT into t2 (b) values ('1');
SELECT * from t2;
drop table t1;
drop table t2;
create table bug20691 (
  a set('one', 'two', 'three') not null,
  b enum('small', 'medium', 'large', 'enormous', 'ellisonego') not null,
  c time not null,
  d date not null,
  e int not null,
  f long not null,
  g blob not null,
  h datetime not null,
  i decimal not null,
  x int);
insert into bug20691 values (2, 3, 5, '0007-01-01', 11, 13, 17, '0019-01-01 00:00:00', 23, 1);
insert into bug20691 values (2, 3, 5, '0007-01-01', 11, 13, 17, '0019-01-01 00:00:00', 23, 3);
select * from bug20691 order by x asc;
drop table bug20691;
create table t1 (id int not null);
create view v1 (c) as select id from t1;
drop view v1;
drop table t1;
create table t1 (a int unique);
create table t2 (b int default 10);
insert into t1 (a) values (1);
insert into t2 (b) values (1);
insert into t1 (a) select b from t2 on duplicate key update a=default;
select * from t1;
insert into t1 (a) values (1);
insert into t1 (a) select b from t2 on duplicate key update a=default(b);
select * from t1;
drop table t1, t2;
CREATE TABLE t1 (f1 BINARY(6)  NOT NULL DEFAULT 0x414243FAFA00,
                 f2 VARCHAR(6) CHARACTER SET ujis DEFAULT 0xA4A2,
                 f3 BIT(4) DEFAULT b'1101');
SELECT data_type,character_set_name,
       column_default
  FROM information_schema.columns
 WHERE table_name='t1'
   AND column_name='f1';
SELECT data_type,
       character_set_name,HEX(CONVERT(column_default USING ujis)),
       column_default
  FROM information_schema.columns
 WHERE table_name='t1'
   AND column_name='f2';
SELECT data_type,
       character_set_name,
       column_default
  FROM information_schema.columns
 WHERE table_name='t1'
   AND column_name='f3';
INSERT INTO t1 VALUES(DEFAULT,DEFAULT,DEFAULT);
SELECT "--base--";
SELECT HEX(f1),HEX(f2),HEX(f3) FROM t1;
DROP TABLE t1;
SELECT "--base,dump--";
SELECT "--base,dump,pump--";
