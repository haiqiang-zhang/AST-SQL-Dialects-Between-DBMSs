SET enable_optimize_predicate_expression = 1;
WITH
  v1 AS (SELECT t1.c2, t2.c2, t2.c3 FROM t1 ASOF JOIN t2 USING (c1, c2))
  SELECT count() FROM v1 WHERE c3 = 'b';
SET enable_optimize_predicate_expression = 0;
WITH
  v1 AS (SELECT t1.c2, t2.c2, t2.c3 FROM t1 ASOF JOIN t2 USING (c1, c2))
  SELECT count() FROM v1 WHERE c3 = 'b';
