select null,isnull(null),isnull(1/0),isnull(1/0 = null),ifnull(null,1),ifnull(null,"TRUE"),ifnull("TRUE","ERROR"),1/0 is null,1 is not null;
select 1 | NULL,1 & NULL,1+NULL,1-NULL;
select NULL=NULL,NULL<>NULL,IFNULL(NULL,1.1)+0,IFNULL(NULL,1) | 0;
select strcmp("a",NULL),(1<NULL)+0.0,NULL regexp "a",null like "a%","a%" like null;
select concat("a",NULL),replace(NULL,"a","b"),replace("string","i",NULL),replace("string",NULL,"i"),insert("abc",1,1,NULL),left(NULL,1);
select repeat("a",0),repeat("ab",5+5),repeat("ab",-1),reverse(NULL);
select field(NULL,"a","b","c");
select 2 between null and 1,2 between 3 AND NULL,NULL between 1 and 2,2 between NULL and 3, 2 between 1 AND null;
SELECT NULL AND NULL, 1 AND NULL, NULL AND 1, NULL OR NULL, 0 OR NULL, NULL OR 0;
SELECT (NULL OR NULL) IS NULL;
select NULL AND 0, 0 and NULL;
select inet_ntoa(null),inet_aton(null);
select inet6_ntoa(null),inet6_aton(null);
create table t1 (x int);
insert into t1 values (null);
select * from t1 where x != 0;
drop table t1;
CREATE TABLE t1 (
  indexed_field int default NULL,
  KEY indexed_field (indexed_field)
);
INSERT INTO t1 VALUES (NULL),(NULL);
SELECT * FROM t1 WHERE indexed_field=NULL;
SELECT * FROM t1 WHERE indexed_field IS NULL;
SELECT * FROM t1 WHERE indexed_field<=>NULL;
DROP TABLE t1;
create table t1 (a int, b int);
insert into t1 values(20,null);
select t2.b, ifnull(t2.b,"this is null") from t1 as t2 left join t1 as t3 on
t2.b=t3.a;
insert into t1 values(10,null);
drop table t1;
create table t1 (a int not null, b int not null, index idx(a));
insert into t1 values
  (1,1), (2,2), (3,3), (4,4), (5,5), (6,6),
  (7,7), (8,8), (9,9), (10,10), (11,11), (12,12);
drop table t1;
select cast(NULL as signed);
create table t1(i int, key(i));
insert into t1 values(1);
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 select i*2 from t1;
insert into t1 values(null);
select count(*) from t1 where i=2 or i is null;
drop table t1;
create table t1 select
  null as c00,
  if(1, null, 'string') as c01,
  if(0, null, 'string') as c02,
  ifnull(null, 'string') as c03,
  ifnull('string', null) as c04,
  case when 0 then null else 'string' end as c05,
  case when 1 then null else 'string' end as c06,
  coalesce(null, 'string') as c07,
  coalesce('string', null) as c08,
  least('string',null) as c09,
  least(null, 'string') as c10,
  greatest('string',null) as c11,
  greatest(null, 'string') as c12,
  nullif('string', null) as c13,
  nullif(null, 'string') as c14,
  trim('string' from null) as c15,
  trim(null from 'string') as c16,
  substring_index('string', null, 1) as c17,
  substring_index(null, 'string', 1) as c18,
  elt(1, null, 'string') as c19,
  elt(1, 'string', null) as c20,
  concat('string', null) as c21,
  concat(null, 'string') as c22,
  concat_ws('sep', 'string', null) as c23,
  concat_ws('sep', null, 'string') as c24,
  concat_ws(null, 'string', 'string') as c25,
  make_set(3, 'string', null) as c26,
  make_set(3, null, 'string') as c27,
  export_set(3, null, 'off', 'sep') as c29,
  export_set(3, 'on', null, 'sep') as c30,
  export_set(3, 'on', 'off', null) as c31,
  replace(null, 'from', 'to') as c32,
  replace('str', null, 'to') as c33,
  replace('str', 'from', null) as c34,
  insert('str', 1, 2, null) as c35,
  insert(null, 1, 2, 'str') as c36,
  lpad('str', 10, null) as c37,
  rpad(null, 10, 'str') as c38;
drop table t1;
select 
  case 'str' when 'STR' then 'str' when null then 'null' end as c01,
  case 'str' when null then 'null' when 'STR' then 'str' end as c02,
  field(null, 'str1', 'str2') as c03,
  field('str1','STR1', null) as c04,
  field('str1', null, 'STR1') as c05,
  'string' in ('STRING', null) as c08,
  'string' in (null, 'STRING') as c09;
create table bug19145a (e enum('a','b','c')          default 'b' , s set('x', 'y', 'z')          default 'y' );
create table bug19145b (e enum('a','b','c')          default null, s set('x', 'y', 'z')          default null);
create table bug19145c (e enum('a','b','c') not null default 'b' , s set('x', 'y', 'z') not null default 'y' );
alter table bug19145a alter column e set default null;
alter table bug19145a alter column s set default null;
alter table bug19145a add column (i int);
alter table bug19145b alter column e set default null;
alter table bug19145b alter column s set default null;
alter table bug19145b add column (i int);
alter table bug19145c add column (i int);
drop table bug19145a;
drop table bug19145b;
drop table bug19145c;
CREATE TABLE t1 (a DECIMAL (1, 0) ZEROFILL, b DECIMAL (1, 0) ZEROFILL);
INSERT INTO t1 (a, b) VALUES (0, 0);
CREATE TABLE t2 SELECT IFNULL(a, b) FROM t1;
DROP TABLE t2;
CREATE TABLE t2 SELECT IFNULL(a, NULL) FROM t1;
DROP TABLE t2;
CREATE TABLE t2 SELECT IFNULL(NULL, b) FROM t1;
DROP TABLE t1, t2;
create table t1 (
  pk int primary key,
  col_int_unique int,
  c char(255) not null default 'xxxx'
) engine = innoDb;
create unique index ix1 ON t1(col_int_unique);
insert into t1(pk,col_int_unique) values (1,1), (2,NULL);
insert into t1(pk,col_int_unique) values (3,3), (4,4), (5,5), (6,6), (7,7), (8,8);
SELECT STRAIGHT_JOIN *
 FROM t1 LEFT OUTER JOIN t1 AS t2
    ON t1.col_int_unique = t2.col_int_unique;
SELECT STRAIGHT_JOIN *
 FROM t1 LEFT OUTER JOIN t1 AS t2
    ON t1.col_int_unique = t2.col_int_unique;
SELECT STRAIGHT_JOIN *
 FROM t1 JOIN t1 AS t2
    ON t1.col_int_unique = t2.col_int_unique
 WHERE t1.pk = 2;
drop table t1;
SELECT NULL <=> (0 <=> NULL);
