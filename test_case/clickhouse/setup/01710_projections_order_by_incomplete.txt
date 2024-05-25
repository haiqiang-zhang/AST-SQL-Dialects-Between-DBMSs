drop table if exists  data_proj_order_by_incomp;
create table data_proj_order_by_incomp (t UInt64) ENGINE MergeTree() order by tuple();
