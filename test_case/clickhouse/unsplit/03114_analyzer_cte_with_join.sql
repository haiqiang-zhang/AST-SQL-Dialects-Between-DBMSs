-- https://github.com/ClickHouse/ClickHouse/issues/58500

SET allow_experimental_analyzer=1;
drop table if exists t;
create table t  (ID UInt8) Engine= Memory();
insert into t values(1),(2),(3);
drop table if exists t;
