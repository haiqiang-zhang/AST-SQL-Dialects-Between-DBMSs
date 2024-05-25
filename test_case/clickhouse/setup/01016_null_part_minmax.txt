drop table if exists null_01016;
create table if not exists null_01016 (x Nullable(String)) engine MergeTree order by ifNull(x, 'order-null') partition by ifNull(x, 'partition-null');
insert into null_01016 values (null);
drop table null_01016;
