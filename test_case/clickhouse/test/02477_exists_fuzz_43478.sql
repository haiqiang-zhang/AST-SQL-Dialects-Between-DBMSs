select 1 from test_rows_compact_part__fuzz_11 where exists(select 1) settings allow_experimental_analyzer=1;
