SET enable_optimize_predicate_expression = 1;
SET joined_subquery_requires_alias = 0;
SET convert_query_to_cnf = 0;
EXPLAIN SYNTAX SELECT co,co2,co3,num FROM ( SELECT co,co2,co3,count() AS num FROM (SELECT dummy+1 AS co,dummy+2 AS co2 ,dummy+3 AS co3) GROUP BY cube (co,co2,co3) ) WHERE co!=0 AND co2 !=2;
SELECT co,co2,co3,num FROM ( SELECT co,co2,co3,count() AS num FROM (SELECT dummy+1 AS co,dummy+2 AS co2 ,dummy+3 AS co3) GROUP BY cube (co,co2,co3) ) WHERE co!=0 AND co2 !=2;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
DROP TABLE IF EXISTS view1;
CREATE TABLE t1 (id UInt32, value1 String ) ENGINE ReplacingMergeTree() ORDER BY id;
CREATE TABLE t2 (id UInt32, value2 String ) ENGINE ReplacingMergeTree() ORDER BY id;
CREATE TABLE t3 (id UInt32, value3 String ) ENGINE ReplacingMergeTree() ORDER BY id;
INSERT INTO t1 (id, value1) VALUES (1, 'val11');
INSERT INTO t2 (id, value2) VALUES (1, 'val21');
INSERT INTO t3 (id, value3) VALUES (1, 'val31');
CREATE VIEW IF NOT EXISTS view1 AS SELECT t1.id AS id, t1.value1 AS value1, t2.value2 AS value2, t3.value3 AS value3 FROM t1 LEFT JOIN t2 ON t1.id = t2.id LEFT JOIN t3 ON t1.id = t3.id WHERE t1.id > 0;
SELECT * FROM view1 WHERE id = 1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
DROP TABLE IF EXISTS view1;
DROP TABLE IF EXISTS A;
DROP TABLE IF EXISTS B;
CREATE TABLE A (ts DateTime, id String, id_b String) ENGINE = MergeTree PARTITION BY toStartOfHour(ts) ORDER BY (ts,id);
CREATE TABLE B (ts DateTime, id String, id_c String) ENGINE = MergeTree PARTITION BY toStartOfHour(ts) ORDER BY (ts,id);
EXPLAIN SYNTAX SELECT ts, id, id_b, b.ts, b.id, id_c FROM (SELECT ts, id, id_b FROM A) AS a ALL LEFT JOIN B AS b ON b.id = a.id_b WHERE a.ts <= toDateTime('1970-01-01 03:00:00');
EXPLAIN SYNTAX SELECT ts AS `--a.ts`, id AS `--a.id`, id_b AS `--a.id_b`, b.ts AS `--b.ts`, b.id AS `--b.id`, id_c AS `--b.id_c` FROM (SELECT ts, id, id_b FROM A) AS a ALL LEFT JOIN B AS b ON `--b.id` = `--a.id_b` WHERE `--a.ts` <= toDateTime('1970-01-01 03:00:00');
DROP TABLE IF EXISTS A;
DROP TABLE IF EXISTS B;
DROP TABLE IF EXISTS test;
CREATE TABLE test ( A Int32, B Int32 ) ENGINE = Memory();
INSERT INTO test VALUES(1, 2)(0, 3)(1, 4)(0, 5);
DROP TABLE IF EXISTS test;
EXPLAIN SYNTAX SELECT * FROM (SELECT * FROM system.one) WHERE arrayMap(x -> x + 1, [dummy]) = [1];
SELECT * FROM (SELECT * FROM system.one) WHERE arrayMap(x -> x + 1, [dummy]) = [1];
EXPLAIN SYNTAX SELECT * FROM system.one HAVING dummy > 0 AND dummy < 0;
