drop table if exists t1;
select floor(5.5),floor(-5.5);
select ceiling(5.5),ceiling(-5.5);
select truncate(52.64,1),truncate(52.64,2),truncate(52.64,-1),truncate(52.64,-2), truncate(-52.64,1),truncate(-52.64,-1);
select round(5.5),round(-5.5);
select abs(-10), sign(-5), sign(5), sign(0);
select log(exp(10)),exp(log(sqrt(10))*2),log(-1),log(NULL),log(1,1),log(3,9),log(-1,2),log(NULL,2);
select ln(exp(10)),exp(ln(sqrt(10))*2),ln(-1),ln(0),ln(NULL);
select log2(8),log2(15),log2(-2),log2(0),log2(NULL);
select log10(100),log10(18),log10(-4),log10(0),log10(NULL);
select pow(10,log10(10)),power(2,4);
select pi(),format(sin(pi()/2),6),format(cos(pi()/2),6),format(abs(tan(pi())),6),format(cot(1),6),format(asin(1),6),format(acos(0),6),format(atan(1),6);
select degrees(pi()),radians(360);
select format(atan(-2, 2), 6);
SELECT ACOS(1.0);
SELECT ASIN(1.0);
create table t1 (col1 int, col2 decimal(60,30));
insert into t1 values(1,1234567890.12345);
insert into t1 values(7,1234567890123456.12345);
drop table t1;
select ceil(0.09);
create table t1 select round(1, 6);
select * from t1;
drop table t1;
select abs(-2) * -2;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(1),(1),(2);
SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(a) * 1000 AS UNSIGNED) 
  FROM t1;
INSERT INTO t1 VALUES (3);
PREPARE stmt FROM 
  "SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(?) * 1000 AS UNSIGNED)
    FROM t1 WHERE a = 1";
DROP TABLE t1;
create table t1 (a varchar(90), ts datetime not null, index (a)) engine=innodb default charset=utf8mb3;
insert into t1 values ('http://www.foo.com/', now());
select a from t1 where a='http://www.foo.com/' order by abs(timediff(ts, 0));
drop table t1;
select ln(-1);
select log(2,-1);
create table t1
(f1 varchar(32) not null,
 f2 smallint(5) unsigned not null,
 f3 int(10) unsigned not null default '0')
default charset=utf8mb3;
insert into t1 values ('zombie',0,0),('gold',1,10000),('silver',2,10000);
create table t2
(f1 int(10) unsigned not null,
 f2 int(10) unsigned not null,
 f3 smallint(5) unsigned not null)
default charset=utf8mb3;
insert into t2 values (16777216,16787215,1),(33554432,33564431,2);
drop table t1, t2;
select cast(-2 as unsigned), 18446744073709551614, -2;
select sqrt(cast(-2 as unsigned)), sqrt(18446744073709551614), sqrt(-2);
select round(10000000000000000000, -19), truncate(10000000000000000000, -19);
select mod(cast(-2 as unsigned), 3), mod(18446744073709551614, 3), mod(-2, 3);
select pow(cast(-2 as unsigned), 5), pow(18446744073709551614, 5), pow(-2, 5);
CREATE TABLE t1 (a timestamp, b varchar(20), c bit(1));
INSERT INTO t1 VALUES('1998-09-23', 'str1', 1), ('2003-03-25', 'str2', 0);
SELECT a DIV 900 y FROM t1 GROUP BY y;
SELECT DISTINCT a DIV 900 y FROM t1;
SELECT b DIV 900 y FROM t1 GROUP BY y;
SELECT c DIV 900 y FROM t1 GROUP BY y;
DROP TABLE t1;
CREATE TABLE t1(a LONGBLOB);
INSERT INTO t1 VALUES('1'),('2'),('3');
SELECT DISTINCT (a DIV 254576881) FROM t1;
SELECT (a DIV 254576881) FROM t1 UNION ALL 
  SELECT (a DIV 254576881) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a SET('a','b','c'));
