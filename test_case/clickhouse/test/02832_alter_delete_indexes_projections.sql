select count() from t_delete_skip_index where y in (4, 5);
alter table t_delete_skip_index delete where x < 8192;
drop table if exists t_delete_skip_index;
drop table if exists t_delete_projection;
create table t_delete_projection (x UInt32, y UInt64, projection p (select sum(y))) engine = MergeTree order by tuple() SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into t_delete_projection select number, toString(number) from numbers(8192 * 10);
select sum(y) from t_delete_projection settings optimize_use_projections = 0;
alter table t_delete_projection delete where x < 8192;
drop table if exists t_delete_projection;
