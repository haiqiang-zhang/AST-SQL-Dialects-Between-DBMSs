select * from test_mv_00609;
select * from test_mv_00609 where a in (select a from test_mv_00609);
select * from ".inner_id.00000609-1000-4000-8000-000000000001" where a in (select a from test_mv_00609);
DROP TABLE test_00609;
DROP TABLE test_mv_00609;
