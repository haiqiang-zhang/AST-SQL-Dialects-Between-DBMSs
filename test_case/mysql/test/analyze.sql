--

create table t1 (a bigint);
insert into t1 values(0);

drop table t1;

create table t1 (a bigint);
insert into t1 values(0);
delete from t1;

drop table t1;

create table t1 (a bigint);
insert into t1 values(0);

drop table t1;

-- Bug #14902 ANALYZE TABLE fails to recognize up-to-date tables
-- minimal test case to get an error.
-- The problem is happening when analysing table with FT index that
-- contains stopwords only. The first execution of analyze table should
-- mark index statistics as up to date so that next execution of this
-- statement will end up with Table is up to date status.
create table t1 (a mediumtext, fulltext key key1(a)) charset utf8mb3 COLLATE utf8mb3_general_ci;
insert into t1 values ('hello');

drop table t1;

--
-- bug#15225 (ANALYZE temporary has no effect)
--
create temporary table t1(a int, index(a));
insert into t1 values('1'),('2'),('3'),('4'),('5');
drop table t1;

--
-- Bug #30495: optimize table t1,t2,t3 extended errors
--
create table t1(a int);
drop table t1;
CREATE PROCEDURE p() ANALYZE TABLE v UPDATE HISTOGRAM ON w;
DROP PROCEDURE p;
