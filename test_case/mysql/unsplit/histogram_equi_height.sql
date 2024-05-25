CREATE TABLE tbl_int (col1 INT);
INSERT INTO tbl_int VALUES (1), (2), (3), (4), (5), (6), (7), (8), (NULL), (NULL);
DROP TABLE tbl_int;
CREATE TABLE tbl_varchar (col1 VARCHAR(255));
INSERT INTO tbl_varchar VALUES
  ("abcd"), ("ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£"), ("ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂº"), ("eeeeeeeeee"), ("ef"), ("AG"),
  ("a very long string that is longer than 42 characters"),
  ("lorem ipsum"), (NULL), (NULL);
DROP TABLE tbl_varchar;
CREATE TABLE tbl_varchar (col1 VARCHAR(255));
INSERT INTO tbl_varchar VALUES
#   |------------ 42 characters -------------|
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnop"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnoq"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnor"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnos"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopp"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopq"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnoss"),
  ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnost");
DROP TABLE tbl_varchar;
CREATE TABLE tbl_double (col1 DOUBLE);
INSERT INTO tbl_double VALUES (-1.1), (0.0), (1.1), (2.2), (3.3), (4.4), (5.5), (6.6), (NULL), (NULL);
DROP TABLE tbl_double;
CREATE TABLE tbl_time (col1 TIME);
INSERT INTO tbl_time VALUES
  ("-01:00:00"), ("00:00:00"), ("00:00:01"), ("00:01:00"), ("01:00:00"),
  ("01:01:00"), ("02:00:00"), ("03:00:00"), (NULL), (NULL);
DROP TABLE tbl_time;
CREATE TABLE tbl_time (col1 TIME(6));
INSERT INTO tbl_time VALUES
  ("00:00:00.000000"), ("00:00:00.000001"), ("00:00:00.000002"),
  ("00:00:00.000003"), ("00:00:00.000004"), ("00:00:00.000005");
DROP TABLE tbl_time;
CREATE TABLE tbl_date (col1 DATE);
INSERT INTO tbl_date VALUES
  ("1000-01-01"), ("9999-12-30"), ("2017-01-01"), ("2017-01-02"), ("2017-02-01"),
  ("2018-01-01"), ("2019-01-01"), ("3019-01-01"), (NULL), (NULL);
DROP TABLE tbl_date;
CREATE TABLE tbl_datetime (col1 DATETIME(6));
INSERT INTO tbl_datetime VALUES
  ("1000-01-01 00:00:00"), ("9999-12-31 23:59:59.999998"),
  ("2017-01-01 00:00:00"), ("2017-01-01 00:00:00.000001"),
  ("2017-02-01 00:00:00"), ("2018-01-01 00:00:00.999999"),
  ("2018-01-01 00:00:01"), ("3019-01-01 10:10:10.101010"), (NULL), (NULL);
DROP TABLE tbl_datetime;
CREATE TABLE tbl_decimal (col1 DECIMAL(65, 30));
INSERT INTO tbl_decimal VALUES
  (00000000000000000000000000000000000.000000000000000000000000000000),
  (99999999999999999999999999999999999.999999999999999999999999999998),
  (-99999999999999999999999999999999999.999999999999999999999999999999),
  (1), (2), (3), (4), (-1), (NULL), (NULL);
DROP TABLE tbl_decimal;
CREATE TABLE tbl_enum (col1 ENUM('red', 'black', 'blue', 'green'));
INSERT INTO tbl_enum VALUES ('red'), ('red'), ('black'), ('blue'), ('green'),
                            ('green'), (NULL), (NULL), (NULL);
DROP TABLE tbl_enum;
CREATE TABLE tbl_set (col1 SET('red', 'black', 'blue', 'green'));
INSERT INTO tbl_set VALUES ('red'), ('red,black'), ('black,green,blue'),
                           ('black,green,blue'), ('black,green,blue'),
                           ('green'), ('green,red'), ('red,green'), (NULL),
                           (NULL), (NULL);
DROP TABLE tbl_set;
CREATE TABLE t1 (col1 VARCHAR(255));
INSERT INTO t1 VALUES ("a"), ("a"), ("a"), ("a"), ("a"), ("a"), ("a"), ("b"),
                      ("c"), ("d");
DROP TABLE t1;
CREATE TABLE t1 (col1 DECIMAL);
INSERT INTO t1 VALUES (1.0), (1.0), (1.0), (1.0), (1.0), (1.0), (1.0), (2.0),
                      (3.0), (4.0);
DROP TABLE t1;
CREATE TABLE t1 (col1 BIGINT UNSIGNED);
INSERT INTO t1 VALUES (100), (100), (100), (100), (100), (100), (100), (200),
                      (300), (400);
DROP TABLE t1;
CREATE TABLE t1 (col1 TIME);
INSERT INTO t1 VALUES ("00:00:00"), ("00:00:00"), ("00:00:00"), ("00:00:00"),
                      ("00:00:00"), ("00:00:00"), ("00:00:00"), ("00:01:00"),
                      ("00:02:00"), ("00:03:00");
DROP TABLE t1;
CREATE TABLE t1(x INT);
SELECT JSON_PRETTY(JSON_REMOVE(histogram, '$."last-updated"'))
FROM INFORMATION_SCHEMA.column_statistics
WHERE table_name = 't1' AND column_name = 'x';
SELECT JSON_PRETTY(JSON_REMOVE(histogram, '$."last-updated"'))
FROM INFORMATION_SCHEMA.column_statistics
WHERE table_name = 't1' AND column_name = 'x';
SELECT JSON_PRETTY(JSON_REMOVE(histogram, '$."last-updated"'))
FROM INFORMATION_SCHEMA.column_statistics
WHERE table_name = 't1' AND column_name = 'x';
DROP TABLE t1;
