SELECT if(1 = 0, toNullable(toUInt8(0)), NULL) AS x, toTypeName(x);
SELECT if(toUInt8(0), NULL, toNullable(toUInt8(0))) AS x, if(x = 0, 'ok', 'fail');
SELECT toTypeName(x), x, isNull(x), if(x = 0, 'fail', 'ok'), if(x = 1, 'fail', 'ok'), if(x >= 0, 'fail', 'ok')
FROM (SELECT CAST(NULL, 'Nullable(UInt8)') AS x);
SET join_use_nulls = 1;
DROP TABLE IF EXISTS test_nullable_float_issue7347;
CREATE TABLE test_nullable_float_issue7347 (ne UInt64,test Nullable(Float64)) ENGINE = MergeTree() PRIMARY KEY (ne) ORDER BY (ne);
INSERT INTO test_nullable_float_issue7347 VALUES (1,NULL);
SELECT test, toTypeName(test), IF(test = 0, 1, 0) FROM test_nullable_float_issue7347;
WITH materialize(CAST(NULL, 'Nullable(Float64)')) AS test SELECT test, toTypeName(test), IF(test = 0, 1, 0);
DROP TABLE test_nullable_float_issue7347;
