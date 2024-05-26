SET log_queries=1;
SET log_profile_events=true;
CREATE TABLE src Engine=MergeTree ORDER BY id AS SELECT number as id, toInt32(1) as value FROM numbers(1);
CREATE TABLE dst (id UInt64, delta Int64) Engine=MergeTree ORDER BY id;
SET use_index_for_in_with_subqueries = 1;
CREATE MATERIALIZED VIEW src2dst_true TO dst AS
SELECT
       id,
       src.value - deltas_sum as delta
FROM src
LEFT JOIN
(
    SELECT id, sum(delta) as deltas_sum FROM dst
    WHERE id IN (SELECT id FROM src WHERE not sleepEachRow(0.001))
    GROUP BY id
) _a
USING (id);
INSERT into src SELECT number + 100 as id, 1 FROM numbers(2);
