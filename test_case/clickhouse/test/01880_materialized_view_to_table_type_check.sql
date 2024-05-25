select '----------test--------:';
select * from test;
create MATERIALIZED VIEW test_mv to test(`id` Int32, `pv` AggregateFunction(sum, Int32)) as SELECT id, sumState(toInt32(1)) as pv from test_input group by id;
INSERT INTO test_input SELECT toInt32(number % 1000) AS id FROM numbers(100,3);
select '----------test--------:';
DROP TABLE test_mv;
DROP TABLE test;
DROP TABLE test_input;
