show create table t_index;
select table, name, type, expr, granularity from system.data_skipping_indices where database = currentDatabase() and table = 't_index';
drop index i_a on t_index;
drop index if exists i_a on t_index;
select table, name, type, expr, granularity from system.data_skipping_indices where database = currentDatabase() and table = 't_index';
drop table t_index;
select table, name, type, expr, granularity from system.data_skipping_indices where database = currentDatabase() and table = 't_index';
select table, name, type, expr, granularity from system.data_skipping_indices where database = currentDatabase() and table = 't_index';
select table, name, type, expr, granularity from system.data_skipping_indices where database = currentDatabase() and table = 't_index_replica';
