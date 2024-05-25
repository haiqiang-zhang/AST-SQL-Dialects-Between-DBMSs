SET allow_experimental_analyzer = 1;
EXPLAIN QUERY TREE passes=1
WITH merged_test AS(
	SELECT * FROM  t Final
)
SELECT * FROM  merged_test;
WITH merged_test AS(
	SELECT * FROM  t Final
)
SELECT * FROM  merged_test;
DROP TABLE t;
