set allow_deprecated_syntax_for_merge_tree=1;
create materialized view test_mv_00609 uuid '00000609-1000-4000-8000-000000000001' Engine=MergeTree(date, (a), 8192) populate as select a, toDate('2000-01-01') date from test_00609;
select * from test_mv_00609;
select * from test_mv_00609 where a in (select a from test_mv_00609);
select * from ".inner_id.00000609-1000-4000-8000-000000000001" where a in (select a from test_mv_00609);
DROP TABLE test_00609;
DROP TABLE test_mv_00609;
