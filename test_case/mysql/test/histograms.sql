CREATE TABLE all_types (
  col_bool BOOLEAN,
  col_bit BIT(64),
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
  col_decimal DECIMAL(65, 2),
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
  col_enum ENUM('red', 'black', 'pink', 'white', 'purple'),
  col_set SET('one', 'two', 'three'));
INSERT INTO all_types VALUES (
  NULL,     -- BOOLEAN
  NULL,     -- BIT
  NULL,     -- TINYINT
  NULL,     -- SMALLINT
  NULL,     -- MEDIUMINT
  NULL,     -- INTEGER
  NULL,     -- BIGINT
  NULL,     -- TINYINT_UNSIGNED
  NULL,     -- SMALLINT_UNSIGNED
  NULL,     -- MEDIUMINT_UNSIGNED
  NULL,     -- INTEGER_UNSIGNED
  NULL,     -- BIGINT_UNSIGNED
  NULL,     -- FLOAT
  NULL,     -- DOUBLE
  NULL,     -- DECIMAL(65, 2)
  NULL,     -- DATE
  NULL,     -- TIME
  NULL,     -- YEAR
  NULL,     -- DATETIME
  NULL,     -- TIMESTAMP
  NULL,     -- CHAR
  NULL,     -- VARCHAR
  NULL,     -- TINYTEXT
  NULL,     -- TEXT
  NULL,     -- MEDIUMTEXT
  NULL,     -- LONGTEXT
  NULL,     -- BINARY
  NULL,     -- VARBINARY
  NULL,     -- TINYBLOB
  NULL,     -- BLOB
  NULL,     -- MEDIUMBLOB
  NULL,     -- LONGBLOB
  NULL,     -- ENUM
  NULL);

INSERT INTO all_types VALUES (
  FALSE,                                                               -- BOOLEAN
  b'0000000000000000000000000000000000000000000000000000000000000000', -- BIT
  -128,                                                                -- TINYINT
  -32768,                                                              -- SMALLINT
  -8388608,                                                            -- MEDIUMINT
  -2147483648,                                                         -- INTEGER
  -9223372036854775808,                                                -- BIGINT
  0,                                                                   -- TINYINT_UNSIGNED
  0,                                                                   -- SMALLINT_UNSIGNED
  0,                                                                   -- MEDIUMINT_UNSIGNED
  0,                                                                   -- INTEGER_UNSIGNED
  0,                                                                   -- BIGINT_UNSIGNED
  -3.402823466E+38,                                                    -- FLOAT
  -1.7976931348623157E+308,                                            -- DOUBLE
  -999999999999999999999999999999999999999999999999999999999999999.99, -- DECIMAL(65, 2)
  '1000-01-01',                                                        -- DATE
  '-838:59:59.000000',                                                 -- TIME
  1901,                                                                -- YEAR
  '1000-01-01 00:00:00',                                               -- DATETIME
  '1970-01-02 00:00:01',                                               -- TIMESTAMP
  '',                                                                  -- CHAR
  '',                                                                  -- VARCHAR
  '',                                                                  -- TINYTEXT
  '',                                                                  -- TEXT
  '',                                                                  -- MEDIUMTEXT
  '',                                                                  -- LONGTEXT
  '',                                                                  -- BINARY
  '',                                                                  -- VARBINARY
  '',                                                                  -- TINYBLOB
  '',                                                                  -- BLOB
  '',                                                                  -- MEDIUMBLOB
  '',                                                                  -- LONGBLOB
  'red',                                                               -- ENUM
  '');

INSERT INTO all_types VALUES (
  TRUE,                                                                -- BOOLEAN
  b'1111111111111111111111111111111111111111111111111111111111111111', -- BIT
  127,                                                                 -- TINYINT
  32767,                                                               -- SMALLINT
  8388607,                                                             -- MEDIUMINT
  2147483647,                                                          -- INTEGER
  9223372036854775807,                                                 -- BIGINT
  255,                                                                 -- TINYINT_UNSIGNED
  65535,                                                               -- SMALLINT_UNSIGNED
  16777215,                                                            -- MEDIUMINT_UNSIGNED
  4294967295,                                                          -- INTEGER_UNSIGNED
  18446744073709551615,                                                -- BIGINT_UNSIGNED
  3.402823466E+38,                                                     -- FLOAT
  1.7976931348623157E+308,                                             -- DOUBLE
  999999999999999999999999999999999999999999999999999999999999999.99,  -- DECIMAL(65, 2)
  '9999-12-31',                                                        -- DATE
  '838:59:59.000000',                                                  -- TIME
  2155,                                                                -- YEAR
  '9999-12-31 23:59:59',                                               -- DATETIME
  '2038-01-19 03:14:07',                                               -- TIMESTAMP
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- CHAR
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- VARCHAR
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- TINYTEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- TEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- MEDIUMTEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- LONGTEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- BINARY
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- VARBINARY
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- TINYBLOB
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- BLOB
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- MEDIUMBLOB
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     -- LONGBLOB
  'purple',                                                            -- ENUM
  'three');


SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;

SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
                                            col_bit,
                                            col_tinyint,
                                            col_smallint,
                                            col_mediumint,
                                            col_integer,
                                            col_bigint,
                                            col_tinyint_unsigned,
                                            col_smallint_unsigned,
                                            col_mediumint_unsigned,
                                            col_integer_unsigned,
                                            col_bigint_unsigned,
                                            col_float,
                                            col_double,
                                            col_decimal,
                                            col_date,
                                            col_time,
                                            col_year,
                                            col_datetime,
                                            col_timestamp,
                                            col_char,
                                            col_varchar,
                                            col_tinytext,
                                            col_text,
                                            col_mediumtext,
                                            col_longtext,
                                            col_binary,
                                            col_varbinary,
                                            col_tinyblob,
                                            col_blob,
                                            col_mediumblob,
                                            col_longblob,
                                            col_enum,
                                            col_set WITH 1024 BUCKETS;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE all_types;

SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE unsupported_types (col_geometry GEOMETRY,
                                col_point POINT,
                                col_linestring LINESTRING,
                                col_polygon POLYGON,
                                col_multipoint MULTIPOINT,
                                col_multilinestring MULTILINESTRING,
                                col_multipolygon MULTIPOLYGON,
                                col_geometrycollection GEOMETRYCOLLECTION,
                                col_json JSON);
                                                    col_point,
                                                    col_linestring,
                                                    col_polygon,
                                                    col_multipoint,
                                                    col_multilinestring,
                                                    col_multipolygon,
                                                    col_geometrycollection,
                                                    col_json WITH 100 BUCKETS;

SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;

DROP TABLE unsupported_types;

CREATE TABLE t1 (col_integer INT);
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TEMPORARY TABLE temp_table (col1 INT);
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
DROP TABLE temp_table;
CREATE VIEW my_view AS SELECT * FROM t1;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
DROP VIEW my_view;
ALTER TABLE t1 ADD COLUMN virtual_generated INT AS (col_integer + 10) VIRTUAL,
               ADD COLUMN stored_generated INT AS (col_integer + 20) STORED;
INSERT INTO t1 (col_integer) VALUES (10), (20), (30);
                                     virtual_generated,
                                     stored_generated
                 WITH 100 BUCKETS;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 DROP COLUMN virtual_generated, DROP COLUMN stored_generated;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DELETE FROM t1;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
SELECT schema_name, table_name, column_name,
       JSON_EXTRACT(histogram, '$."histogram-type"') AS should_be_singleton
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name,
       JSON_EXTRACT(histogram, '$."histogram-type"') AS should_be_equiheight
FROM information_schema.COLUMN_STATISTICS;

DROP TABLE t1;
CREATE TABLE t1 (col1 INT PRIMARY KEY,
                 col2 INT,
                 col3 INT,
                 UNIQUE INDEX index_1 (col2),
                 UNIQUE INDEX index_2 (col3, col2));
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 ALTER INDEX index_1 INVISIBLE;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 SELECT 1;
INSERT INTO t1 SELECT col1 + 1 FROM t1;
INSERT INTO t1 SELECT col1 + 2 FROM t1;
INSERT INTO t1 SELECT col1 + 4 FROM t1;
INSERT INTO t1 SELECT col1 + 8 FROM t1;
INSERT INTO t1 SELECT col1 + 16 FROM t1;
INSERT INTO t1 SELECT col1 + 32 FROM t1;
INSERT INTO t1 SELECT col1 + 64 FROM t1;
INSERT INTO t1 SELECT col1 + 128 FROM t1;
SELECT JSON_LENGTH(histogram->'$.buckets') <= 10
FROM information_schema.COLUMN_STATISTICS
WHERE schema_name = 'test' AND table_name = 't1' AND column_name = 'col1';
SELECT JSON_LENGTH(histogram->'$.buckets') <= 57
FROM information_schema.COLUMN_STATISTICS
WHERE schema_name = 'test' AND table_name = 't1' AND column_name = 'col1';
SELECT JSON_LENGTH(histogram->'$.buckets') <= 255
FROM information_schema.COLUMN_STATISTICS
WHERE schema_name = 'test' AND table_name = 't1' AND column_name = 'col1';

DROP TABLE t1;

CREATE TABLE t1 (c1 INT);
INSERT INTO t1 (c1) VALUES (10), (20), (30);
CREATE TABLE t2 (c2 INT);
INSERT INTO t2 (c2) VALUES (10), (20), (30);
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLES t1, t2;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;

CREATE TABLE t1 (col1 INT, col2 VARCHAR(255));
INSERT INTO t1 VALUES (1, "1"), (2, "2"), (3, "3"), (4, "4"), (5, "5"),
                      (6, "6"), (7, "7"), (8, "8"), (9, "9"), (10, "10");
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
CREATE TEMPORARY TABLE temp_table (col1 INT);
DROP TABLE temp_table;
CREATE TABLE t2 (col1 INT);

DROP TABLE t1, t2;

