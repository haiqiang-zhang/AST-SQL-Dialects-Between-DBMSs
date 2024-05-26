drop table if exists t_tuple_sparse;
create table t_tuple_sparse (a UInt64, b UInt64)
ENGINE = MergeTree ORDER BY tuple()
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.0;
insert into t_tuple_sparse values (0, 0);