INSERT INTO t1 VALUES ('a');
SELECT a DIV 2 FROM t1 UNION SELECT a DIV 2 FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DOUBLE);
INSERT INTO t1 VALUES (-1.1), (1.1),
                      (-1.5), (1.5),
                      (-1.9), (1.9),
                      (-2.1), (2.1),
                      (-2.5), (2.5),
                      (-2.9), (2.9),
# Check numbers with absolute values > 2^53 - 1 
# (see comments for MAX_EXACT_INTEGER)
                      (-1e16 - 0.5), (1e16 + 0.5),
                      (-1e16 - 1.5), (1e16 + 1.5);
SELECT a, ROUND(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(f1 LONGTEXT);
INSERT INTO t1 VALUES ('a');
SELECT 1 FROM (SELECT ROUND(f1) AS a FROM t1) AS s WHERE a LIKE 'a';
SELECT 1 FROM (SELECT ROUND(f1, f1) AS a FROM t1) AS s WHERE a LIKE 'a';
DROP TABLE t1;
CREATE OR REPLACE VIEW v1 AS SELECT NULL AS a;
SELECT RAND(a) FROM v1;
DROP VIEW v1;
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (NULL);
DROP TABLE t1;
SELECT -9223372036854775808 MOD -1;
SELECT -9223372036854775808999 MOD -1;
SELECT CASE(('')) WHEN (CONVERT(1, CHAR(1))) THEN (('' / 1)) END;
CREATE TABLE t1 SELECT CAST((CASE(('')) WHEN (CONVERT(1, CHAR(1))) THEN (('' / 1)) END) AS CHAR) as C;
DROP TABLE t1;
CREATE TABLE t1(f1 DECIMAL(22,1));
INSERT INTO t1 VALUES (0),(1);
DROP TABLE t1;
SELECT SUM(DISTINCT (TRUNCATE((.1), NULL)));
SELECT 18446744073709551615 - 1;
SELECT 18446744073709551615 - CAST(1 AS UNSIGNED);
SELECT 18446744073709551614 - (-1);
CREATE TABLE t1(a BIGINT, b BIGINT UNSIGNED);
INSERT INTO t1 VALUES(-9223372036854775808, 9223372036854775809);
DROP TABLE t1;
SELECT @a + @a;
SELECT @a * @a;
SELECT -@a - @a;
SELECT @a / 0.5;
SELECT COT(1/0);
SELECT -1 + 9223372036854775808;
SELECT 2 DIV -2;
SELECT -(1 DIV 0);
SELECT -9223372036854775808 MOD -1;
SELECT floor(log10(format(concat_ws(5445796E25, 5306463, 30837), -358821)))
as foo;
CREATE TABLE t1(a char(0));
INSERT IGNORE INTO t1 (SELECT -pi());
DROP TABLE t1;
SELECT ((@a:=@b:=1.0) div (@b:=@a:=get_format(datetime, 'usa')));
SELECT 1 div null;
select (1.175494351E-37 div 1.7976931348623157E+308);
select 5 div 2;
select 5.0 div 2.0;
select 5.0 div 2;
select 5 div 2.0;
select 5.9 div 2, 1.23456789e3 DIV 2, 1.23456789e9 DIV 2, 1.23456789e19 DIV 2;
CREATE TABLE t1(a DOUBLE);
INSERT INTO t1 VALUES (ln(1));
SELECT * FROM t1 ORDER BY a;
INSERT INTO t1 VALUES (ln(1));
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TEMPORARY TABLE tmp_test (
    number double
  );
INSERT INTO tmp_test
  VALUES (1),(0);
SELECT CRC32(NULL), CRC32(''), CRC32('MySQL'), CRC32('mysql');
DROP TABLE IF EXISTS t;
CREATE TABLE t(a INT, b VARCHAR(2));
INSERT INTO t VALUES (1,'a'), (2,'qw'), (1,'t'), (3,'t');
SELECT crc32(SUM(a)) FROM t;
SELECT a,b,concat(a,b),crc32(concat(a,b)) FROM t ORDER BY crc32(concat(a,b));
DROP TABLE t;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 BIT(5),
                 c2 TINYINT,
                 c3 MEDIUMINT,
                 c4 INTEGER,
                 c5 BIGINT,
                 c6 DECIMAL(7,5),
                 c7 FLOAT(7,5),
                 c8 DOUBLE(7,5));
