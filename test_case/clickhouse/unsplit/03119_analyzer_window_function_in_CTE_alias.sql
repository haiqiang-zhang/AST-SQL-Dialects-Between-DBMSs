SET allow_experimental_analyzer=1;
DROP TEMPORARY TABLE IF EXISTS test;
CREATE TEMPORARY TABLE test (a Float32, id UInt64);
INSERT INTO test VALUES (10,10),(20,20);
SELECT 'query1';


WITH avg(a) OVER () AS a SELECT a, id FROM test SETTINGS allow_experimental_window_functions = 1;
SELECT 'query2';
WITH avg(a) OVER () AS a2 SELECT a2, id FROM test SETTINGS allow_experimental_window_functions = 1;
SELECT 'query3';
SELECT avg(a) OVER () AS a, id FROM test SETTINGS allow_experimental_window_functions = 1;