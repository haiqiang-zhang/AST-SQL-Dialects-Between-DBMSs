SET work_mem='64kB';
SET enable_hashagg=FALSE;
SET jit_above_cost=0;
EXPLAIN (costs off)
SELECT DISTINCT g%1000 FROM generate_series(0,9999) g;
CREATE TABLE distinct_group_1 AS
SELECT DISTINCT g%1000 FROM generate_series(0,9999) g;
SET jit_above_cost TO DEFAULT;
CREATE TABLE distinct_group_2 AS
SELECT DISTINCT (g%1000)::text FROM generate_series(0,9999) g;
SET enable_seqscan = 0;
RESET enable_seqscan;
SET enable_hashagg=TRUE;
SET enable_sort=FALSE;
SET jit_above_cost=0;
EXPLAIN (costs off)
SELECT DISTINCT g%1000 FROM generate_series(0,9999) g;
CREATE TABLE distinct_hash_1 AS
SELECT DISTINCT g%1000 FROM generate_series(0,9999) g;
SET jit_above_cost TO DEFAULT;
CREATE TABLE distinct_hash_2 AS
SELECT DISTINCT (g%1000)::text FROM generate_series(0,9999) g;
SET enable_sort=TRUE;
SET work_mem TO DEFAULT;
(SELECT * FROM distinct_hash_1 EXCEPT SELECT * FROM distinct_group_1)
  UNION ALL
(SELECT * FROM distinct_group_1 EXCEPT SELECT * FROM distinct_hash_1);
(SELECT * FROM distinct_hash_1 EXCEPT SELECT * FROM distinct_group_1)
  UNION ALL
(SELECT * FROM distinct_group_1 EXCEPT SELECT * FROM distinct_hash_1);
DROP TABLE distinct_hash_1;
DROP TABLE distinct_hash_2;
DROP TABLE distinct_group_1;
DROP TABLE distinct_group_2;
SET parallel_tuple_cost=0;
SET parallel_setup_cost=0;
SET min_parallel_table_scan_size=0;
SET max_parallel_workers_per_gather=2;
CREATE OR REPLACE FUNCTION distinct_func(a INT) RETURNS INT AS $$
  BEGIN
    RETURN a;
  END;
$$ LANGUAGE plpgsql PARALLEL UNSAFE;
CREATE OR REPLACE FUNCTION distinct_func(a INT) RETURNS INT AS $$
  BEGIN
    RETURN a;
  END;
$$ LANGUAGE plpgsql PARALLEL SAFE;
RESET max_parallel_workers_per_gather;
RESET min_parallel_table_scan_size;
RESET parallel_setup_cost;
RESET parallel_tuple_cost;
SET parallel_setup_cost=0;
SET min_parallel_table_scan_size=0;
SET max_parallel_workers_per_gather=2;
RESET max_parallel_workers_per_gather;
RESET min_parallel_table_scan_size;
RESET parallel_setup_cost;
CREATE TEMP TABLE disttable (f1 integer);
INSERT INTO DISTTABLE VALUES(1);
INSERT INTO DISTTABLE VALUES(2);
INSERT INTO DISTTABLE VALUES(3);
INSERT INTO DISTTABLE VALUES(NULL);
SELECT f1, f1 IS DISTINCT FROM 2 as "not 2" FROM disttable;
SELECT f1, f1 IS DISTINCT FROM NULL as "not null" FROM disttable;
SELECT f1, f1 IS DISTINCT FROM f1 as "false" FROM disttable;
SELECT f1, f1 IS DISTINCT FROM f1+1 as "not null" FROM disttable;
SELECT 1 IS DISTINCT FROM 2 as "yes";
SELECT 2 IS DISTINCT FROM 2 as "no";
SELECT 2 IS DISTINCT FROM null as "yes";
SELECT null IS DISTINCT FROM null as "no";
SELECT 1 IS NOT DISTINCT FROM 2 as "no";
SELECT 2 IS NOT DISTINCT FROM 2 as "yes";
SELECT 2 IS NOT DISTINCT FROM null as "no";
SELECT null IS NOT DISTINCT FROM null as "yes";
