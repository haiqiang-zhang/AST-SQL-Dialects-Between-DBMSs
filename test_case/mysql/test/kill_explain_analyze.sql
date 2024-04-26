
-- Does not contain the sync point used.
--source include/not_hypergraph.inc

CREATE TABLE t1 ( pk INTEGER );
INSERT INTO t1 VALUES (1), (2), (3);

-- Kill the query during optimization. We should have no result, and an error (as usual).
SET SESSION debug="+d,bug13820776_1";
SET SESSION debug="-d,bug13820776_1";

-- Now kill it after the first output row. We should get a partial result,
-- with a warning about the query being interrupted.
SET SESSION debug="+d,bug13822652_1";
SET SESSION debug="-d,bug13822652_1";

-- Run it to completion, just for comparison.
--replace_regex $elide_time
EXPLAIN ANALYZE SELECT * from t1, t1 AS t2;

DROP TABLE t1;