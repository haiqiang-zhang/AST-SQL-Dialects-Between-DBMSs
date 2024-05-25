SET optimize_move_to_prewhere = 0;
INSERT INTO test
SELECT number DIV 2, number
FROM numbers(3);
SELECT count() FROM test WHERE b >= 0;
DETACH TABLE test;
ATTACH TABLE test;
SELECT count() FROM test WHERE b >= 0;
DROP TABLE test;
