select count() from test where a = (select toUInt64(1) where 1 = 2) settings enable_early_constant_folding = 0, force_primary_key = 1;
drop table test;
drop table if exists test_null_filter;
create table test_null_filter(key UInt64, value UInt32) engine MergeTree order by key SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into test_null_filter select number, number from numbers(10000000);
drop table test_null_filter;
