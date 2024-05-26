LOCK TABLES t1 READ;
UNLOCK TABLES;
DROP TABLE t1;
drop tables if exists t1, t2;
create table t1 (i int);
create table t2 (j int);
drop tables t1, t2;
