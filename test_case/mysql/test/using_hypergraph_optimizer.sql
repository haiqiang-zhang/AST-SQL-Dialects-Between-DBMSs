
-- The tests in this file are grouped into sections corresponding to MySQL bugs.
-- The hypergraph optimizer is enabled whenever a test section is entered and
-- this invariant is restored at the end of each section.
-- Optimizer tracing is enabled throughout the file.

--source include/have_hypergraph.inc -- Enables hypergraph optimizer
--source include/have_optimizer_trace.inc -- Verifies optimizer trace support
SET optimizer_trace='enabled=on';

-- Description:
-- Subqueries in SET statements are optimized with the old optimizer, even if
-- the hypergraph optimizer is enabled.
--
-- Example SET statement:
-- SET optimizer_switch = 'hypergraph_optimizer=on';

CREATE TABLE t(x INT);
INSERT INTO t VALUES (1), (2), (3);

SET @x = (SELECT COUNT(*) FROM t);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT @x;

SET @x = (SELECT COUNT(*) FROM t WHERE x >= 2);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT @x;

SET @x = 1 + (SELECT COUNT(*) FROM t);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT @x;

SET @x = 1 IN (SELECT x FROM t);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT @x;

SET @x = EXISTS (SELECT x FROM t);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT @x;

-- Verify that prepared SET statements use the optimizer that was active
-- when PREPARE was called. Prepared SELECT statements use the optimizer that
-- is active during execution.

--echo -- Case 1.a: Preparation: 'hypergraph_optimizer=on', execution: 'hypergraph_optimizer=on'
PREPARE ps_set FROM 'SET @x = (SELECT COUNT(*) FROM t)';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SET optimizer_switch = 'hypergraph_optimizer=off';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SET optimizer_switch = 'hypergraph_optimizer=off';

-- Set 'hypergraph_optimizer=on' while suppressing warnings
--source include/have_hypergraph.inc

EXECUTE ps_set;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SET optimizer_switch = 'hypergraph_optimizer=off';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';

-- Verify that 'Constructed hypergraph' is missing from the optimizer trace
-- when the hypergraph optimizer is disabled

SET optimizer_switch = 'hypergraph_optimizer=off';
SET @x = (SELECT COUNT(*) FROM t);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT @x;

DROP TABLE t;

-- Description:
-- The hypergraph optimizer is not used for scalar subqueries in the VALUES
-- and ON DUPLICATE KEY UPDATE clauses of INSERT statements,
-- even if the hypergraph optimizer has been enabled.
--
-- Example query:
-- SET optimizer_switch = 'hypergraph_optimizer=on';

CREATE TABLE t1(x INT);
CREATE TABLE t2(x INT);

INSERT INTO t1 VALUES ((SELECT COUNT(*) FROM t2));
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT x FROM t1;

INSERT INTO t1 VALUES (1 + (SELECT COUNT(*) FROM t2));
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT x FROM t1;

INSERT INTO t2 VALUES (1), (2), (3);
INSERT INTO t1 VALUES ((SELECT COUNT(*) FROM t2 WHERE x <= 2));
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT x FROM t1;

-- Verify use of the hypergraph optimizer for scalar subqueries in the
-- ON DUPLICATE KEY UPDATE clause of an insert statement.

CREATE TABLE t3(x INT PRIMARY KEY);
INSERT INTO t3 VALUES (1);
INSERT INTO t3 VALUES (1) ON DUPLICATE KEY UPDATE x = (SELECT COUNT(*) FROM t1);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT x FROM t3;

-- Verify that 'Constructed hypergraph' is missing from the optimizer trace
-- when the hypergraph optimizer is disabled

SET optimizer_switch = 'hypergraph_optimizer=off';
INSERT INTO t1 VALUES ((SELECT COUNT(*) FROM t2));
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';

DROP TABLE t1, t2, t3;

CREATE TABLE t (x INTEGER, y INTEGER);
DELETE t FROM t WHERE x > 0;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
DELETE FROM t WHERE x > 0;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
DROP TABLE t;

CREATE TABLE t1 (x INTEGER, y INTEGER);
CREATE TABLE t2 (z INTEGER);
INSERT INTO t1 VALUES (1, 2), (2, 3), (3, 4);
INSERT INTO t2 VALUES (1), (3), (5);
UPDATE t1, t2 SET y = y + 1 WHERE x = z;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
UPDATE t1 SET y = y + 1;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE
WHERE TRACE LIKE '%Constructed hypergraph%';
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;

SET optimizer_trace='enabled=off';
SET optimizer_switch=default;
