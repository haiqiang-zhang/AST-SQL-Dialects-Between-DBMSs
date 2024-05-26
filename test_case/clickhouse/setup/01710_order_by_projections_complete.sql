drop table if exists  data_order_by_proj_comp;
create table data_order_by_proj_comp (t UInt64, projection tSort (select * order by t)) ENGINE MergeTree() order by t;
