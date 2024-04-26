CREATE TABLE t1 (col1 INT, col2 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';

SET DEBUG='+d,fail_after_drop_histograms';
DROP TABLE t1;

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';

SET DEBUG='-d,fail_after_drop_histograms';

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' AND COLUMN_NAME = 'col2';

SET DEBUG='+d,fail_after_drop_histograms';
ALTER TABLE t1 DROP COLUMN col2;

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' AND COLUMN_NAME = 'col2';

SET DEBUG='-d,fail_after_drop_histograms';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';

SET DEBUG='+d,fail_after_rename_histograms';
ALTER TABLE t1 RENAME TO t2;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';
SET DEBUG='-d,fail_after_rename_histograms';

DROP TABLE t1;

SET DEBUG='+d,histogram_force_sampling';

CREATE TABLE t1 (col1 DOUBLE);
INSERT INTO t1 SELECT RAND(1);
INSERT INTO t1 SELECT RAND(2) FROM t1;
INSERT INTO t1 SELECT RAND(3) FROM t1;
INSERT INTO t1 SELECT RAND(4) FROM t1;
INSERT INTO t1 SELECT RAND(5) FROM t1;
INSERT INTO t1 SELECT RAND(6) FROM t1;
INSERT INTO t1 SELECT RAND(7) FROM t1;
INSERT INTO t1 SELECT RAND(8) FROM t1;
INSERT INTO t1 SELECT RAND(9) FROM t1;
INSERT INTO t1 SELECT RAND(10) FROM t1;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;

SET DEBUG='-d,histogram_force_sampling';
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SET DEBUG='+d,histogram_fail_after_open_table';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SET DEBUG='-d,histogram_fail_after_open_table';
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
SET DEBUG='+d,histogram_fail_during_lock_for_write';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SET DEBUG='-d,histogram_fail_during_lock_for_write';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
SET DEBUG_SYNC='store_histogram_after_write_lock SIGNAL histogram_1_waiting WAIT_FOR continue_store_histogram';

-- The connection 'con1' will now wait on the debug sync point
-- "store_histogram_after_write_lock", where it has acquired an exclusive lock
-- on the histogram object. Switch connection, and inspect the metadata locks
-- table in performance schema in order to verify that OBJECT_TYPE is properly
-- reflected. Wait until 'con1' has signaled that it actually is waiting
--connection default
SET DEBUG_SYNC='now WAIT_FOR histogram_1_waiting';
SELECT OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, COLUMN_NAME
  FROM performance_schema.metadata_locks
  WHERE LOCK_TYPE = "EXCLUSIVE"
    AND OBJECT_TYPE = "COLUMN STATISTICS"
  ORDER BY OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, COLUMN_NAME;

-- While 'con1' still is waiting on the sync point right after the exclusive lock
-- is aquired, open a new connection and create a histogram for the same column.
-- The effect we want is a wait on the same MDL, so that we can inspect that
-- the lock is fully reflected in performance_schema.events_waits_*
connect(con2, localhost, root,,);
SET DEBUG_SYNC='mdl_acquire_lock_wait SIGNAL histogram_2_lock_waiting';

-- Go back to the default connection, and verify the contents of
-- performance_schema.events_waits_*. Wait until 'con2' has signaled that it is
-- actually waiting for the lock.
--connection default
SET DEBUG_SYNC='now WAIT_FOR histogram_2_lock_waiting';
SELECT OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, INDEX_NAME
  FROM performance_schema.events_waits_current
  WHERE OBJECT_TYPE = "COLUMN STATISTICS"
  ORDER BY OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, INDEX_NAME;

-- Finally let 'con1' finish building the histogram. Once 'con1' has released the
-- MDL on the column statistics object, 'con2' will continue and do its work.
SET DEBUG_SYNC='now SIGNAL continue_store_histogram';
DROP TABLE t1;
CREATE TABLE t1(col1 INT);
SET LOCAL TRANSACTION READ ONLY;
INSERT INTO t1 (col1) VALUES (1);
SET LOCAL TRANSACTION READ WRITE;
INSERT INTO t1 (col1) VALUES (1);
DROP TABLE t1;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.t1 (i INT);
INSERT INTO mysqltest.t1 VALUES (1), (2), (3);
CREATE TABLE mysqltest.t2 (j INT);
SET DEBUG_SYNC = 'rm_table_no_locks_before_binlog SIGNAL drop_waiting WAIT_FOR drop_resume';
SET DEBUG_SYNC = 'now WAIT_FOR drop_waiting';
SELECT object_type, object_schema, object_name, column_name, lock_type
  FROM performance_schema.metadata_locks
  WHERE object_schema = "mysqltest"
  ORDER BY object_type, object_schema, object_name, column_name, lock_type;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" and
        info = "ANALYZE TABLE mysqltest.t1 DROP HISTOGRAM ON i";
SET DEBUG_SYNC = 'now SIGNAL drop_resume';
SET DEBUG_SYNC = 'RESET';

-- echo --
-- echo -- Bug#35419418 CH Benchmark failing with crash in histogram code of mysql optimizer
-- echo --
-- echo -- When updating an existing string histogram we access freed memory
-- echo -- which can lead to a crash. This test updates equi-height and
-- echo -- singleton histograms twice on all supported column types.
-- echo -- Without the bugfix this test will sometimes cause a crash and will
-- echo -- produce a "heap-use-after-free" error in ASAN builds.

CREATE TABLE all_types (
  col_bool BOOLEAN,
  col_bit BIT(4),
  col_tinyint TINYINT,
  col_smallint SMALLINT,
  col_mediumint MEDIUMINT,
  col_integer INTEGER,
  col_bigint BIGINT,
  col_tinyint_unsigned TINYINT UNSIGNED,
  col_smallint_unsigned SMALLINT UNSIGNED,
  col_mediumint_unsigned MEDIUMINT UNSIGNED,
  col_integer_unsigned INTEGER UNSIGNED,
  col_bigint_unsigned BIGINT UNSIGNED,
  col_float FLOAT,
  col_double DOUBLE,
  col_decimal DECIMAL(2, 2),
  col_date DATE,
  col_time TIME,
  col_year YEAR,
  col_datetime DATETIME,
  col_timestamp TIMESTAMP NULL,
  col_char CHAR(255),
  col_varchar VARCHAR(255),
  col_tinytext TINYTEXT,
  col_text TEXT,
  col_mediumtext MEDIUMTEXT,
  col_longtext LONGTEXT,
  col_binary BINARY(255),
  col_varbinary VARBINARY(255),
  col_tinyblob TINYBLOB,
  col_blob BLOB,
  col_mediumblob MEDIUMBLOB,
  col_longblob LONGBLOB,
  col_enum ENUM('zero', 'one', 'two'),
  col_set SET('zero', 'one', 'two')
);

-- echo -- Insert 3 different values into each column (except for BOOLEAN) so
-- echo -- that we get equi-height histograms when we call UPDATE HISTOGRAM ON
-- echo -- ... WITH 2 BUCKETS and singleton histograms when we use WITH 4 BUCKETS.

INSERT INTO all_types VALUES (
  FALSE,                 -- BOOLEAN
  b'0000',               -- BIT
  0,                     -- TINYINT
  0,                     -- SMALLINT
  0,                     -- MEDIUMINT
  0,                     -- INTEGER
  0,                     -- BIGINT
  0,                     -- TINYINT_UNSIGNED
  0,                     -- SMALLINT_UNSIGNED
  0,                     -- MEDIUMINT_UNSIGNED
  0,                     -- INTEGER_UNSIGNED
  0,                     -- BIGINT_UNSIGNED
  0,                     -- FLOAT
  0,                     -- DOUBLE
  00.00,                 -- DECIMAL(2, 2)
  '1000-01-01',          -- DATE
  '00:00:00.000000',     -- TIME
  1901,                  -- YEAR
  '1000-01-01 00:00:00', -- DATETIME
  '1971-01-01 00:00:00', -- TIMESTAMP
  '0',                   -- CHAR
  '0',                   -- VARCHAR
  '0',                   -- TINYTEXT
  '0',                   -- TEXT
  '0',                   -- MEDIUMTEXT
  '0',                   -- LONGTEXT
  '0',                   -- BINARY
  '0',                   -- VARBINARY
  '0',                   -- TINYBLOB
  '0',                   -- BLOB
  '0',                   -- MEDIUMBLOB
  '0',                   -- LONGBLOB
  'zero',                 -- ENUM
  'zero'                  -- SET
);

INSERT INTO all_types VALUES (
  TRUE,                  -- BOOLEAN
  b'0001',               -- BIT
  1,                     -- TINYINT
  1,                     -- SMALLINT
  1,                     -- MEDIUMINT
  1,                     -- INTEGER
  1,                     -- BIGINT
  1,                     -- TINYINT_UNSIGNED
  1,                     -- SMALLINT_UNSIGNED
  1,                     -- MEDIUMINT_UNSIGNED
  1,                     -- INTEGER_UNSIGNED
  1,                     -- BIGINT_UNSIGNED
  1,                     -- FLOAT
  1,                     -- DOUBLE
  00.01,                 -- DECIMAL(2, 2)
  '1001-01-01',          -- DATE
  '00:00:00.000001',     -- TIME
  1902,                  -- YEAR
  '1001-01-01 00:00:00', -- DATETIME
  '1971-01-01 00:00:01', -- TIMESTAMP
  '1',                   -- CHAR
  '1',                   -- VARCHAR
  '1',                   -- TINYTEXT
  '1',                   -- TEXT
  '1',                   -- MEDIUMTEXT
  '1',                   -- LONGTEXT
  '1',                   -- BINARY
  '1',                   -- VARBINARY
  '1',                   -- TINYBLOB
  '1',                   -- BLOB
  '1',                   -- MEDIUMBLOB
  '1',                   -- LONGBLOB
  'one',                 -- ENUM
  'one'                  -- SET
);

INSERT INTO all_types VALUES (
  TRUE,                  -- BOOLEAN
  b'0010',               -- BIT
  2,                     -- TINYINT
  2,                     -- SMALLINT
  2,                     -- MEDIUMINT
  2,                     -- INTEGER
  2,                     -- BIGINT
  2,                     -- TINYINT_UNSIGNED
  2,                     -- SMALLINT_UNSIGNED
  2,                     -- MEDIUMINT_UNSIGNED
  2,                     -- INTEGER_UNSIGNED
  2,                     -- BIGINT_UNSIGNED
  2,                     -- FLOAT
  2,                     -- DOUBLE
  00.02,                 -- DECIMAL(2, 2)
  '1002-01-01',          -- DATE
  '00:00:00.000002',     -- TIME
  1903,                  -- YEAR
  '1002-01-01 00:00:00', -- DATETIME
  '1971-01-01 00:00:02', -- TIMESTAMP
  '2',                   -- CHAR
  '2',                   -- VARCHAR
  '2',                   -- TINYTEXT
  '2',                   -- TEXT
  '2',                   -- MEDIUMTEXT
  '2',                   -- LONGTEXT
  '2',                   -- BINARY
  '2',                   -- VARBINARY
  '2',                   -- TINYBLOB
  '2',                   -- BLOB
  '2',                   -- MEDIUMBLOB
  '2',                   -- LONGBLOB
  'two',                 -- ENUM
  'two'                  -- SET
);
SELECT schema_name, table_name, column_name,
JSON_EXTRACT(histogram, '$."histogram-type"') AS should_be_singleton
FROM information_schema.column_statistics;
SELECT schema_name, table_name, column_name,
JSON_EXTRACT(histogram, '$."histogram-type"') AS should_be_equiheight
FROM information_schema.column_statistics;

DROP TABLE all_types;

CREATE TABLE t(x VARCHAR(8));
INSERT INTO t VALUES ('a'), ('b'), ('c');
DROP TABLE t;

CREATE TABLE t(x INT);
INSERT INTO t VALUES (1), (2), (3);
DROP TABLE t;
