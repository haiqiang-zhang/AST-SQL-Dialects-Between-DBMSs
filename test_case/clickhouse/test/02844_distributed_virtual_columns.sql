drop table if exists data_01072;
drop table if exists dist_01072;
create table data_01072 (key Int) Engine=MergeTree() ORDER BY key;
