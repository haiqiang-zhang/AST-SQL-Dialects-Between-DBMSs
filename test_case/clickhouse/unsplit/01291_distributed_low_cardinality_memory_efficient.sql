DROP TABLE IF EXISTS data;
DROP TABLE IF EXISTS dist;
create table data (key String) Engine=Memory();
insert into data values ('foo');
set distributed_aggregation_memory_efficient=1;
set max_bytes_before_external_group_by = 0;
DROP TABLE data;
