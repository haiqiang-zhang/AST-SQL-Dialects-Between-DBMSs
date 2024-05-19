
CREATE TABLE pred_tab (a int NOT NULL, b int, c int NOT NULL);


EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.a IS NOT NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.b IS NOT NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.a IS NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.b IS NULL;


EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.a IS NOT NULL OR t.b = 1;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.b IS NOT NULL OR t.a = 1;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.a IS NULL OR t.c IS NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t WHERE t.b IS NULL OR t.c IS NULL;


EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON TRUE
    LEFT JOIN pred_tab t3 ON t2.a IS NOT NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON t1.a = 1
    LEFT JOIN pred_tab t3 ON t2.a IS NOT NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON TRUE
    LEFT JOIN pred_tab t3 ON t2.a IS NULL AND t2.b = 1;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON t1.a = 1
    LEFT JOIN pred_tab t3 ON t2.a IS NULL;


EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON TRUE
    LEFT JOIN pred_tab t3 ON t2.a IS NOT NULL OR t2.b = 1;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON t1.a = 1
    LEFT JOIN pred_tab t3 ON t2.a IS NOT NULL OR t2.b = 1;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON TRUE
    LEFT JOIN pred_tab t3 ON (t2.a IS NULL OR t2.c IS NULL) AND t2.b = 1;

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab t1
    LEFT JOIN pred_tab t2 ON t1.a = 1
    LEFT JOIN pred_tab t3 ON t2.a IS NULL OR t2.c IS NULL;

DROP TABLE pred_tab;
