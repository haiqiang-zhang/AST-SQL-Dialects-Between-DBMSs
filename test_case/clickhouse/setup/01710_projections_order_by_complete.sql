drop table if exists  data_proj_order_by_comp;
create table data_proj_order_by_comp (t UInt64, projection tSort (select * order by t)) ENGINE MergeTree() order by tuple();
