drop table if exists lc_00906;
create table lc_00906 (b LowCardinality(String)) engine=MergeTree order by b SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
select count(), b from lc_00906 group by b;
drop table if exists lc_00906;
