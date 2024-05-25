drop table if exists test;
create table test(a UInt64, m UInt64, d DateTime) engine MergeTree partition by toYYYYMM(d) order by (a, m, d) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into test select number, number, '2022-01-01 00:00:00' from numbers(1000000);