CREATE TABLE t1 (c1 INT);
INSERT INTO t1 (c1) VALUES (10), (20), (30);
CREATE TABLE t2 (c2 INT);
INSERT INTO t2 (c2) VALUES (10), (20), (30);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLES t1, t2;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE t1 (col1 INT);

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE t1 (col1 INT, col2 INT);

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 CHANGE COLUMN col1 col1_renamed INT;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 CHANGE COLUMN col2 col2 VARCHAR(255);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 DROP COLUMN col2;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
INSERT INTO t1 VALUES (1), (2);
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1_renamed RENAME TO t1;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 RENAME TO t1_renamed, ALGORITHM = INPLACE;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1_renamed RENAME TO t1, ALGORITHM = COPY;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE t1 (col1 VARCHAR(255), col2 VARCHAR(255));
INSERT INTO t1 VALUES ('foo', 'foo'), ('bar', 'bar'), ('fo', 'fo'),
                      ('yay', 'yay');
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1_renamed;
CREATE DATABASE histogram_db;
CREATE TABLE histogram_db.t1 (col1 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP DATABASE histogram_db;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE t1 (col1 VARCHAR(255), col2 CHAR(10), col3 TEXT, col4 INT,
                 col5 BLOB) CHARACTER SET latin1;
                 WITH 10 BUCKETS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb4;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
                 WITH 10 BUCKETS;
ALTER TABLE t1 MODIFY COLUMN col1 VARCHAR(255) CHARACTER SET latin1;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 ADD COLUMN col2 INT;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 DROP COLUMN col2;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

DROP TABLE t1;
CREATE TABLE t1 (col1 INT, col2 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 DROP COLUMN COL1;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

DROP TABLE t1;
CREATE TABLE t(x INT);
DROP TABLE t;
CREATE TABLE t1 (col1 INT, col2 INT, col3 INT, col4 INT, col5 INT, col6 INT);
                 WITH 4 BUCKETS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 ADD UNIQUE INDEX (col1);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 ADD UNIQUE INDEX (col2), ALGORITHM = INPLACE;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 ADD UNIQUE INDEX (col3), ALGORITHM = COPY;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 ADD PRIMARY KEY (col4);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 ADD UNIQUE INDEX (col5, col6);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

CREATE UNIQUE INDEX index_col5 ON t1 (col5);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
CREATE INDEX index_col6 ON t1 (col6);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

ALTER TABLE t1 MODIFY COLUMN col6 INT UNIQUE;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SET GLOBAL read_only = 1;
SET GLOBAL read_only = 0;

DROP TABLE t1;
CREATE TABLE t1 (
c1 int(11) DEFAULT NULL,
c2 int(11) GENERATED ALWAYS AS ((c1 * 2)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT into t1(c1) VALUES (1);
ALTER TABLE t1 ADD UNIQUE INDEX i (c2);
ALTER TABLE t1 DROP KEY i;
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
ALTER TABLE t1 DROP COLUMN foobar, CHANGE COLUMN col1 col2 INT;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE foo (col1 INT,
                  col2 INT AS (col1 + 1) VIRTUAL,
                  col3 INT AS (col2 + 1) VIRTUAL);
INSERT INTO foo (col1) VALUES (1);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE foo;

CREATE TABLE t1 (col1 INT);
INSERT INTO t1 SELECT 1;
INSERT INTO t1 SELECT col1 + 1 FROM t1;
INSERT INTO t1 SELECT col1 + 2 FROM t1;
INSERT INTO t1 SELECT col1 + 4 FROM t1;
INSERT INTO t1 SELECT col1 + 8 FROM t1;
INSERT INTO t1 SELECT col1 + 16 FROM t1;
INSERT INTO t1 SELECT col1 + 32 FROM t1;
INSERT INTO t1 SELECT col1 + 64 FROM t1;
INSERT INTO t1 SELECT col1 + 128 FROM t1;
INSERT INTO t1 SELECT col1 + 256 FROM t1 LIMIT 38;
INSERT INTO t1 SELECT NULL;
DROP TABLE t1;
CREATE TABLE p (col1 INT PRIMARY KEY, col2 INT, col3 INT)
               PARTITION BY KEY (col1) PARTITIONS 4;
INSERT INTO p VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3);
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE p PARTITION BY HASH (col1) PARTITIONS 2;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE p;
CREATE SCHEMA foo;
CREATE SCHEMA bar;
CREATE TABLE foo.tbl (col1 INT);
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
DROP SCHEMA foo;
DROP SCHEMA bar;

CREATE TABLE not_encrypted1 (col1 INT) ENCRYPTION='n';
CREATE TABLE not_encrypted2 (col1 INT) ENCRYPTION='N';
CREATE TABLE encrypted1 (col1 INT) ENCRYPTION='y';
CREATE TABLE encrypted2 (col1 INT) ENCRYPTION='Y';

INSERT INTO not_encrypted1 VALUES (1);
INSERT INTO not_encrypted2 VALUES (1);
INSERT INTO encrypted1 VALUES (1);
INSERT INTO encrypted2 VALUES (1);

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE not_encrypted1 ENCRYPTION='y';
ALTER TABLE not_encrypted2 ENCRYPTION='Y';

SELECT schema_name, table_name, column_name
FROM information_schema.COLUMN_STATISTICS;

DROP TABLE encrypted1;
DROP TABLE not_encrypted1;
DROP TABLE encrypted2;
DROP TABLE not_encrypted2;
CREATE TABLE t1 (i INT, at INT, k INT) ENGINE=InnoDB;
CREATE TRIGGER ai AFTER INSERT ON t1 FOR EACH ROW SET @a:= NEW.at;
ALTER TABLE t1 ADD PRIMARY KEY (i);
DROP TABLE t1;
CREATE TABLE ftidx_encrypted (a VARCHAR(255), FULLTEXT ftidx(a))
             ENGINE=InnoDB ENCRYPTION='N';
ALTER TABLE ftidx_encrypted RENAME TO ftidx_encrypted_renamed, KEY_BLOCK_SIZE=0;
DROP TABLE ftidx_encrypted_renamed;
CREATE TABLE t1 (
  ten int(11) DEFAULT NULL,
  twenty int(11) DEFAULT NULL,
  forty int(11) DEFAULT NULL,
  eighty int(11) DEFAULT NULL,
  KEY idx3 (twenty,ten),
  KEY idx (ten)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO t1 VALUES
(6,16,36,76), (5,15,35,35), (9,19,39,79), (1,1,1,41), (7,17,17,17),
(3,13,33,73), (7,17,37,37), (1,1,1,1), (9,9,9,9), (0,0,20,60), (5,15,35,75),
(0,10,10,10), (3,3,3,3), (8,8,8,48), (8,18,38,38), (8,8,28,28), (3,13,33,33),
(7,7,7,7), (2,2,22,62), (0,0,0,40), (0,0,0,0), (2,12,12,52), (6,6,6,6),
(9,19,19,19), (5,15,15,15), (5,5,5,5), (5,5,25,65), (4,14,14,14), (3,3,23,23),
(4,4,4,44), (4,14,34,74), (6,6,26,26), (7,17,17,57), (7,17,17,17), (8,18,18,18),
(1,11,11,11), (4,4,4,4), (4,4,24,24), (8,18,18,18), (1,11,11,51), (7,7,27,27),
(8,8,8,8), (9,9,29,29), (7,7,7,47), (1,1,1,1), (5,5,25,25), (4,4,24,64),
(9,9,29,69), (0,10,10,10), (9,9,9,49);
        WHERE a.twenty = b.ten AND b.eighty >= (3 + 20);
DROP TABLE t1;
CREATE TABLE `t1` (
  `two` blob,
  `ten` blob,
  `sixty` text,
  `eighty` blob,
  `tenPercent` text
) DEFAULT CHARSET=utf8mb4;
INSERT INTO `t1` VALUES
('0','6','16','76','6'), ('1','5','35','35','5'), ('1','9','19','79','9'),
('1','1','41','41','1'), ('1','7','37','17','7'), ('1','3','13','73','3'),
('1','7','37','37','7'), ('1','1','1','1','1'), ('1','9','29','9','9'),
('0','0','0','60','0'), ('1','5','15','75','5'), ('0','0','10','10','0'),
('1','3','3','3','3'), ('0','8','48','48','8'), ('0','8','38','38','8'),
('0','8','28','28','8'), ('1','3','33','33','3'), ('1','7','7','7','7'),
('0','2','2','62','2'), ('0','0','40','40','0'), ('0','0','20','0','0'),
('0','2','52','52','2'), ('0','6','26','6','6'), ('1','9','19','19','9'),
('1','5','15','15','5'), ('1','5','25','5','5'), ('1','5','5','65','5'),
('0','4','14','14','4'), ('1','3','23','23','3'), ('0','4','44','44','4'),
('0','4','14','74','4'), ('0','6','26','26','6'), ('1','7','57','57','7'),
('1','7','17','17','7'), ('0','8','18','18','8'), ('1','1','11','11','1'),
('0','4','24','4','4'), ('0','4','24','24','4'), ('0','8','38','18','8'),
('1','1','51','51','1'), ('1','7','27','27','7'), ('0','8','8','8','8'),
('1','9','29','29','9'), ('1','7','47','47','7'), ('1','1','21','1','1'),
('1','5','25','25','5'), ('0','4','4','64','4'), ('1','9','9','69','9'),
('0','0','30','10','0'), ('1','9','49','49','9'), ('0','6','36','36','6'),
('0','0','20','20','0'), ('0','2','2','2','2'), ('1','1','1','61','1'),
('0','8','28','8','8'), ('0','2','42','42','2'), ('0','2','12','72','2'),
('0','6','6','66','6'), ('1','7','7','67','7'), ('0','8','8','68','8'),
('0','4','34','14','4'), ('0','4','4','4','4'), ('0','6','6','6','6'),
('0','6','16','16','6'), ('1','7','17','77','7'), ('0','8','18','78','8'),
('0','2','22','22','2'), ('0','0','0','0','0'), ('1','9','9','9','9'),
('1','9','39','39','9'), ('1','7','27','7','7'), ('0','2','32','32','2'),
('1','1','31','11','1'), ('0','2','12','12','2'), ('0','4','54','54','4'),
('0','4','34','34','4'), ('1','1','21','21','1'), ('1','3','33','13','3'),
('0','6','56','56','6'), ('1','1','11','71','1'), ('1','3','53','53','3'),
('0','0','10','70','0'), ('0','6','36','16','6'), ('1','5','55','55','5'),
('0','2','22','2','2'), ('1','5','45','45','5'), ('1','3','43','43','3'),
('0','2','32','12','2'), ('1','1','31','31','1'), ('0','0','50','50','0'),
('1','3','13','13','3'), ('1','5','35','15','5'), ('1','9','59','59','9'),
('1','5','5','5','5'), ('0','6','46','46','6'), ('0','0','30','30','0'),
('0','8','58','58','8'), ('1','3','23','3','3'), ('1','3','3','63','3'),
('1','9','39','19','9'), ('1','3','44',NULL,'5'), ('1','7','38',NULL,'6'),
('1','1','52','64','6'), ('1','6','39',NULL,'0'), ('1','7','44','48','6'),
('0','8','42',NULL,'6'), ('0','0','7',NULL,'9'), ('1','0','45',NULL,'1'),
('1','5','40','32','0'), ('0','3','52',NULL,'3'), ('1','1','8','48','2'),
('0','3','20','16','2'), ('0','2','15',NULL,'6'), ('1','6','48','48','8'),
('0','5','31',NULL,'7'), ('0','6','20','0','4'), ('0','2','12','16','6'),
('0','4','20','64','4'), ('0','6','56','48','8'), ('0','2','40','16','4'),
('0','2','52','48','6'), ('1','9','25',NULL,'0'), ('0','0','12',NULL,'1'),
('0','1','0','64','8'), ('1','4','48','32','6'), ('1','2','0','0','4'),
('0','5','52','64','8'), ('0','8','44','48','2'), ('0','8','40','0','2'),
('0','6','8',NULL,'6'), ('1','1','24','16','6'), ('0','6','44','0','4'),
('1','1','36','0','2'), ('1','0','39',NULL,'7'), ('0','0','8','32','8'),
('0','2','16','32','0'), ('0','5','8','64','4'), ('0','9','38',NULL,'9'),
('1','7','32','48','4'), ('0','3','8','48','4'), ('1','8','32',NULL,'5'),
('1','3','12','32','0'), ('0','3','24','16','6'), ('0','3','53',NULL,'3'),
('1','6','44','32','8'), ('1','0','4','32','2'), ('1','4','4','48','8'),
('1','8','8',NULL,'5'), ('1','6','16',NULL,'2'), ('0','7','20','64','8'),
('0','2','55',NULL,'6'), ('0','8','5',NULL,'1'), ('1','9','36','48','8'),
('1','3','20','32','2'), ('0','0','56','0','6'), ('1','4','25',NULL,'2'),
('0','3','0',NULL,'9'), ('1','1','32',NULL,'5'), ('0','4','32',NULL,'0'),
('0','9','4','0','2'), ('1','9','36','64','8'), ('0','3','48','16','4'),
('0','9','12','0','0'), ('1','4','39',NULL,'6'), ('0','5','16','16','6'),
('0','2','17',NULL,'3'), ('1','9','52','0','8'), ('1','2','28',NULL,'3'),
('1','5','28','32','8'), ('1','4','0','48','8'), ('1','4','39',NULL,'7'),
('1','3','16',NULL,'6'), ('0','3','17',NULL,'4'), ('1','2','18',NULL,'9'),
('0','6','52','16','2'), ('1','1','15',NULL,'7'), ('0','5','4','64','6'),
('0','6','48','64','8'), ('0','7','56',NULL,'0'), ('1','0','28',NULL,'9'),
('0','4','40','32','8'), ('1','9','52','0','6'), ('1','4','30',NULL,'3'),
('0','8','8',NULL,'0'), ('0','6','0','64','8'), ('0','6','38',NULL,'9'),
('0','0','52','64','0'), ('0','5','39',NULL,'3'), ('0','0','52','16','0'),
('0','5','8','64','0'), ('1','1','44','16','0'), ('0','4','52',NULL,'2'),
('0','9','0',NULL,'3'), ('0','3','36','64','2'), ('0','3','52','16','8'),
('1','5','4','16','2'), ('0','9','58',NULL,'9');

UPDATE mysql.innodb_table_stats SET n_rows = 197
WHERE database_name = "test" AND table_name = "t1";
        WHERE a.ten = b.sixty AND b.tenPercent < (9 + (5*10));

DROP TABLE t1;
CREATE TABLE t1 (
  tenPercent int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO t1 VALUES (6),(5),(9),(1),(7);

UPDATE mysql.innodb_table_stats SET n_rows = 5
WHERE database_name = "test" AND table_name = "t1";

DROP TABLE t1;
CREATE TABLE k (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_255_utf8 varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_varchar_10_utf8_key varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_varchar_10_latin1 varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_255_utf8_key varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_varchar_255_latin1 varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_varchar_255_latin1_key varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_10_latin1_key varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_varchar_10_utf8 varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_10_utf8_key (col_varchar_10_utf8_key),
  KEY col_varchar_255_utf8_key (col_varchar_255_utf8_key),
  KEY col_int_key (col_int_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_date_key (col_date_key),
  KEY col_varchar_255_latin1_key (col_varchar_255_latin1_key),
  KEY col_varchar_10_latin1_key (col_varchar_10_latin1_key)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;
INSERT INTO k VALUES (1,
                      'wrhhsy',
                      'rhgpwcrafs',
                      'hgpwcrafsb',
                      'i',
                      NULL,
                      'gpwcrafsbt',
                      '1000-01-01 00:00:00',
                      '1000-01-01',
                      'n',
                      'LUWOS',
                      '1000-01-01',
                      NULL,
                      'pwcrafsbtn',
                      '2002-08-22 03:35:28');

CREATE TABLE a (
  col_datetime_key datetime DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_varchar_10_utf8_key varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_varchar_255_latin1 varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_10_latin1_key varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_10_latin1 varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_10_utf8 varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_255_utf8_key varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_varchar_255_utf8 varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_varchar_255_latin1_key varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_datetime_key (col_datetime_key),
  KEY col_varchar_10_utf8_key (col_varchar_10_utf8_key),
  KEY col_varchar_10_latin1_key (col_varchar_10_latin1_key),
  KEY col_varchar_255_utf8_key (col_varchar_255_utf8_key),
  KEY col_int_key (col_int_key),
  KEY col_date_key (col_date_key),
  KEY col_varchar_255_latin1_key (col_varchar_255_latin1_key)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
INSERT INTO a VALUES (NULL,
                      '2008-10-25 07:07:49',
                      'BXLIC',
                      'GSDDY',
                      'w',
                      'crbhsozfbh',
                      's',
                      1,
                      'the',
                      '2005-04-01',
                      104529920,
                      '1000-01-01',
                      NULL,
                      'like',
                      'CGLFP');

CREATE TABLE g (
  col_varchar_10_latin1 varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_varchar_255_latin1_key varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_10_utf8 varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_varchar_255_latin1 varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  col_varchar_255_utf8 varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_varchar_10_utf8_key varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_varchar_10_latin1_key varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_255_utf8_key varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_255_latin1_key (col_varchar_255_latin1_key),
  KEY col_date_key (col_date_key),
  KEY col_int_key (col_int_key),
  KEY col_varchar_10_utf8_key (col_varchar_10_utf8_key),
  KEY col_varchar_10_latin1_key (col_varchar_10_latin1_key),
  KEY col_varchar_255_utf8_key (col_varchar_255_utf8_key),
  KEY col_datetime_key (col_datetime_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
INSERT INTO g VALUES ('o',
                      '2009-05-15 00:00:00',
                      'PFJGE',
                      'ASUNU',
                      'yj',
                      'if',
                      '1000-01-01',
                      '2001-04-06',
                      4,
                      -1442512896,
                      'm',
                      'his',
                      1,
                      'I',
                      '2007-05-11 00:00:00');
        LEFT OUTER JOIN  a AS alias2
        RIGHT OUTER JOIN g AS alias3  ON  alias2 . col_varchar_255_utf8_key =  alias3 . col_varchar_10_utf8
                                      ON  alias1 . col_varchar_10_latin1 =  alias3 . col_varchar_255_latin1
        LEFT OUTER JOIN g AS alias4  ON  alias1 . col_varchar_255_utf8_key =  alias4 . col_varchar_255_utf8_key
        WHERE  alias2 . pk = 3   ORDER BY field1;

DROP TABLE a, k, g;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1), (2), (3);
UPDATE mysql.innodb_table_stats SET n_rows = 3
WHERE database_name = "test" AND table_name = "t1";
DROP TABLE t1;
CREATE TABLE table1 (
  col_datetime_key datetime DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_date date DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_blob_key blob,
  col_time_key time DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_blob blob,
  PRIMARY KEY (pk),
  KEY col_datetime_key (col_datetime_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_time_key (col_time_key),
  KEY col_varchar_key (col_varchar_key),
  KEY col_date_key (col_date_key),
  KEY test_idx (col_int_key,col_int)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
INSERT INTO table1 VALUES ('2000-09-05 00:00:00',
                      '2003-11-25 11:17:04',
                      1,
                      '2006-02-27',
                      '00:20:06',
                      'l',
                      1,
                      'uajnlnsnzyo',
                      '23:18:41',
                      7,
                      'a',
                      '2001-02-18',
                      'jn');

CREATE TABLE table2 (
  col_time_key time DEFAULT NULL,
  col_blob_key blob,
  col_int int(11) DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_blob blob,
  col_date_key date DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_time_key (col_time_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_datetime_key (col_datetime_key),
  KEY col_date_key (col_date_key),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key),
  KEY test_idx (col_int_key,pk)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
INSERT INTO table2 VALUES ('10:39:59',
                       'tymjpskqjjap',
                       9,
                       '2006-07-17 08:29:28',
                       'y',
                       '2002-10-02',
                       '00:20:00',
                       'mjpskqjjapldefot',
                       '2008-11-12',
                       3,
                       1,
                       NULL,
                       '2009-03-19 00:00:00');

CREATE TABLE table3 (
  col_int_key int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_datetime_key datetime DEFAULT NULL,
  col_blob blob,
  col_blob_key blob,
  col_int int(11) DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_date date DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_varchar_key (col_varchar_key),
  KEY col_time_key (col_time_key),
  KEY col_date_key (col_date_key)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
INSERT INTO table3 VALUES (6,
                      '2003-08-27 00:00:00',
                      1,
                      '2002-07-10 12:41:35',
                      NULL,
                      'xgtmzjkhjqplanraxafy',
                      5,
                      '05:20:53',
                      'q',
                      'g',
                      '00:30:27',
                      '2008-11-18',
                      '2008-05-26');

CREATE TABLE table4 (
  col_datetime datetime DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_blob blob,
  col_blob_key blob,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_datetime_key datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_time_key (col_time_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_varchar_key (col_varchar_key),
  KEY col_date_key (col_date_key),
  KEY col_datetime_key (col_datetime_key),
  KEY test_idx (pk,col_int_key)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
INSERT INTO table4 VALUES ('2009-05-17 00:00:00',
                      '00:20:03',
                      '00:20:04',
                      'u',
                      6,
                      '2008-02-12',
                      0,
                      'orecqsomotqciisj',
                      'recqsomotqciisjzx',
                      'e',
                      '2005-03-21',
                      1,
                      '2009-11-16 02:30:22');

CREATE VIEW view_BB AS SELECT * FROM table2;
CREATE VIEW view_A AS SELECT * FROM table1;
SELECT alias2 . col_time AS field1
FROM  view_BB AS alias1  LEFT  JOIN view_A AS alias2
ON  alias1 . col_varchar =  alias2 . col_varchar_key
WHERE  alias2 . col_int_key > 2 AND alias2 . col_int_key < ( 5 + 1 )
ORDER BY field1
LIMIT 1000 OFFSET 35)
UPDATE table3 AS OUTR1, table4 AS OUTR2, cte AS OUTRcte, cte AS OUTRcte1
SET OUTR1.col_varchar_key = 'hey'
WHERE OUTRcte . field1 <> 3;

DROP VIEW view_BB, view_A;
DROP TABLE table1, table2, table3, table4;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);

DROP TABLE t1;
CREATE TABLE t1 (col1 BIGINT);
INSERT INTO t1 VALUES (-8454100925504552960), (-3300857051885862912), (0), (0),
(0), (0), (0), (2), (2), (2), (6), (16), (56), (86), (142), (191), (7294),
(16729), (22243), (23035), (23731), (23807), (39158), (51338),
(762515711909167104), (1976517286462226432), (5793317970658721792),
(6453095316068499456), (7648519542158655488), (8601593813300936704);
DROP TABLE t1;
CREATE TABLE t1 (col1 VARCHAR(255));
INSERT INTO t1 VALUES ("c"), ("f"), ("get"), ("going"), ("look"), ("MOZVN"),
("n"), ("NJAOC"), ("o"), ("on"), ("qnqzklkafp"), ("say"), ("sckaeiqnqz"),
("the"), ("there"), ("VXPRU"), ("w"), ("WBQDQ"), ("your"), ("ZHZXW");

DROP TABLE t1;

CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1), (2), (3);
DELETE FROM t1;
INSERT INTO t1 VALUES (4), (5), (6);
DROP TABLE t1;
SET @@SESSION.sql_mode='';
CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) NOT NULL,
  col_int_key int(11) GENERATED ALWAYS AS ((col_int + col_int)) VIRTUAL,
  col_date date NOT NULL,
  col_date_key date GENERATED ALWAYS AS ((col_date + interval 30 day))
VIRTUAL,
  col_datetime datetime NOT NULL,
  col_time time NOT NULL,
  col_datetime_key datetime GENERATED ALWAYS AS
(addtime(col_datetime,col_time)) VIRTUAL,
  col_time_key time GENERATED ALWAYS AS (addtime(col_datetime,col_time))
VIRTUAL,
  col_varchar varchar(1) NOT NULL,
  col_varchar_key varchar(2) GENERATED ALWAYS AS
(concat(col_varchar,col_varchar)) VIRTUAL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;
INSERT INTO t1 (pk, col_int, col_date, col_datetime, col_time, col_varchar)
VALUES (10,8,'2006-08-19','2001-07-04
14:30:59','23:33:39','v'),(11,8,'2006-08-13','2006-12-15
06:22:01','11:50:10','j'),(12,9,'2008-05-12','2002-06-19
14:43:00','07:14:03','h'),(13,0,'2003-07-05','2005-08-19
04:46:53','18:13:22','q'),(14,1,'2003-10-21','2007-05-14
06:19:04','00:00:00','g'),(29,1,'2008-12-24','2004-04-02
07:16:01','16:30:10','e');

CREATE TABLE t2 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) NOT NULL,
  col_int_key int(11) GENERATED ALWAYS AS ((col_int + col_int)) VIRTUAL,
  col_date date NOT NULL,
  col_date_key date GENERATED ALWAYS AS ((col_date + interval 30 day))
VIRTUAL,
  col_datetime datetime NOT NULL,
  col_time time NOT NULL,
  col_datetime_key datetime GENERATED ALWAYS AS
(addtime(col_datetime,col_time)) VIRTUAL,
  col_time_key time GENERATED ALWAYS AS (addtime(col_datetime,col_time))
VIRTUAL,
  col_varchar varchar(1) NOT NULL,
  col_varchar_key varchar(2) GENERATED ALWAYS AS
(concat(col_varchar,col_varchar)) VIRTUAL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
INSERT INTO t2 (pk, col_int, col_date, col_datetime, col_time, col_varchar)
VALUES (1,2,'2002-10-13','1900-01-01
00:00:00','00:00:00','s'),(2,4,'1900-01-01','2005-08-15
00:00:00','15:57:25','r'),(3,8,'0000-00-00','1900-01-01
00:00:00','07:05:51','m'),(4,4,'2006-03-09','2008-05-16
08:09:06','19:22:21','b'),(5,4,'2001-06-05','2001-01-20
12:47:23','03:53:16','x'),(6,7,'2006-05-28','2008-07-02
00:00:00','09:16:38','g'),(7,4,'2001-04-19','1900-01-01
00:00:00','15:37:26','p'),(8,1,'1900-01-01','2002-12-08
11:34:58','00:00:00','q'),(9,9,'2004-08-20','1900-01-01
00:00:00','05:03:03','w'),(10,4,'2004-10-10','1900-01-01
00:00:00','02:59:24','d'),(11,8,'2000-04-02','2002-08-25
20:35:06','00:01:58','e'),(12,4,'2006-11-02','2001-10-22
11:13:24','00:00:00','b'),(13,8,'2009-01-28','2003-03-12
02:00:34','02:20:16','y'),(14,0,'2005-04-19','2007-04-10
12:16:04','04:59:50','p'),(15,0,'2006-08-12','2009-11-07
00:00:00','21:14:04','f'),(16,0,'2005-03-12','2003-12-04
11:14:26','00:00:00','p'),(17,7,'1900-01-01','2006-09-11
18:25:21','12:59:27','d'),(18,7,'1900-01-01','1900-01-01
00:00:00','16:39:36','f'),(19,5,'0000-00-00','2001-07-25
08:40:24','00:00:00','j'),(20,3,'2007-09-09','2009-06-07
13:48:58','00:00:00','e');

SELECT  STD( OUTR . pk ) AS x
FROM t2 AS OUTR2 LEFT JOIN t2 AS OUTR
ON ( OUTR2 . col_datetime_key >= OUTR . col_datetime_key )
WHERE OUTR . col_int IN (
SELECT DISTINCT INNR . col_int_key AS y
FROM t1 AS INNR2 LEFT JOIN t1 AS INNR
ON ( INNR2 . col_varchar_key > INNR . col_varchar_key )
WHERE INNR . col_varchar_key IS NOT NULL
AND NOT OUTR . pk <> 7  )
AND OUTR . col_varchar_key IS NULL
HAVING x <= 3
ORDER BY OUTR . pk , OUTR . pk;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS WHERE table_name = 't2' and column_name = 'col_datetime';

DROP TABLE t1, t2;
SET @@SESSION.sql_mode=DEFAULT;
CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  col_int_key int(11) GENERATED ALWAYS AS ((col_int + col_int)) VIRTUAL,
  col_date date DEFAULT NULL,
  col_date_key date GENERATED ALWAYS AS ((col_date + interval 30 day)) VIRTUAL,
  col_datetime datetime DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_datetime_key datetime GENERATED ALWAYS AS (addtime(col_datetime,col_time)) VIRTUAL,
  col_time_key time GENERATED ALWAYS AS (addtime(col_datetime,col_time)) VIRTUAL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(2) GENERATED ALWAYS AS (concat(col_varchar,col_varchar)) VIRTUAL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key) /*!80000 INVISIBLE */
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
INSERT INTO t1 (pk, col_int, col_date, col_datetime, col_time, col_varchar) VALUES
(10,3,'2007-02-04','2006-02-10 18:41:38',NULL,'t'),
(11,48,'1900-01-01','2009-02-16 14:58:58',NULL,'d'),
(12,8,'2001-03-14','2007-08-14 00:00:00','23:28:51','h'),
(13,9,NULL,'1900-01-01 00:00:00',NULL,NULL),
(14,2,'2008-10-05',NULL,'20:31:20','f'),
(15,0,'2001-11-25','2008-12-03 06:59:23','21:39:14','l'),
(16,205,'2003-01-27','2008-10-04 00:00:00','02:10:00','g'),
(17,NULL,'2008-08-08','2009-07-07 07:00:21','02:03:54','v'),
(18,3,'2006-07-03','2001-04-15 00:00:00','22:37:33',NULL),
(19,3,'2002-11-21','2007-07-08 04:01:58','12:17:48','m');

CREATE TABLE t2 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  col_int_key int(11) GENERATED ALWAYS AS ((col_int + col_int)) VIRTUAL,
  col_date date DEFAULT NULL,
  col_date_key date GENERATED ALWAYS AS ((col_date + interval 30 day)) VIRTUAL,
  col_datetime datetime DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_datetime_key datetime GENERATED ALWAYS AS (addtime(col_datetime,col_time)) VIRTUAL,
  col_time_key time GENERATED ALWAYS AS (addtime(col_datetime,col_time)) VIRTUAL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(2) GENERATED ALWAYS AS (concat(col_varchar,col_varchar)) VIRTUAL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;
INSERT INTO t2 (pk, col_int, col_date, col_datetime, col_time, col_varchar) VALUES
(10,7,'2006-03-07','2008-03-04 06:14:13','13:08:22','b'),
(11,8,'2001-10-15','2001-03-17 00:00:00','12:54:48','m'),
(12,NULL,'1900-01-01','2009-02-21 11:35:50','00:00:00','i'),
(13,0,NULL,'1900-01-01 00:00:00','20:56:23','w'),
(14,1,'2009-04-05','1900-01-01 00:00:00','04:25:03','m'),
(15,NULL,'2001-03-19','2001-04-12 00:00:00','00:00:00','q'),
(16,9,'2009-12-08','2001-12-04 20:21:01','00:00:00','k'),
(17,9,'2005-02-09','2001-05-27 08:41:01','00:58:58','l'),
(18,1,'2004-05-25','2004-09-18 00:00:00','18:39:28','c'),
(19,1,'2005-01-17','2002-09-12 11:18:48','19:47:45','d'),
(20,3,'2003-08-28','1900-01-01 00:00:00','05:20:00','k'),
(21,7,'2006-10-11','2003-10-28 03:31:02','11:43:03','a'),
(22,4,'1900-01-01','2001-08-22 10:20:09','02:38:39','p'),
(23,NULL,'1900-01-01','2008-04-24 00:00:00','05:34:27','o'),
(24,4,'2005-08-18','2006-11-10 10:08:49','11:13:16','e'),
(25,1,'2007-03-12','2007-10-16 00:00:00','00:00:00','n'),
(26,6,'2000-11-18','2009-05-27 12:25:07','08:56:42','t'),
(27,5,'2001-03-03',NULL,'03:20:29','u'),
(28,4,'2003-09-11','2001-09-10 18:10:10',NULL,'f'),
(29,1,'2007-06-17','1900-01-01 00:00:00',NULL,'t'),
(30,5,'2008-09-11','2004-06-07 23:17:09','10:39:48','k'),
(31,NULL,'2008-05-03','2007-06-09 02:05:46','00:00:00','m'),
(32,4,'2009-09-07','2000-07-03 00:00:00','10:52:33','y'),
(33,4,'2005-12-15','2001-04-15 14:12:38','21:41:45','m'),
(34,203,'2005-05-10','2007-04-12 13:29:59',NULL,'x'),
(35,9,'2008-01-22','2002-03-24 01:35:46','08:33:38',NULL),
(36,7,'2005-10-23','2001-12-27 07:56:29','19:27:01','q'),
(37,NULL,'2005-11-01','2002-06-08 09:04:13','09:31:22','f'),
(38,NULL,NULL,'2002-02-05 12:54:23','17:16:58','t'),
(39,0,'2005-06-25','2009-09-19 00:00:00','16:44:24','x'),
(40,1,'2005-12-09','2006-12-18 02:43:37','05:22:56','s'),
(41,5,'2006-06-28','2002-10-18 00:00:00','13:32:21','i'),
(42,NULL,'2002-03-16','2004-08-03 22:46:02','15:59:32','l'),
(43,6,'2006-07-20','1900-01-01 00:00:00','07:19:58','t'),
(44,7,'1900-01-01','2006-11-15 05:00:37','12:50:41','b'),
(45,NULL,'2002-09-13','2005-01-21 07:18:44','04:38:11','h'),
(46,6,'2002-08-17','1900-01-01 00:00:00','20:25:46',NULL),
(47,9,NULL,'2002-09-22 01:36:27','00:00:00',NULL),
(48,5,'2007-12-08','2003-04-22 16:42:22','10:53:24',NULL),
(49,1,'2008-07-05','2000-10-18 08:28:55','06:16:28','x');
CREATE OR REPLACE VIEW view_AA AS SELECT * FROM t1;
CREATE OR REPLACE VIEW view_CC AS SELECT * FROM t2;

SELECT LEFT(col_varchar_key, 1) AS field1 FROM view_AA WHERE ( pk, NULL ) IN
(  SELECT col_int AS subfield11, pk AS subfield12 FROM view_CC WHERE ( col_datetime, col_date_key, col_varchar_key ) IN
 (  SELECT col_time_key AS subfield21, pk AS subfield22, col_time_key AS subfield23 FROM t1 WHERE col_varchar != col_varchar_key    )
 ORDER BY subfield12   ) OR col_int IS NOT NULL  ORDER BY field1 LIMIT 10 OFFSET 25;

DROP VIEW view_AA, view_CC;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 TIME, col2 DATE);
INSERT INTO t1 VALUES ("00:00:00", "2017-01-01");
DROP TABLE t1;

CREATE TABLE tbl_int (col1 INT);
INSERT INTO tbl_int VALUES (1), (2), (2), (2), (3), (6), (8), (8), (NULL), (NULL);

SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;

SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 > 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 >= 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 = 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <= 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 < 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 <> 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 0;
SET @const = 0;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 1;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 2;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 3;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 4;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 5;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 6;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 7;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 8;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 0 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 1 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 2 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 3 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 4 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 5 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 6 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 7 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 8 AND 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 BETWEEN 9 AND 9;
SET @const = 9;
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (0,1,2,3,4,5,6,7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (2,3,4,5,6,7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (3,4,5,6,7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (4,5,6,7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (5,6,7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (6,7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (7,8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (8,9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (9);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (1,3,5,7);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (2,4,6,8);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (2,5,6);
SELECT COUNT(*)/10.0 FROM tbl_int WHERE col1 IN (9,10,11,12,13);

DROP TABLE tbl_int;

CREATE TABLE tbl_float (col double);
INSERT INTO tbl_float VALUES (0.1), (0.2), (0.3), (0.3), (0.4), (0.5), (0.5),
                             (0.8), (NULL), (NULL);

SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;

SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col > 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col >= 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col = 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <= 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col < 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col <> 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.0;
SET @const = 0.0e0;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.1;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.2;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.3;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.4;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.5;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.6;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.7;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.8;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.0 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.1 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.2 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.3 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.4 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.5 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.6 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.7 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.8 AND 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col BETWEEN 0.9 AND 0.9;
SET @const = 0.9;
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.3,0.4,0.5,0.6,0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.4,0.5,0.6,0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.5,0.6,0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.6,0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.7,0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.8,0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.9);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.1,0.3,0.5,0.7);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.2,0.4,0.6,0.8);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.2,0.5,0.6);
SELECT COUNT(*)/10.0 FROM tbl_float WHERE col IN (0.9,1.0,1.1,1.2,1.3);

DROP TABLE tbl_float;

CREATE TABLE t1 (col1 BIGINT, col2 BIGINT UNSIGNED, col3 DOUBLE);
INSERT INTO t1 VALUES
  (-9223372036854775808, 0, -1.7976931348623157E+308),
  (9223372036854775806, 18446744073709551614, 1.7976931348623155e+308),
  (9223372036854775807, 18446744073709551615, 1.7976931348623157e+308);
DROP TABLE t1;
CREATE TABLE t1 (col1 VARCHAR(255));
SET cte_max_recursion_depth = 10000;
INSERT INTO t1 (col1)
WITH RECURSIVE cte (n, val) AS
(
  SELECT 1, CONCAT(SHA2(RAND(),0), SHA2(RAND(),0))
  UNION ALL
  SELECT n + 1, CONCAT(SHA2(RAND(),0), SHA2(RAND(),0)) FROM cte WHERE n < 10000
)
SELECT val FROM cte;
SET histogram_generation_max_mem_size = 1000000;

SELECT
  histogram->>'$."sampling-rate"' < 1.0 AS should_be_true
FROM
  INFORMATION_SCHEMA.COLUMN_STATISTICS;

SET cte_max_recursion_depth = DEFAULT;
SET histogram_generation_max_mem_size = DEFAULT;

DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (10), (20), (30);

SELECT JSON_EXTRACT(histogram, '$."number-of-buckets-specified"')
FROM INFORMATION_SCHEMA.column_statistics
WHERE table_name = "t1" AND column_name = "col1";
DROP TABLE t1;

CREATE TABLE t1 (a INT);
SET lock_wait_timeout= 1;
DROP TABLE t1;

-- echo --
-- echo -- Bug#33935417 Histograms cause zero row estimates for values outside
-- echo --              histogram buckets
-- echo --

-- Verify that selectivity estimates are lower bounded by 0.001.
CREATE TABLE ten (x INT);
INSERT INTO ten VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE hundred (x INT);
INSERT INTO hundred SELECT 10*ten1.x + ten0.x AS v
FROM ten AS ten1, ten AS ten0 ORDER BY v;

CREATE TABLE ten_thousand (x INT);
INSERT INTO ten_thousand SELECT 100*h1.x + h0.x AS v
FROM hundred AS h1, hundred AS h0 ORDER BY v;

-- The default selectivity used for equality predicates is 0.1.
EXPLAIN SELECT * FROM ten WHERE x = -1;

-- Build histograms on all tables and ensure statistics are up to date.
ANALYZE TABLE ten UPDATE HISTOGRAM ON x;

-- The old optimizer uses a selectivity estimate of max(1/#rows, histogram_estimate).
-- At 10k rows we should see the difference with the new lower bound of 1/1000
-- being used instead of 1/10000.
EXPLAIN SELECT * FROM ten WHERE x = -1;

-- The lower bound is used for all predicates supported by the histogram.
EXPLAIN SELECT * FROM ten_thousand WHERE x < -1;

DROP TABLE ten;
DROP TABLE hundred;
DROP TABLE ten_thousand;

-- echo --
-- echo -- Bug#34787357 Hypergraph: row estimates for
-- echo -- field=non_field_term ignores indexes and histogram.
-- echo --

CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1),(1),(2),(2),(3),(3),(NULL),(NULL);

-- Calculate selectivity as non_null_values_fraction/num_distinct_values.
EXPLAIN SELECT * FROM t1 WHERE col1 = FLOOR(RAND(0));

-- Calculate selectivity as:
-- non_null_values_fraction * (num_distinct_values - 1) / num_distinct_values
EXPLAIN SELECT * FROM t1 WHERE col1 <> FLOOR(RAND(0));

DROP TABLE t1;


-- Run a restart without any special parameters, which causes "check testcase" to
-- be run. Always keep this at the very end of the test!
let $restart_parameters = restart:;
