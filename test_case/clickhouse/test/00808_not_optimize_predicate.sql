SELECT '-------ENABLE OPTIMIZE PREDICATE-------';
SELECT * FROM (SELECT * FROM test_00808 FINAL) WHERE id = 1;
SELECT * FROM (SELECT * FROM test_00808 ORDER BY id LIMIT 1) WHERE id = 1;
SELECT * FROM (SELECT id FROM test_00808 GROUP BY id LIMIT 1 BY id) WHERE id = 1;
SET force_primary_key = 1;
SELECT '-------FORCE PRIMARY KEY-------';
SELECT '-------CHECK STATEFUL FUNCTIONS-------';
SELECT arrayJoin(arrayMap(x -> x, arraySort(groupArray((ts, n))))) AS k FROM (
  SELECT ts, n, z FROM system.one ARRAY JOIN [1, 3, 4, 5, 6] AS ts, [1, 2, 2, 2, 1] AS n, ['a', 'a', 'b', 'a', 'b'] AS z
  ORDER BY n ASC, ts DESC
) WHERE z = 'a' GROUP BY z;
DROP TABLE IF EXISTS test_00808;
SELECT '-------finalizeAggregation should not be stateful (issue #14847)-------';
DROP TABLE IF EXISTS test_00808_push_down_with_finalizeAggregation;
CREATE TABLE test_00808_push_down_with_finalizeAggregation ENGINE = AggregatingMergeTree
ORDER BY n AS
SELECT
    intDiv(number, 25) AS n,
    avgState(number) AS s
FROM numbers(2500)
GROUP BY n
ORDER BY n;
SET force_primary_key = 1, enable_optimize_predicate_expression = 1;
SELECT *
FROM
(
    SELECT
        n,
        finalizeAggregation(s)
    FROM test_00808_push_down_with_finalizeAggregation
)
WHERE (n >= 2) AND (n <= 5)
ORDER BY n;
EXPLAIN SYNTAX SELECT *
FROM
(
    SELECT
        n,
        finalizeAggregation(s)
    FROM test_00808_push_down_with_finalizeAggregation
)
WHERE (n >= 2) AND (n <= 5);
DROP TABLE IF EXISTS test_00808_push_down_with_finalizeAggregation;
