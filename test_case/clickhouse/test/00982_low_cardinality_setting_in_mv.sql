CREATE MATERIALIZED VIEW test_mv TO test2 AS SELECT toUInt64(a = 'test') FROM test1;
DROP TABLE test_mv;
DROP TABLE test1;
DROP TABLE test2;
