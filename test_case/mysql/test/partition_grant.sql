drop schema if exists mysqltest_1;


--
-- Bug #17139: ALTER TABLE ... DROP PARTITION should require DROP privilege
--

create schema mysqltest_1;
use mysqltest_1;

create table t1 (a int) partition by list (a) (partition p1 values in (1), partition p2 values in (2), partition p3 values in (3));
insert into t1 values (1),(2);

-- We don't have DROP USER IF EXISTS. Use this workaround to
-- cleanup possible grants for mysqltest_1 left by previous tests
-- and ensure consistent results of SHOW GRANTS command below.
--disable_warnings
create user mysqltest_1@localhost;
alter table t1 add b int;
alter table t1 drop partition p2;
alter table t1 drop partition p2;
alter table t1 drop partition p3;
drop table t1;

--
-- Bug #23675 Partitions: possible security breach via alter 
--

create table t1 (s1 int);
insert into t1 values (1);
alter table t1 partition by list (s1) (partition p1 values in (2));
alter table t1 partition by list (s1) (partition p1 values in (2));
drop table t1;

drop user mysqltest_1@localhost;
drop schema mysqltest_1;