INSERT INTO t1 VALUES (B'10101', 127, 8388607, 2147483647,
                       9223372036854775807, 10.5, 11.5, 12.5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 DATE,
                 c2 DATETIME,
                 c3 TIMESTAMP,
                 c4 TIME,
                 c5 YEAR);
INSERT INTO t1 VALUES ('2007-01-01', '2007-01-01 12:00:01',
                       '2007-01-01 00:00:01.000000',
                       '12:00:01.000000', '2007');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 CHAR,
                 c2 VARCHAR(10),
                 c3 BINARY(1),
                 c4 VARBINARY(10),
                 c5 TINYBLOB,
                 c6 TINYTEXT,
                 c7 BLOB,
                 c8 TEXT,
                 c9 MEDIUMBLOB,
                 c10 MEDIUMTEXT,
                 c11 LONGBLOB,
                 c12 LONGTEXT);
INSERT INTO t1 VALUES ('a', 'a', 0x61, 0x61, 'a', 'a',
                       'a', 'a', 'a', 'a', 'a', 'a');
CREATE TABLE geom_data(id INT,
  pt POINT NOT NULL,
  lnstr LINESTRING NOT NULL,
  mlnstr MULTILINESTRING NOT NULL,
  poly POLYGON NOT NULL,
  mpoly MULTIPOLYGON NOT NULL);
INSERT INTO geom_data VALUES (10,
  ST_GEOMFROMTEXT('POINT(10 20)'),
  ST_GEOMFROMTEXT('LINESTRING(0 0,5 5,6 6)'),
  ST_GEOMFROMTEXT('MULTILINESTRING((0 0,2 3,4 5),(6 6,8 8,9 9,10 10))'),
  ST_GEOMFROMTEXT('POLYGON((0 0,6 7,8 8,3 9,0 0),(3 6,4 6,4 7,3 6))'),
  ST_GEOMFROMTEXT('MULTIPOLYGON(((0 0,0 5,5 5,5 0,0 0)),
                                ((2 2,4 5,6 2,2 2)))'));
DROP TABLE geom_data;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (e1 ENUM ('a','b'), s1 SET('a','b'));
INSERT INTO t1 VALUES(2,'a,b'),('a','b,a');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a JSON);
INSERT INTO t1 VALUES ('{"name" : "goodyear"}'),
  ('{"name" : "verygood-year"}');
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES(10);
CREATE VIEW v1 AS SELECT CRC32(a) AS my_crc FROM t1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR);
CREATE TABLE t2 (b BIGINT);
INSERT INTO t1 VALUES('a');
SELECT * FROM t2;
DROP TABLE t2;
DROP TABLE t1;
CREATE PROCEDURE crc32_proc (IN a CHAR, OUT b BIGINT)
  SELECT CRC32(a) INTO b;
