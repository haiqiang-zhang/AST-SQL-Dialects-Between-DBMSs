drop table if exists t;
create table t (x UInt8, id UInt8) ENGINE = MergeTree() order by (id);
insert into t values (1, 1);
set enable_optimize_predicate_expression = 0;
