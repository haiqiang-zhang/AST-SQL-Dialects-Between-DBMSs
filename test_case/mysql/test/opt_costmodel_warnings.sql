--

-- Before starting the test check that the cost constant tables exists and
-- have the expected content.
--
-- Table: server_cost
--
-- Mask out the content of the last_update column
--replace_column 3 --
SELECT * FROM mysql.server_cost;

--
-- Table: engine_cost
--
-- Mask out the content of the last_update column
--replace_column 5 --
SELECT * FROM mysql.engine_cost;

--
-- TEST: correct warning when one of the cost constant tables are missing
--
-- This will cause a warning in the error log that needs to be ignored
--disable_query_log
call mtr.add_suppression('Failed to open optimizer cost constant tables');

-- Rename one of the tables
RENAME TABLE mysql.engine_cost TO mysql.engine_cost_renamed;

-- Restart the server to check that it handles the missing cost constant
-- table
--echo "Restarting MySQL server"

--source include/restart_mysqld.inc

--echo "MySQL restarted"

-- Restore the engine_cost table:
RENAME TABLE mysql.engine_cost_renamed TO mysql.engine_cost;

-- Verify the content of engine_cost:
--
-- Mask out the content of the last_update column
--replace_column 5 --
SELECT * FROM mysql.engine_cost;

--
-- TEST: handling of unrecognized or illegal entries in the server_cost table
--
-- This will cause the following warnings in the error log that needs to
-- be ignored
--disable_query_log
call mtr.add_suppression('Unknown cost constant "lunch_cost" in mysql.server_cost table');

-- Add an unrecognized cost constant name
INSERT INTO mysql.server_cost
VALUES ("lunch_cost", 1.0, CURRENT_TIMESTAMP, "Lunch is important", DEFAULT);

-- Change an existing cost constant to have a negative cost
UPDATE mysql.server_cost
SET cost_value=-1.0
WHERE cost_name="row_evaluate_cost";

-- Change an existing cost constant to have zero cost
UPDATE mysql.server_cost
SET cost_value=0.0
WHERE cost_name="key_compare_cost";

-- Restart the server to check that it handles the errors in the server_cost
-- table
--echo "Restarting MySQL server"

--source include/restart_mysqld.inc

--echo "MySQL restarted"

-- Clean-up:
DELETE FROM mysql.server_cost
WHERE cost_name LIKE "lunch_cost%";

UPDATE mysql.server_cost
SET cost_value=NULL
WHERE cost_name="row_evaluate_cost";

UPDATE mysql.server_cost
SET cost_value=NULL
WHERE cost_name="key_compare_cost";

--
-- TEST: handling of unrecognized or illegal entries in the engine_cost table
--
-- This will cause the following warnings in the error log that needs to
-- be ignored
--disable_query_log
call mtr.add_suppression('Invalid value for cost constant "io_block_read_cost" for "default" storage engine and device type 0 in mysql.engine_cost table: 0.0');

-- Add an unrecognized cost constant name
INSERT INTO mysql.engine_cost
VALUES ("InnoDB", 0, "lunch_cost", 1.0, CURRENT_TIMESTAMP, "Lunch is important", DEFAULT);

-- Change an existing cost constant to have zero cost
UPDATE mysql.engine_cost
SET cost_value=0.0
WHERE cost_name="io_block_read_cost";

-- Add a cost constant for an unknown storage engine
INSERT INTO mysql.engine_cost
VALUES ("Falcon", 0, "io_block_read_cost", 1.0, CURRENT_TIMESTAMP, "Unknown storage engine", DEFAULT);

-- Add a cost constant where the device type is illegal
INSERT INTO mysql.engine_cost
VALUES ("InnoDB", -1, "io_block_read_cost", 1.0, CURRENT_TIMESTAMP, "1 is an illegal device type", DEFAULT);


-- Restart the server to check that it handles the errors in the server_cost
-- table
--echo "Restarting MySQL server"

--source include/restart_mysqld.inc

--echo "MySQL restarted"

-- Clean-up:
DELETE FROM mysql.engine_cost
WHERE cost_name LIKE "lunch_cost%";

UPDATE mysql.engine_cost
SET cost_value=NULL;

DELETE FROM mysql.engine_cost
WHERE device_type = -1;

DELETE FROM mysql.engine_cost
WHERE engine_name LIKE "Falcon";

-- Before ending the test check that the cost constant tables still exists and
-- have the expected content.
--
-- Table: server_cost
--
-- Mask out the content of the last_update column
--replace_column 3 --
SELECT * FROM mysql.server_cost;

--
-- Table: engine_cost
--
-- Mask out the content of the last_update column
--replace_column 5 --
SELECT * FROM mysql.engine_cost;
