
--
-- This test should fail as MyISAM doesn't have rollback
--

--disable_warnings
drop table if exists t1;

create table t1 (n int not null primary key) engine=myisam;
insert into t1 values (4);
insert into t1 values (5);
select @@warning_count,@@error_count;
select * from t1;
select @@warning_count;
drop table t1;
