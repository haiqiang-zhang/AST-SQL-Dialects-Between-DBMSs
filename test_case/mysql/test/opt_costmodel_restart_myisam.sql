
--
-- Test of the cost constants when restarting the server
--

-- To get stable cost estimates, the test should only be run with 
-- 16K InnoDB page size.

--
-- Test that changes to cost constants are used after restarting server
--

-- Verify that the content of the two cost constants tables are as expected
SELECT cost_name,cost_value FROM mysql.server_cost;
SELECT engine_name,cost_name,cost_value FROM mysql.engine_cost;

--
-- Create a test database that will be used for running queries
--
CREATE TABLE t0 (
  i1 INTEGER
);

INSERT INTO t0 VALUE (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

-- Create a table with 100 records each having size approximately 1000 bytes
CREATE TABLE t1_myisam (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  c1 CHAR(250),
  c2 CHAR(250),
  c3 CHAR(250),
  c4 CHAR(250),
  INDEX i1_key (i1)
) ENGINE=MyISAM;

INSERT INTO t1_myisam
SELECT a0.i1 + 10 * a1.i1, a0.i1, 'abc', 'def', 'ghi', 'jkl'
FROM t0 AS a0, t0 AS a1 ORDER BY a0.i1, a1.i1;

-- Run the query to see cost estimates when run with default cost constants
let query_myisam= SELECT * FROM t1_myisam;

--
-- Update one cost constant in the server cost table and the two cost
-- constants in the engine cost table (the reason for updating both is that
-- after a restart the statistics about whether pages are in memory or on disk
-- may vary). The new value is double of the default value.
--
UPDATE mysql.server_cost
SET cost_value=0.4
WHERE cost_name="row_evaluate_cost";

UPDATE mysql.engine_cost
SET cost_value=2.0
WHERE cost_name="memory_block_read_cost";

UPDATE mysql.engine_cost
SET cost_value=2.0
WHERE cost_name="io_block_read_cost";

SELECT cost_name, cost_value FROM mysql.server_cost;
SELECT engine_name, cost_name, cost_value FROM mysql.engine_cost;

--
-- Run the query to validate that the cost estimate has doubled
--

--echo "Explain with cost estimate against MyISAM"
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query_myisam;

-- Reset the cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;
UPDATE mysql.engine_cost
SET cost_value=DEFAULT;

--
-- Test that adding engine specific cost constants does not influence
-- other engines.
--
INSERT INTO mysql.engine_cost VALUES
  ("InnoDB", 0, "memory_block_read_cost", 4.0, CURRENT_TIMESTAMP, DEFAULT, DEFAULT);
INSERT INTO mysql.engine_cost VALUES
  ("InnoDB", 0, "io_block_read_cost", 4.0, CURRENT_TIMESTAMP, DEFAULT, DEFAULT);

SELECT cost_name, cost_value FROM mysql.server_cost;
SELECT engine_name, cost_name, cost_value FROM mysql.engine_cost;

--
-- Run the query and validate that the query against MyISAM has
-- the original cost estimates
--
--echo "Explain with cost estimate against MyISAM"
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query_myisam;

-- Delete the added entry for InnoDB
DELETE FROM mysql.engine_cost
WHERE engine_name NOT LIKE "default";

DROP TABLE t0, t1_myisam;