SELECT @val;
DROP PROCEDURE crc32_proc;
PREPARE stmt1 FROM 'SELECT CRC32(?)';
DEALLOCATE PREPARE stmt;
CREATE TABLE t1 (a TEXT) CHARACTER SET = utf8mb3;
SELECT HEX(a), CRC32(a) from t1;
DROP TABLE t1;
select cast(pow(2,63)-1024 as signed) as pp;
select cast(1-pow(2,63) as signed) as qq;
CREATE TABLE t(a int);
DROP TABLE t;
select -9223372036854775808 * 0 as result;
select 0 * -9223372036854775808 as result;
select -9223372036854775808 * 1 as result;
select 1 * -9223372036854775808 as result;
CREATE TABLE t1(a BIGINT UNSIGNED);
INSERT INTO t1 VALUES(18446744073709551615);
CREATE TABLE t2 AS
SELECT CEILING(a) AS c, FLOOR(a) AS f FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t AS
SELECT CEILING(18446744073709551615) AS c,
       FLOOR(18446744073709551615) AS f;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(18446744073709551616) AS c,
       FLOOR(18446744073709551616) AS f;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(CAST(1844674407370955161 AS DECIMAL(19, 0))) AS c,
       FLOOR(CAST(1844674407370955161 AS DECIMAL(19, 0))) AS f;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(CAST(-9223372036854775808 AS DECIMAL(19, 0))) AS c,
       FLOOR(CAST(-9223372036854775808 AS DECIMAL(19, 0))) AS f;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(CAST(184467440737095516 AS DECIMAL(18, 0))) AS c,
       FLOOR(CAST(184467440737095516 AS DECIMAL(18, 0))) AS f;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(CAST(-922337203685477580 AS DECIMAL(18, 0))) AS c,
       FLOOR(CAST(-922337203685477580 AS DECIMAL(18, 0))) AS f;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(CAST(99999999999999999.9 AS DECIMAL(18, 1))) AS c,
       FLOOR(CAST(-99999999999999999.9 AS DECIMAL(18, 1))) AS f;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t AS
SELECT CEILING(CAST(999999999999999999.9 AS DECIMAL(19, 1))) AS c,
       FLOOR(CAST(-999999999999999999.9 AS DECIMAL(19, 1))) AS f;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t0(c0 BIGINT UNSIGNED);
INSERT INTO t0(c0) VALUES(NULL);
SELECT * FROM t0 WHERE CAST(COALESCE(t0.c0, -1) AS UNSIGNED);
SELECT * FROM t0 WHERE CAST(IFNULL(t0.c0, -1) AS UNSIGNED);
DROP TABLE t0;
CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(11, -1);
CREATE TABLE t2 AS SELECT a, ROUND(a, b) AS c FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t (a INTEGER);
PREPARE st1 FROM "INSERT INTO t VALUES (? + ?)";
DROP TABLE t;
CREATE TABLE t1 (i INT, iu INT UNSIGNED,
                 b BIGINT, bu BIGINT UNSIGNED);
DELETE FROM t1;
SELECT i,iu,b,bu FROM t1;
DELETE FROM t1;
SELECT b,bu FROM t1;
DELETE FROM t1;
SELECT b,bu FROM t1;
DELETE FROM t1;
INSERT INTO t1 (i,b) VALUES ('0.9223372036854775807', '0.9223372036854775807');
INSERT INTO t1 (i,b) VALUES ('0.9223372036854775808', '0.9223372036854775808');
SELECT i,b FROM t1;
DELETE FROM t1;
SELECT iu,bu FROM t1;
DROP TABLE t1;
SELECT 5.0 + 96 DIV 1;
CREATE TABLE t1 SELECT
  5.0 + 96 DIV 1,                     # Dividend is integer
  5.0 + 96.1234 DIV 1,                # Dividend is decimal
  5.0 + '96' DIV 1,                   # Dividend is string
  5.0 + CAST('96' AS SIGNED) DIV 1,   # Dividend is function
  5.0 + CAST('96' AS UNSIGNED) DIV 1;
DROP TABLE t1;
CREATE TABLE t1(a BIGINT);
INSERT INTO t1 VALUES (-9223372036854775808);
DELETE FROM t1;
INSERT INTO t1 VALUES (-9223372036854775807);
DROP TABLE t1;
CREATE TABLE t1(c1 INTEGER, c2 INTEGER);
INSERT INTO t1 VALUES(97, 1);
DROP TABLE t1;
SELECT * FROM (SELECT -TRUE AS a, --TRUE AS b) AS dt;
CREATE VIEW v AS SELECT -(1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
