drop table if exists nullable_set_index;
create table nullable_set_index (a UInt64, b Nullable(String), INDEX b_index b TYPE set(0) GRANULARITY 8192) engine = MergeTree order by a;
insert into nullable_set_index values (1, 'a');
insert into nullable_set_index values (2, 'b');
