set mutations_sync = 2;
drop table if exists t_delete_skip_index;
create table t_delete_skip_index (x UInt32, y String, index i y type minmax granularity 3) engine = MergeTree order by tuple() SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into t_delete_skip_index select number, toString(number) from numbers(8192 * 10);
