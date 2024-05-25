-- Test from the issue https://github.com/ClickHouse/ClickHouse/issues/2610
drop table if exists data_01227;
create table data_01227 (key Int) Engine=MergeTree() order by key;
insert into data_01227 select * from numbers(10);
drop table data_01227;
