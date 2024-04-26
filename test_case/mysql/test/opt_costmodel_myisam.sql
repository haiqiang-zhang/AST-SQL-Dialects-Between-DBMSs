
-- Adjust cost constants to be different for reading pages from a memory
-- buffer compared to reading from disk.
-- Cost for reading pages from memory to 0.5
UPDATE mysql.engine_cost
SET cost_value=0.5
WHERE cost_name="memory_block_read_cost";

-- Cost for reading pages from disk to 2.0
UPDATE mysql.engine_cost
SET cost_value=2
WHERE cost_name="io_block_read_cost";

-- Validate that the cost constants have been updated
SELECT engine_name, device_type, cost_name, cost_value
FROM mysql.engine_cost
WHERE cost_name="memory_block_read_cost"
   OR cost_name="io_block_read_cost";

-- Table must be stored in a storage engine that does not provide
-- estimates for how much of the index pages that are in a buffer
CREATE TABLE t1 (
  i1 INTEGER,
  c1 CHAR(200),
  INDEX idx (i1)
) ENGINE=MyISAM;

INSERT INTO t1 VALUES (1, "Ullensvang"), (2, "Odda"), (3, "Jondal");

-- Create a user connection
connect (con1,localhost,root,,);
SELECT i1 FROM t1 WHERE i1 > 1;

DROP TABLE t1;

-- Reset cost constants for storage engines to default values
UPDATE mysql.engine_cost
SET cost_value=DEFAULT;
