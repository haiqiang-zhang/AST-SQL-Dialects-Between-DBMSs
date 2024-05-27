drop table if exists tab;
create table tab (a LowCardinality(String), b LowCardinality(String)) engine = MergeTree partition by a order by tuple() settings min_bytes_for_wide_part = 0, min_rows_for_wide_part = 0;
insert into tab values ('1', 'a'), ('2', 'b');