drop table if exists t;
create table t engine=Log as select * from system.numbers limit 20;
set enable_optimize_predicate_expression=1;
