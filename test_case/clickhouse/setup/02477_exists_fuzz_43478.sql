create table test_rows_compact_part__fuzz_11 (x UInt32) engine = MergeTree order by x;
insert into test_rows_compact_part__fuzz_11 select 1;
