SELECT JSON_PRETTY(JSON_EXTRACT(trace,"$.steps[*].join_execution"))
   FROM information_schema.optimizer_trace;
SELECT MAX( c1 ) OVER ( ORDER BY c2 ROWS CURRENT ROW ) FROM t1
INTERSECT DISTINCT
SELECT "can't" OR 447938560 FROM t1;
DROP TABLE t1;
