SELECT PARTITION_NAME,TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 't1';
SELECT * FROM t1 WHERE department = 'dep2' and country = 'Croatia';
SELECT * FROM t1 WHERE department = 'dep1' and country = 'Croatia';
DROP TABLE t1;
create table t1 (a varchar(5) character set ucs2 collate ucs2_bin)
partition by range columns (a)
(partition p0 values less than (0x0041));
insert into t1 values (0x00410000);
select hex(a) from t1 where a like 'A_';
alter table t1 remove partitioning;
create index a on t1 (a);
insert into t1 values ('A_');
drop table t1;
create table t1 (a varchar(1) character set latin1 collate latin1_general_ci)
partition by range columns(a)
( partition p0 values less than ('a'),
  partition p1 values less than ('b'),
  partition p2 values less than ('c'),
  partition p3 values less than ('d'));
insert into t1 values ('A'),('a'),('B'),('b'),('C'),('c');
alter table t1 remove partitioning;
drop table t1;
create table t1 (a varchar(2) character set latin1,
                 b varchar(2) character set latin1)
partition by list columns(a,b)
(partition p0 values in (('a','a')));
insert into t1 values ('A','A');
alter table t1 remove partitioning;
drop table t1;
create table t1 (a varchar(5))
partition by list columns(a)
( partition p0 values in ('\''),
  partition p1 values in ('\\'),
  partition p2 values in ('\0'));
drop table t1;
create table t1 (a int, b char(10), c varchar(25), d datetime)
partition by range columns(a,b,c,d)
subpartition by hash (to_seconds(d))
subpartitions 4
( partition p0 values less than (1, '0', MAXVALUE, '1900-01-01'),
  partition p1 values less than (1, 'a', MAXVALUE, '1999-01-01'),
  partition p2 values less than (1, 'b', MAXVALUE, MAXVALUE),
  partition p3 values less than (1, MAXVALUE, MAXVALUE, MAXVALUE));
select partition_method, partition_expression, partition_description
  from information_schema.partitions where table_name = "t1";
drop table t1;
create table t1 (a int, b int)
partition by list columns (a,b)
( partition p0 values in ((0,0)));
drop table t1;
create table t1 (a int signed)
partition by list (a)
( partition p0 values in (1, 3, 5, 7, 9, NULL),
  partition p1 values in (2, 4, 6, 8, 0));
insert into t1 values (NULL),(0),(1),(2),(2),(4),(4),(4),(8),(8);
select * from t1 where NULL <= a;
select * from t1 where a is null;
select * from t1 where a <= 1;
drop table t1;
create table t1 (a int signed)
partition by list columns(a)
( partition p0 values in (1, 3, 5, 7, 9, NULL),
  partition p1 values in (2, 4, 6, 8, 0));
insert into t1 values (NULL),(0),(1),(2),(2),(4),(4),(4),(8),(8);
select * from t1 where a <= NULL;
select * from t1 where a is null;
select * from t1 where a <= 1;
drop table t1;
create table t1 (a int, b int)
partition by list columns(a,b)
( partition p0 values in ((1, NULL), (2, NULL), (NULL, NULL)),
  partition p1 values in ((1,1), (2,2)),
  partition p2 values in ((3, NULL), (NULL, 1)));
select partition_method, partition_expression, partition_description
  from information_schema.partitions where table_name = "t1";
insert into t1 values (3, NULL);
insert into t1 values (NULL, 1);
insert into t1 values (NULL, NULL);
insert into t1 values (1, NULL);
insert into t1 values (2, NULL);
insert into t1 values (1,1);
insert into t1 values (2,2);
select * from t1 where a = 1;
select * from t1 where a = 2;
select * from t1 where a > 8;
select * from t1 where a not between 8 and 8;
drop table t1;
create table t1 (a int)
partition by list (a)
( partition p0 values in (2, 1),
  partition p1 values in (4, NULL, 3));
select partition_method, partition_expression, partition_description
  from information_schema.partitions where table_name = "t1";
insert into t1 values (1);
insert into t1 values (2);
insert into t1 values (3);
insert into t1 values (4);
insert into t1 values (NULL);
drop table t1;
create table t1 (a int)
partition by list columns(a)
( partition p0 values in (2, 1),
  partition p1 values in (4, NULL, 3));
select partition_method, partition_expression, partition_description
 from information_schema.partitions where table_name = "t1";
