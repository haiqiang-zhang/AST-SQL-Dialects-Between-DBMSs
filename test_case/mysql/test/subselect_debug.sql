
--
-- Bug #37627: Killing query with sum(exists()) or avg(exists()) reproducibly
-- crashes server
--

CREATE TABLE t1(id INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
INSERT INTO t1 SELECT a.id FROM t1 a,t1 b,t1 c,t1 d;
SET @orig_debug = @@debug;
SET SESSION debug="d,subselect_exec_fail";
SELECT SUM(EXISTS(SELECT RAND() FROM t1)) FROM t1;
SELECT REVERSE(EXISTS(SELECT RAND() FROM t1));
SET SESSION debug=@orig_debug;
DROP TABLE t1;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(1);
SELECT ((SELECT 1 FROM t1) IN (SELECT 1 FROM t1)) - (11111111111111111111);
DROP TABLE t1;

CREATE TABLE t (x INT);
INSERT INTO t VALUES (1), (2), (3);
SET DEBUG='+d,hash_semijoin_fail_in_setup';
SET DEBUG='-d,hash_semijoin_fail_in_setup';
DROP TABLE t;

CREATE TABLE t (x INT);
INSERT INTO t VALUES (1), (2), (3);
SET optimizer_switch = 'firstmatch=off,materialization=off';
SET DEBUG='+d,create_duplicate_weedout_tmp_table_error';
SET DEBUG='-d,create_duplicate_weedout_tmp_table_error';
DROP TABLE t;
SET optimizer_switch = DEFAULT;

CREATE TABLE t1(
  id INT,
  pad VARCHAR(60),
  pad1 VARCHAR(513)
);

INSERT INTO t1 VALUES (1, REPEAT('a',59), REPEAT('a',512));
INSERT INTO t1 VALUES (2, REPEAT('a',59), REPEAT('a',512));

SET SESSION debug = '+d, simulate_temp_storage_engine_full';
SELECT COUNT(*), pad FROM t1 GROUP BY pad;
SELECT COUNT(*), pad1 FROM t1 GROUP BY pad1;
SET SESSION debug = '-d, simulate_temp_storage_engine_full';

DROP TABLE t1;
