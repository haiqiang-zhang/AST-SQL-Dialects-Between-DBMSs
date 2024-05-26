drop table if exists m3;
drop table if exists replacing_m3;
set allow_experimental_analyzer=1;
set optimize_trivial_count_query=1;
create table m3(a Int64, b UInt64) Engine=MergeTree order by tuple();