insert into t1 values (1);
insert into t1 values (2);
insert into t1 values (3);
insert into t1 values (4);
insert into t1 values (NULL);
drop table t1;
create table t1 (a int, b char(10), c varchar(5), d int)
partition by range columns(a,b,c)
subpartition by key (c,d)
subpartitions 3
( partition p0 values less than (1,'abc','abc'),
  partition p1 values less than (2,'abc','abc'),
  partition p2 values less than (3,'abc','abc'),
  partition p3 values less than (4,'abc','abc'));
select partition_method, partition_expression, partition_description
  from information_schema.partitions where table_name = "t1";
insert into t1 values (1,'a','b',1),(2,'a','b',2),(3,'a','b',3);
insert into t1 values (1,'b','c',1),(2,'b','c',2),(3,'b','c',3);
insert into t1 values (1,'c','d',1),(2,'c','d',2),(3,'c','d',3);
insert into t1 values (1,'d','e',1),(2,'d','e',2),(3,'d','e',3);
select * from t1 where (a = 1 AND b < 'd' AND (c = 'b' OR (c = 'c' AND d = 1)) OR
                       (a = 1 AND b >= 'a' AND (c = 'c' OR (c = 'd' AND d = 2))));
drop table t1;
create table t1 (a int, b varchar(2), c int)
partition by range columns (a, b, c)
(partition p0 values less than (1, 'A', 1),
 partition p1 values less than (1, 'B', 1));
select partition_method, partition_expression, partition_description
  from information_schema.partitions where table_name = "t1";
insert into t1 values (1, 'A', 1);
select * from t1 where a = 1 AND b <= 'A' and c = 1;
drop table t1;
create table t1 (a char, b char, c char)
partition by list columns(a)
( partition p0 values in ('a'));
insert into t1 (a) values ('a');
select * from t1 where a = 'a';
drop table t1;
create table t1 (a int, b int)
partition by range columns(a,b)
(partition p0 values less than (maxvalue, 10));
drop table t1;
create table t1 (d date)
partition by range columns(d)
( partition p0 values less than ('2000-01-01'),
  partition p1 values less than ('2009-01-01'));
drop table t1;
create table t1 (d date)
partition by range columns(d)
( partition p0 values less than ('1999-01-01'),
  partition p1 values less than ('2000-01-01'));
drop table t1;
create table t1 (d date)
partition by range columns(d)
( partition p0 values less than ('2000-01-01'),
  partition p1 values less than ('3000-01-01'));
drop table t1;
create table t1 (a int, b int)
partition by range columns(a,b)
(partition p2 values less than (99,99),
 partition p1 values less than (99,999));
insert into t1 values (99,998);
select * from t1 where b = 998;
drop table t1;
create table t1 as select to_seconds(null) as to_seconds;
select data_type from information_schema.columns
where column_name='to_seconds';
drop table t1;
create table t1 (a int, b int)
partition by range columns(a,b)
(partition p0 values less than (maxvalue,maxvalue));
drop table t1;
create table t1 (a int)
partition by list columns(a)
(partition p0 values in (0));
select partition_method from information_schema.partitions where table_name='t1';
drop table t1;
create table t1 (a char(6))
partition by range columns(a)
(partition p0 values less than ('H23456'),
 partition p1 values less than ('M23456'));
insert into t1 values ('F23456');
select * from t1;
drop table t1;
create table t1 (a int, b int)
partition by range columns(a,b)
(partition p0 values less than (1, 0),
 partition p1 values less than (2, maxvalue),
 partition p2 values less than (3, 3),
 partition p3 values less than (10, maxvalue));
insert into t1 values (0,1),(1,1),(2,1),(3,1),(3,4),(4,9),(9,1);
select * from t1;
alter table t1
partition by range columns(b,a)
(partition p0 values less than (1,2),
 partition p1 values less than (3,3),
 partition p2 values less than (9,5));
select * from t1 where b < 2;
select * from t1 where b < 4;
alter table t1 reorganize partition p1 into
(partition p11 values less than (2,2),
 partition p12 values less than (3,3));
alter table t1 reorganize partition p2 into
(partition p21 values less than (4,7),
 partition p22 values less than (9,5));
select * from t1 where b < 4;
drop table t1;
create table t1 (a int, b int)
partition by list columns(a,b)
subpartition by hash (b)
subpartitions 2
(partition p0 values in ((0,0), (1,1)),
 partition p1 values in ((1000,1000)));
insert into t1 values (1000,1000);
drop table t1;
create table t1 (a char, b char, c char)
partition by range columns(a,b,c)
( partition p0 values less than ('a','b','c'));
alter table t1 add partition
(partition p1 values less than ('b','c','d'));
drop table t1;
