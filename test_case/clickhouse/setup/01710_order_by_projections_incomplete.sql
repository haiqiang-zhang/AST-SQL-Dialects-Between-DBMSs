drop table if exists  data_order_by_proj_incomp;
create table data_order_by_proj_incomp (t UInt64) ENGINE MergeTree() order by t;
