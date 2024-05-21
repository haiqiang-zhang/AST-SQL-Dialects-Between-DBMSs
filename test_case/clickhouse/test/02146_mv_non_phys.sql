drop table if exists mv_02146;
create materialized view mv_02146 engine=MergeTree() order by number as select * from numbers(10);