ANALYZE pagg_tab;
EXPLAIN (COSTS OFF)
SELECT c, sum(a), avg(b), count(*), min(a), max(b) FROM pagg_tab GROUP BY c HAVING avg(d) < 15 ORDER BY 1, 2, 3;
SELECT c, sum(a), avg(b), count(*), min(a), max(b) FROM pagg_tab GROUP BY c HAVING avg(d) < 15 ORDER BY 1, 2, 3;
EXPLAIN (COSTS OFF)
SELECT a, c, count(*) FROM pagg_tab GROUP BY a, c;
EXPLAIN (COSTS OFF)
SELECT c, sum(a) FROM pagg_tab WHERE 1 = 2 GROUP BY c;
SELECT c, sum(a) FROM pagg_tab WHERE 1 = 2 GROUP BY c;
SET enable_hashagg TO false;
EXPLAIN (COSTS OFF)
SELECT c, sum(a), avg(b), count(*) FROM pagg_tab GROUP BY 1 HAVING avg(d) < 15 ORDER BY 1, 2, 3;
SELECT c, sum(a), avg(b), count(*) FROM pagg_tab GROUP BY 1 HAVING avg(d) < 15 ORDER BY 1, 2, 3;
EXPLAIN (COSTS OFF)
SELECT c FROM pagg_tab GROUP BY c ORDER BY 1;
SELECT c FROM pagg_tab GROUP BY c ORDER BY 1;
EXPLAIN (COSTS OFF)
SELECT a FROM pagg_tab WHERE a < 3 GROUP BY a ORDER BY 1;
SELECT a FROM pagg_tab WHERE a < 3 GROUP BY a ORDER BY 1;
RESET enable_hashagg;
EXPLAIN (COSTS OFF)
SELECT c, sum(a) FROM pagg_tab GROUP BY rollup(c) ORDER BY 1, 2;
CREATE TABLE pagg_tab1(x int, y int) PARTITION BY RANGE(x);
CREATE TABLE pagg_tab1_p1 PARTITION OF pagg_tab1 FOR VALUES FROM (0) TO (10);
CREATE TABLE pagg_tab1_p2 PARTITION OF pagg_tab1 FOR VALUES FROM (10) TO (20);
CREATE TABLE pagg_tab1_p3 PARTITION OF pagg_tab1 FOR VALUES FROM (20) TO (30);
CREATE TABLE pagg_tab2(x int, y int) PARTITION BY RANGE(y);
CREATE TABLE pagg_tab2_p1 PARTITION OF pagg_tab2 FOR VALUES FROM (0) TO (10);
CREATE TABLE pagg_tab2_p2 PARTITION OF pagg_tab2 FOR VALUES FROM (10) TO (20);
CREATE TABLE pagg_tab2_p3 PARTITION OF pagg_tab2 FOR VALUES FROM (20) TO (30);
INSERT INTO pagg_tab1 SELECT i % 30, i % 20 FROM generate_series(0, 299, 2) i;
INSERT INTO pagg_tab2 SELECT i % 20, i % 30 FROM generate_series(0, 299, 3) i;
ANALYZE pagg_tab1;
ANALYZE pagg_tab2;
EXPLAIN (COSTS OFF)
SELECT t1.x, sum(t1.y), count(*) FROM pagg_tab1 t1, pagg_tab2 t2 WHERE t1.x = t2.y GROUP BY t1.x ORDER BY 1, 2, 3;
SELECT t1.x, sum(t1.y), count(*) FROM pagg_tab1 t1, pagg_tab2 t2 WHERE t1.x = t2.y GROUP BY t1.x ORDER BY 1, 2, 3;
SET enable_hashagg TO false;
RESET enable_hashagg;
SELECT a.x, b.y, count(*) FROM (SELECT * FROM pagg_tab1 WHERE x < 20) a LEFT JOIN (SELECT * FROM pagg_tab2 WHERE y > 10) b ON a.x = b.y WHERE a.x > 5 or b.y < 20  GROUP BY a.x, b.y ORDER BY 1, 2;
CREATE TABLE pagg_tab_m (a int, b int, c int) PARTITION BY RANGE(a, ((a+b)/2));
CREATE TABLE pagg_tab_m_p1 PARTITION OF pagg_tab_m FOR VALUES FROM (0, 0) TO (12, 12);
CREATE TABLE pagg_tab_m_p2 PARTITION OF pagg_tab_m FOR VALUES FROM (12, 12) TO (22, 22);
CREATE TABLE pagg_tab_m_p3 PARTITION OF pagg_tab_m FOR VALUES FROM (22, 22) TO (30, 30);
INSERT INTO pagg_tab_m SELECT i % 30, i % 40, i % 50 FROM generate_series(0, 2999) i;
ANALYZE pagg_tab_m;
CREATE TABLE pagg_tab_ml (a int, b int, c text) PARTITION BY RANGE(a);
CREATE TABLE pagg_tab_ml_p1 PARTITION OF pagg_tab_ml FOR VALUES FROM (0) TO (12);
CREATE TABLE pagg_tab_ml_p2 PARTITION OF pagg_tab_ml FOR VALUES FROM (12) TO (20) PARTITION BY LIST (c);
CREATE TABLE pagg_tab_ml_p2_s1 PARTITION OF pagg_tab_ml_p2 FOR VALUES IN ('0000', '0001', '0002');
CREATE TABLE pagg_tab_ml_p2_s2 PARTITION OF pagg_tab_ml_p2 FOR VALUES IN ('0003');
CREATE TABLE pagg_tab_ml_p3(b int, c text, a int) PARTITION BY RANGE (b);
CREATE TABLE pagg_tab_ml_p3_s1(c text, a int, b int);
CREATE TABLE pagg_tab_ml_p3_s2 PARTITION OF pagg_tab_ml_p3 FOR VALUES FROM (7) TO (10);
ALTER TABLE pagg_tab_ml_p3 ATTACH PARTITION pagg_tab_ml_p3_s1 FOR VALUES FROM (0) TO (7);
ALTER TABLE pagg_tab_ml ATTACH PARTITION pagg_tab_ml_p3 FOR VALUES FROM (20) TO (30);
INSERT INTO pagg_tab_ml SELECT i % 30, i % 10, to_char(i % 4, 'FM0000') FROM generate_series(0, 29999) i;
ANALYZE pagg_tab_ml;
SET max_parallel_workers_per_gather TO 2;
SET parallel_setup_cost = 0;
EXPLAIN (COSTS OFF)
SELECT a, sum(b), array_agg(distinct c), count(*) FROM pagg_tab_ml GROUP BY a HAVING avg(b) < 3 ORDER BY 1, 2, 3;
SELECT a, sum(b), array_agg(distinct c), count(*) FROM pagg_tab_ml GROUP BY a HAVING avg(b) < 3 ORDER BY 1, 2, 3;
RESET parallel_setup_cost;
SET min_parallel_table_scan_size TO '8kB';
SET parallel_setup_cost TO 0;
SET parallel_setup_cost TO 10;
CREATE TABLE pagg_tab_para(x int, y int) PARTITION BY RANGE(x);
CREATE TABLE pagg_tab_para_p1 PARTITION OF pagg_tab_para FOR VALUES FROM (0) TO (12);
CREATE TABLE pagg_tab_para_p2 PARTITION OF pagg_tab_para FOR VALUES FROM (12) TO (22);
CREATE TABLE pagg_tab_para_p3 PARTITION OF pagg_tab_para FOR VALUES FROM (22) TO (30);
INSERT INTO pagg_tab_para SELECT i % 30, i % 20 FROM generate_series(0, 29999) i;
ANALYZE pagg_tab_para;
ALTER TABLE pagg_tab_para_p1 SET (parallel_workers = 0);
ALTER TABLE pagg_tab_para_p3 SET (parallel_workers = 0);
ANALYZE pagg_tab_para;
ALTER TABLE pagg_tab_para_p2 SET (parallel_workers = 0);
ANALYZE pagg_tab_para;
RESET min_parallel_table_scan_size;
RESET parallel_setup_cost;
