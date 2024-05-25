drop table if exists data_02177;
create table data_02177 (key Int) Engine=MergeTree() order by key;
insert into data_02177 values (1);
set optimize_aggregation_in_order=1;
drop table data_02177;
