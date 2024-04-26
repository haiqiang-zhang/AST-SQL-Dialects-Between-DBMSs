
--
-- Default values for cost constants (from the source code)
--
let $row_evaluate_cost= 0.1;
let $key_compare_cost= 0.05;
let $memory_temptable_create_cost= 1.0;
let $memory_temptable_row_cost= 0.1;
let $disk_temptable_create_cost= 20;
let $disk_temptable_row_cost= 0.5;
let $memory_block_read_cost= 0.25;
let $io_block_read_cost= 1.0;


CREATE TABLE t1 (
  i1 INTEGER,
  i2 INTEGER,
  i3 INTEGER,
  KEY(i1,i2)
) ENGINE=InnoDB;

INSERT INTO t1 VALUES (1, 1, 1), (1, 1, 1),(1, 1, 1),(1, 1, 1),
                      (2, 2, 1), (2, 2, 1),(2, 2, 1),(2, 2, 1),
                      (3, 3, 1), (3, 3, 1),(3, 3, 1),(3, 3, 1);

-- worst_seeks is used for two cases: when the entire index is used and 
-- when only a prefix of the index is used. Two get coverage for both cases,
-- two almost identical queries are needed.

-- Test query for case 1: the entire index is used
let query_1= SELECT i3 FROM t1 WHERE i1 = 1 AND i2 = 1;

-- Test query for case 2: only a prefix of the index is used
let query_2= SELECT i3 FROM t1 WHERE i1 = 1 AND i3 = 1;

-- Run the queries with default cost constants

-- Create a user connection
connect (con1,localhost,root,,);

-- Get cost estimates with default values
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query_1;

-- Double the value that the cost constants have:
-- 1. Replace the NULL in the cost_value column with actual value

-- Update server_cost:
eval UPDATE mysql.server_cost
     SET cost_value=$row_evaluate_cost
     WHERE cost_name="row_evaluate_cost";
     SET cost_value=$key_compare_cost
     WHERE cost_name="key_compare_cost";
     SET cost_value=$memory_temptable_create_cost
     WHERE cost_name="memory_temptable_create_cost";
     SET cost_value=$memory_temptable_row_cost
     WHERE cost_name="memory_temptable_row_cost";
     SET cost_value=$disk_temptable_create_cost
     WHERE cost_name="disk_temptable_create_cost";
     SET cost_value=$disk_temptable_row_cost
     WHERE cost_name="disk_temptable_row_cost";

-- Update engine_cost:
eval UPDATE mysql.engine_cost
     SET cost_value=$memory_block_read_cost
     WHERE cost_name="memory_block_read_cost";
     SET cost_value=$io_block_read_cost
     WHERE cost_name="io_block_read_cost";

-- 2. Multiply all cost constants by two
UPDATE mysql.server_cost
SET cost_value = 2 * cost_value;

UPDATE mysql.engine_cost
SET cost_value = 2 * cost_value;

-- Validate cost constants
SELECT cost_name, cost_value FROM mysql.server_cost;
SELECT cost_name, cost_value FROM mysql.engine_cost;

-- Re-run the queries with the new cost constants

-- Create a user connection
connect (con1,localhost,root,,);

-- The new cost estimates should be approximately the double compared to the
-- first run
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query_1;

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;

UPDATE mysql.engine_cost
SET cost_value=DEFAULT;

DROP TABLE t1;

CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  a INTEGER,
  b INTEGER,
  c CHAR(255),
  UNIQUE KEY k1 (a)
);

INSERT INTO t1 VALUES (1, 1, NULL, "Abc"), (2, 2, NULL, "Abc"),
                      (3, 3, NULL, "Abc"), (4, 4, NULL, "Abc");
INSERT INTO t1 SELECT a + 4, a + 4, b, c FROM t1;
INSERT INTO t1 SELECT a + 8, a + 8, b, c FROM t1;
INSERT INTO t1 SELECT a + 16, a + 16, b, c FROM t1;
INSERT INTO t1 SELECT a + 32, a + 32, b, c FROM t1;
INSERT INTO t1 SELECT a + 64, a + 64, b, c FROM t1;
INSERT INTO t1 SELECT a + 128, a + 128, b, c FROM t1;

CREATE TABLE t2 (
  d INTEGER PRIMARY KEY,
  e INTEGER
);

INSERT INTO t2 SELECT a, b FROM t1;

-- Test query: This should do limit optimization and use index without filesort
let query= SELECT * FROM t1 JOIN t2 ON b=d ORDER BY a LIMIT 4;

-- Run the query with default cost constants

-- Create a user connection
connect (con1,localhost,root,,);

-- Get cost estimates with default values
--echo -- Query should be optimized for the LIMIT. Query plan should
--echo -- use index without filesort
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query;

-- Halve the value of the cost constants:
-- 1. Replace the NULL in the cost_value column with actual value

-- Update server_cost:
eval UPDATE mysql.server_cost
     SET cost_value=$row_evaluate_cost
     WHERE cost_name="row_evaluate_cost";
     SET cost_value=$key_compare_cost
     WHERE cost_name="key_compare_cost";
     SET cost_value=$memory_temptable_create_cost
     WHERE cost_name="memory_temptable_create_cost";
     SET cost_value=$memory_temptable_row_cost
     WHERE cost_name="memory_temptable_row_cost";
     SET cost_value=$disk_temptable_create_cost
     WHERE cost_name="disk_temptable_create_cost";
     SET cost_value=$disk_temptable_row_cost
     WHERE cost_name="disk_temptable_row_cost";

-- Update engine_cost:
eval UPDATE mysql.engine_cost
     SET cost_value=$memory_block_read_cost
     WHERE cost_name="memory_block_read_cost";
     SET cost_value=$io_block_read_cost
     WHERE cost_name="io_block_read_cost";

-- 2. Divide all cost constants by two
UPDATE mysql.server_cost
SET cost_value = 0.5 * cost_value;

UPDATE mysql.engine_cost
SET cost_value = 0.5 * cost_value;

-- Validate cost constants
SELECT cost_name, cost_value FROM mysql.server_cost;
SELECT cost_name, cost_value FROM mysql.engine_cost;

-- Re-run the queries with the new cost constants

-- Create a user connection
connect (con1,localhost,root,,);

-- The new cost estimates should be approximately half compared to the
-- first run. The query plan should still be the same.
--echo -- This should be optimized for the LIMIT. Query plan should
--echo -- use index without filesort
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query;

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;

UPDATE mysql.engine_cost
SET cost_value=DEFAULT;

DROP TABLE t1, t2;
