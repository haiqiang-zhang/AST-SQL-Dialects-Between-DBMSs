SYSTEM FLUSH LOGS;
DROP TABLE src2dst_true;
SET use_index_for_in_with_subqueries = 0;
CREATE MATERIALIZED VIEW src2dst_false TO dst AS
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
INSERT into src SELECT number + 200 as id, 1 FROM numbers(2);
SYSTEM FLUSH LOGS;
DROP TABLE src2dst_false;
DROP TABLE src;
DROP TABLE dst;
