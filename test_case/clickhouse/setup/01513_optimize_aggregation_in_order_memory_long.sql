drop table if exists data_01513;
create table data_01513 (key String) engine=MergeTree() order by key;
insert into data_01513 select number%10e3 from numbers(2e6);