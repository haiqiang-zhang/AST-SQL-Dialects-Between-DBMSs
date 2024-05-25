CREATE TEMPORARY TABLE test (`i` Int64, `d` DateTime);
SELECT * FROM test ORDER BY i;
DROP TABLE test;
CREATE TEMPORARY TABLE test (`i` Int64, `d` DateTime64);
SELECT * FROM test ORDER BY i;
DROP TABLE test;
