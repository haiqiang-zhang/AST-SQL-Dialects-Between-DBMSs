SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';
DROP TABLE t1;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' AND COLUMN_NAME = 'col2';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' AND COLUMN_NAME = 'col2';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1';
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
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
DROP TABLE t1;
CREATE TABLE t1(col1 INT);
INSERT INTO t1 (col1) VALUES (1);
INSERT INTO t1 (col1) VALUES (1);
DROP TABLE t1;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.t1 (i INT);
CREATE TABLE mysqltest.t2 (j INT);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" and
        info = "ANALYZE TABLE mysqltest.t1 DROP HISTOGRAM ON i";
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
INSERT INTO all_types VALUES (
  FALSE,                 # BOOLEAN
  b'0000',               # BIT
  0,                     # TINYINT
  0,                     # SMALLINT
  0,                     # MEDIUMINT
  0,                     # INTEGER
  0,                     # BIGINT
  0,                     # TINYINT_UNSIGNED
  0,                     # SMALLINT_UNSIGNED
  0,                     # MEDIUMINT_UNSIGNED
  0,                     # INTEGER_UNSIGNED
  0,                     # BIGINT_UNSIGNED
  0,                     # FLOAT
  0,                     # DOUBLE
  00.00,                 # DECIMAL(2, 2)
  '1000-01-01',          # DATE
  '00:00:00.000000',     # TIME
  1901,                  # YEAR
  '1000-01-01 00:00:00', # DATETIME
  '1971-01-01 00:00:00', # TIMESTAMP
  '0',                   # CHAR
  '0',                   # VARCHAR
  '0',                   # TINYTEXT
  '0',                   # TEXT
  '0',                   # MEDIUMTEXT
  '0',                   # LONGTEXT
  '0',                   # BINARY
  '0',                   # VARBINARY
  '0',                   # TINYBLOB
  '0',                   # BLOB
  '0',                   # MEDIUMBLOB
  '0',                   # LONGBLOB
  'zero',                 # ENUM
  'zero'                  # SET
);
INSERT INTO all_types VALUES (
  TRUE,                  # BOOLEAN
  b'0001',               # BIT
  1,                     # TINYINT
  1,                     # SMALLINT
  1,                     # MEDIUMINT
  1,                     # INTEGER
  1,                     # BIGINT
  1,                     # TINYINT_UNSIGNED
  1,                     # SMALLINT_UNSIGNED
  1,                     # MEDIUMINT_UNSIGNED
  1,                     # INTEGER_UNSIGNED
  1,                     # BIGINT_UNSIGNED
  1,                     # FLOAT
  1,                     # DOUBLE
  00.01,                 # DECIMAL(2, 2)
  '1001-01-01',          # DATE
  '00:00:00.000001',     # TIME
  1902,                  # YEAR
  '1001-01-01 00:00:00', # DATETIME
  '1971-01-01 00:00:01', # TIMESTAMP
  '1',                   # CHAR
  '1',                   # VARCHAR
  '1',                   # TINYTEXT
  '1',                   # TEXT
  '1',                   # MEDIUMTEXT
  '1',                   # LONGTEXT
  '1',                   # BINARY
  '1',                   # VARBINARY
  '1',                   # TINYBLOB
  '1',                   # BLOB
  '1',                   # MEDIUMBLOB
  '1',                   # LONGBLOB
  'one',                 # ENUM
  'one'                  # SET
);
INSERT INTO all_types VALUES (
  TRUE,                  # BOOLEAN
  b'0010',               # BIT
  2,                     # TINYINT
  2,                     # SMALLINT
  2,                     # MEDIUMINT
  2,                     # INTEGER
  2,                     # BIGINT
  2,                     # TINYINT_UNSIGNED
  2,                     # SMALLINT_UNSIGNED
  2,                     # MEDIUMINT_UNSIGNED
  2,                     # INTEGER_UNSIGNED
  2,                     # BIGINT_UNSIGNED
  2,                     # FLOAT
  2,                     # DOUBLE
  00.02,                 # DECIMAL(2, 2)
  '1002-01-01',          # DATE
  '00:00:00.000002',     # TIME
  1903,                  # YEAR
  '1002-01-01 00:00:00', # DATETIME
  '1971-01-01 00:00:02', # TIMESTAMP
  '2',                   # CHAR
  '2',                   # VARCHAR
  '2',                   # TINYTEXT
  '2',                   # TEXT
  '2',                   # MEDIUMTEXT
  '2',                   # LONGTEXT
  '2',                   # BINARY
  '2',                   # VARBINARY
  '2',                   # TINYBLOB
  '2',                   # BLOB
  '2',                   # MEDIUMBLOB
  '2',                   # LONGBLOB
  'two',                 # ENUM
  'two'                  # SET
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
