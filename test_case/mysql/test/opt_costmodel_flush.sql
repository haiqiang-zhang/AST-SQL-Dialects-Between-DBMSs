--

-- To get stable cost estimates, the test should only be run with 
-- 16K InnoDB page size.

CREATE TABLE t0 (
  i1 INTEGER
);

INSERT INTO t0 VALUE (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

-- Create a table with 100 records each having size approximately 1000 bytes
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  c1 CHAR(250),
  c2 CHAR(250),
  c3 CHAR(250),
  c4 CHAR(250),
  INDEX i1_key (i1)
) ENGINE=InnoDB;

INSERT INTO t1
SELECT a0.i1 + 10 * a1.i1, a0.i1, 'abc', 'def', 'ghi', 'jkl'
FROM t0 AS a0, t0 AS a1 ORDER BY a0.i1, a1.i1;

-- Test query for table scan
let query= SELECT * FROM t1;

-- Create a user connection
connect (con1,localhost,root,,);

-- Get cost estimates with default values
--skip_if_hypergraph  -- Depends on the query plan.
eval EXPLAIN FORMAT=JSON $query;

-- Master connection: Update the value of the row_evaluate_cost
UPDATE mysql.server_cost
SET cost_value=0.4
WHERE cost_name="row_evaluate_cost";

-- Switch to existing user connection and verify that doing a change
-- to a cost constant does not influence on an existing connection,
-- ie the cost estimates in EXPLAIN should be the same
connection con1;

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;

-- Master connection: Update the value of the row_evaluate_cost
UPDATE mysql.server_cost
SET cost_value=0.2
WHERE cost_name="row_evaluate_cost";

-- Create a NEW connection
connect (con1,localhost,root,,);

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;
let query= SELECT DISTINCT(i1) FROM t1;

-- Master connection: Update the value of the key_compare_cost
UPDATE mysql.server_cost
SET cost_value=0.1
WHERE cost_name="key_compare_cost";

-- Create NEW connection
connect (con1,localhost,root,,);

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;
let query=
SELECT * FROM t1
WHERE i1 IN (SELECT i1 FROM t1);

-- Master connection:
-- Update the value of the memory_temptable_create_cost from default (1.0)
-- to 10.0 (up by 9.0)
UPDATE mysql.server_cost
SET cost_value=10.0
WHERE cost_name="memory_temptable_create_cost";

-- Create NEW connection
connect (con1,localhost,root,,);

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;
let query=
SELECT * FROM t1
WHERE i1 IN (SELECT i1 FROM t1);

-- Master connection:
-- Update the value of the memory_temptable_row_cost from default (0.1)
-- to 0.2
UPDATE mysql.server_cost
SET cost_value=0.2
WHERE cost_name="memory_temptable_row_cost";

-- Create NEW connection
connect (con1,localhost,root,,);

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;

-- The next two tests are for cost of disk based temporary tables
-- To ensure this temp table is written to a disk based storage engine
set global internal_tmp_mem_storage_engine='memory';
set session internal_tmp_mem_storage_engine='memory';
set @max_heap_table_size_save= @@max_heap_table_size;
set max_heap_table_size= 16384;
let query=
SELECT * FROM t1
WHERE c1 IN (SELECT c1 FROM t1);

-- Master connection:
-- Update the value of the disk_temptable_create_cost from default (20.0)
-- to 40.0
UPDATE mysql.server_cost
SET cost_value=40.0
WHERE cost_name="disk_temptable_create_cost";

-- Create NEW connection
connect (con1,localhost,root,,);
set max_heap_table_size= 16384;

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;
let query=
SELECT * FROM t1
WHERE c1 IN (SELECT c1 FROM t1);

-- Master connection:
-- Update the value of the disk_temptable_row_cost from default (0.5)
-- to 1.0
UPDATE mysql.server_cost
SET cost_value=1.0
WHERE cost_name="disk_temptable_row_cost";

-- Create NEW connection
connect (con1,localhost,root,,);
set max_heap_table_size= 16384;

-- Reset cost constants
UPDATE mysql.server_cost
SET cost_value=DEFAULT;

-- Finished testing disk based temporary tables
set max_heap_table_size= @max_heap_table_size_save;
set session internal_tmp_mem_storage_engine=default;
set global internal_tmp_mem_storage_engine=default;
let query= SELECT * FROM t1;

-- Master connection: Update the value of the memory_block_read_cost
UPDATE mysql.engine_cost
SET cost_value=0.5
WHERE cost_name="memory_block_read_cost";

-- Create NEW connection
connect (con1,localhost,root,,);

-- Reset cost constants
UPDATE mysql.engine_cost
SET cost_value=DEFAULT;

DROP TABLE t0,t1;
