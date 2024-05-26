select CAST(1-2 AS UNSIGNED);
select cast(-5 as unsigned) | 1, cast(-5 as unsigned) & -1;
select cast(-5 as unsigned) -1, cast(-5 as unsigned) + 1;
select cast("A" as binary) = "a", cast(BINARY "a" as CHAR) = "A";
select CONVERT("2004-01-22 21:45:33",DATE);
select 10+'10';
select 10.0+'10';
select 10E+0+'10';
select 10+'a';
select 10.0+cast('a' as decimal);
select 10E+0+'a';
select hex(cast(_latin1'test' as char character set latin2));
create table t1 select cast(_koi8r x'D4C5D3D4' as char character set cp1251) as t;
drop table t1;
select
  cast(_latin1'ab'  AS char charset binary)    as c1,
  cast(_latin1'a '  AS char charset binary)    as c2,
  cast(_latin1'abc' AS char(2) charset binary) as c3,
  cast(_latin1'a  ' AS char(2) charset binary) as c4,
  hex(cast(_latin1'a'   AS char(2) charset binary)) as c5;
select
  cast(_koi8r x'C6C7'   AS nchar)    as c1,
  cast(_koi8r x'C620'   AS nchar)    as c2,
  cast(_koi8r x'C6C7C8' AS nchar(2)) as c3,
  cast(_koi8r x'C62020' AS nchar(2)) as c4,
  cast(_koi8r x'C6'     AS nchar(2)) as c5;
SELECT
  CAST(_gb2312 x'CAFDBEDD'     AS NATIONAL CHAR)    AS c1,
  CAST(_gb2312 x'CAFD20'       AS NATIONAL CHAR)    AS c2,
  CAST(_gb2312 x'CAFDBEDDBFE2' AS NATIONAL CHAR(2)) AS c3,
  CAST(_gb2312 x'CAFD2020'     AS NATIONAL CHAR(2)) AS c4,
  CAST(_gb2312 x'CAFD'         AS NATIONAL CHAR(2)) AS c5;
create table t1 (a binary(4), b char(4) character set koi8r);
insert into t1 values (_binary x'D4C5D3D4',_binary x'D4C5D3D4');
drop table t1;
select cast("2001-1-1" as date) = "2001-01-01";
select cast("2001-1-1" as datetime) = "2001-01-01 00:00:00";
select cast("1:2:3" as TIME) = "1:02:03";
CREATE TABLE t1 (a enum ('aac','aab','aaa') not null);
INSERT INTO t1 VALUES ('aaa'),('aab'),('aac');
DROP TABLE t1;
select date_add(cast('2004-12-30 12:00:00' as date), interval 0 hour);
select timediff(cast('2004-12-30 12:00:00' as time), '12:00:00');
CREATE TABLE t1 (f1 double);
INSERT INTO t1 SET f1 = -1.0e+30;
INSERT INTO t1 SET f1 = +1.0e+30;
SELECT f1 AS double_val, CAST(f1 AS SIGNED INT) AS cast_val FROM t1;
DROP TABLE t1;
select isnull(date(NULL)), isnull(cast(NULL as DATE));
select 1e18 * cast('1.2' as decimal(3,2));
create table t1(s1 time);
insert into t1 values ('11:11:11');
drop table t1;
CREATE TABLE t1 (v varchar(10), tt tinytext, t text,
                 mt mediumtext, lt longtext);
INSERT INTO t1 VALUES ('1.01', '2.02', '3.03', '4.04', '5.05');
DROP TABLE t1;
select cast(NULL as decimal(6)) as t1;
CREATE TABLE t1 (d1 datetime);
INSERT INTO t1(d1) VALUES ('2007-07-19 08:30:00'), (NULL),
  ('2007-07-19 08:34:00'), (NULL), ('2007-07-19 08:36:00');
drop table t1;
CREATE TABLE t1 (f1 DATE);
INSERT INTO t1 VALUES ('2007-07-19'), (NULL);
SELECT HOUR(f1),
       MINUTE(f1),
       SECOND(f1) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a tinyint);
INSERT INTO t1 VALUES (127);
SELECT 1 FROM
(
 SELECT CONVERT(t2.a USING utf8mb3) FROM t1, t1 t2 LIMIT 1
) AS s LIMIT 1;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(50));
SELECT a FROM t1 
WHERE CAST(a as BINARY)=x'62736D697468' 
  AND CAST(a AS BINARY)=x'65736D697468';
DROP TABLE t1;
CREATE TABLE t (c1 ENUM('a','b','c'));
INSERT INTO t VALUES ('a'), ('b'), ('c');
SELECT CAST(c1 AS UNSIGNED) AS c5 FROM t;
SELECT CAST(c1 AS UNSIGNED) AS c5 FROM (SELECT c1 FROM t) t;
DROP TABLE t;
SELECT CAST(1/3 AS FLOAT) as float_col,
       CAST(1/3 AS DOUBLE) as double_col,
       CAST(1/3 AS DOUBLE PRECISION) as double_prec_col,
       CAST(1/3 AS REAL) as real_col;
SELECT ADDDATE(CAST("20010101235959.9" AS DOUBLE), INTERVAL 1 DAY);
SELECT TIMEDIFF(CAST("101112" AS DOUBLE), TIME'101010');
CREATE TABLE t1 as SELECT CAST(1/3 AS FLOAT) as float_col,
                          CAST(1/3 AS DOUBLE) as double_col,
                          CAST(CAST(999.00009 AS DECIMAL(7,4)) AS DOUBLE) as d2;
DROP TABLE t1;
SELECT -1.0 *  CAST(3.14e19 AS DOUBLE);
SELECT CONCAT("value=", CAST("3.4e5" AS FLOAT));
CREATE VIEW v1 AS SELECT CAST(1/3 AS REAL), CAST(1/3 AS FLOAT(2)), CAST(1/3 AS FLOAT(50));
DROP VIEW v1;
CREATE TABLE t AS SELECT CAST(34 AS REAL);
DROP TABLE t;
CREATE TABLE t AS SELECT CAST(34 AS REAL);
DROP TABLE t;
SELECT MAKETIME(1, 2, CAST("1.6" AS FLOAT));
CREATE TABLE dt_t (dt DATETIME, d DATE, t TIME);
CREATE TABLE n_t (i INT, d DECIMAL, f FLOAT, dc DECIMAL);
DROP TABLE dt_t, n_t;
CREATE TABLE t1 (spID int, userID int, date date);
INSERT INTO t1 VALUES (1,1,'1998-01-01');
INSERT INTO t1 VALUES (2,2,'2001-02-03');
INSERT INTO t1 VALUES (3,1,'1988-12-20');
INSERT INTO t1 VALUES (4,2,'1972-12-12');
DROP TABLE t1;
CREATE TABLE t(c CHAR(64), v VARCHAR(256), txt TEXT, b BINARY(64), vb VARBINARY(32),
               e ENUM ("v1", "v2"), set1 SET('101', '102'), bl  BLOB, i INT,
               si SMALLINT, ti TINYINT, mi MEDIUMINT, bi BIGINT, bt BIT,
               d DECIMAL, f FLOAT, dbl DOUBLE, dt DATETIME, dd  DATE, t TIME,
               y YEAR);
INSERT INTO t
VALUES ("char", "vchar","text", "binary", "varbinary", "v1", '101,102', "blob", 
        2001, 2, 3, 4, 200000002, 0x01, 2001.0, 2001.0, 2001.2,
        "2001-01-02 22:00", "2001-01-02", "20:01", 2010);
DROP TABLE t;
CREATE TABLE t1(a YEAR, b VARCHAR(10));
INSERT INTO t1 VALUES ('1997','random_str');
SELECT STRCMP(a, b) FROM t1;
DROP TABLE t1;
CREATE TABLE t (col_datetime datetime, col_date date, col_time time, col_char char);
insert into t values ('2013-03-15 18:35:20', '2013-03-15', '18:35:20','L'),
                     ('2003-01-10 00:00:23', '2003-01-10', '00:00:23', NULL);
SELECT col_char /*CAST(col_char as datetime)*/ <> col_datetime FROM t;
SELECT col_char <> col_date FROM t;
SELECT col_char <> col_time FROM t;
DROP TABLE t;
CREATE TABLE `BB` (`col_char_key` char(1));
CREATE TABLE `CC` ( `pk` int, `col_datetime_key` datetime,
KEY `idx_CC_col_datetime_key` (`col_datetime_key`));
INSERT INTO `BB` VALUES ('X');
INSERT INTO `CC` VALUES (1,'2027-03-17 00:10:00'), (2,'2004-11-14 12:46:43');
SELECT COUNT(table1.pk) FROM CC table1 JOIN BB table3 JOIN CC table2
WHERE (table3.col_char_key < table2.col_datetime_key);
DROP TABLE `BB`;
DROP TABLE `CC`;
CREATE TABLE t AS SELECT CAST("2010" AS YEAR);
DROP TABLE t;
CREATE TABLE t1 (i INT, j JSON) CHARSET utf8mb4;
INSERT INTO t1 VALUES (0, NULL);
INSERT INTO t1 VALUES (1, '"1901"');
INSERT INTO t1 VALUES (2, 'true');
INSERT INTO t1 VALUES (3, 'false');
INSERT INTO t1 VALUES (4, 'null');
INSERT INTO t1 VALUES (5, '-1');
INSERT INTO t1 VALUES (6, CAST(CAST(1 AS UNSIGNED) AS JSON));
INSERT INTO t1 VALUES (7, '1901');
INSERT INTO t1 VALUES (8, '-1901');
INSERT INTO t1 VALUES (9, '2147483647');
INSERT INTO t1 VALUES (10, '2147483648');
INSERT INTO t1 VALUES (11, '-2147483648');
INSERT INTO t1 VALUES (12, '-2147483649');
INSERT INTO t1 VALUES (13, '3.14');
INSERT INTO t1 VALUES (14, '{}');
INSERT INTO t1 VALUES (15, '[]');
INSERT INTO t1 VALUES (16, CAST(CAST('2015-01-15 23:24:25' AS DATETIME) AS JSON));
INSERT INTO t1 VALUES (17, CAST(CAST('23:24:25' AS TIME) AS JSON));
INSERT INTO t1 VALUES (18, CAST(CAST('2015-01-15' AS DATE) AS JSON));
INSERT INTO t1 VALUES (19, CAST(TIMESTAMP'2015-01-15 23:24:25' AS JSON));
INSERT INTO t1 VALUES (20, CAST(ST_GeomFromText('POINT(1 1)') AS JSON));
INSERT INTO t1 VALUES (21, CAST('1988' AS CHAR CHARACTER SET 'ascii'));
INSERT INTO t1 VALUES (22, CAST(x'07C4' AS JSON));
INSERT INTO t1 VALUES (23, CAST(x'07C407C4' AS JSON));
DROP TABLE t1;
CREATE TABLE t(numbers ENUM('0','1','2020'), colors ENUM('red', 'green', 'blue'));
INSERT INTO t values('2020', 'blue');
DROP TABLE t;
CREATE TABLE t(y YEAR);
SELECT * FROM t;
DROP TABLE t;
SELECT CAST(1988 AS YEAR) + 1.5e0;
SELECT DATE_ADD(CAST(1988 AS YEAR), INTERVAL 1 DAY);
SELECT TIME_TO_SEC(CAST('2030' AS YEAR));
SELECT TIMESTAMPADD(MINUTE, 1, CAST(1988 AS YEAR));
SELECT CAST('0000-00-00' AS DATE) AS d1,
       CAST(@zero_date AS DATE) AS d2,
       CAST('0000-00-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('2000-01-00' AS DATE) AS d1,
       CAST(@zero_day AS DATE) AS d2,
       CAST('2000-01-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_day_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-00-01' AS DATE) AS d1,
       CAST(@zero_month AS DATE) AS d2,
       CAST('2000-00-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_month_dt AS DATETIME(6)) AS dt2;
SELECT CAST('0000-01-01' AS DATE) AS d1,
       CAST(@zero_year AS DATE) AS d2,
       CAST('0000-01-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_year_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-02-31' AS DATE) AS d1,
       CAST(@invalid_date AS DATE) AS d2,
       CAST('2000-02-31 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@invalid_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('YYYY-MM-DD' AS DATE) AS d1,
       CAST(@bad_date AS DATE) AS d2,
       CAST('YYYY-MM-DD HH:MM:SS.ffffff' AS DATETIME(6)) AS dt1,
       CAST(@bad_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('0000-00-00' AS DATE) AS d1,
       CAST(@zero_date AS DATE) AS d2,
       CAST('0000-00-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('2000-01-00' AS DATE) AS d1,
       CAST(@zero_day AS DATE) AS d2,
       CAST('2000-01-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_day_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-00-01' AS DATE) AS d1,
       CAST(@zero_month AS DATE) AS d2,
       CAST('2000-00-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_month_dt AS DATETIME(6)) AS dt2;
SELECT CAST('0000-01-01' AS DATE) AS d1,
       CAST(@zero_year AS DATE) AS d2,
       CAST('0000-01-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_year_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-02-31' AS DATE) AS d1,
       CAST(@invalid_date AS DATE) AS d2,
       CAST('2000-02-31 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@invalid_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('YYYY-MM-DD' AS DATE) AS d1,
       CAST(@bad_date AS DATE) AS d2,
       CAST('YYYY-MM-DD HH:MM:SS.ffffff' AS DATETIME(6)) AS dt1,
       CAST(@bad_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('0000-00-00' AS DATE) AS d1,
       CAST(@zero_date AS DATE) AS d2,
       CAST('0000-00-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('2000-01-00' AS DATE) AS d1,
       CAST(@zero_day AS DATE) AS d2,
       CAST('2000-01-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_day_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-00-01' AS DATE) AS d1,
       CAST(@zero_month AS DATE) AS d2,
       CAST('2000-00-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_month_dt AS DATETIME(6)) AS dt2;
SELECT CAST('0000-01-01' AS DATE) AS d1,
       CAST(@zero_year AS DATE) AS d2,
       CAST('0000-01-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_year_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-02-31' AS DATE) AS d1,
       CAST(@invalid_date AS DATE) AS d2,
       CAST('2000-02-31 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@invalid_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('YYYY-MM-DD' AS DATE) AS d1,
       CAST(@bad_date AS DATE) AS d2,
       CAST('YYYY-MM-DD HH:MM:SS.ffffff' AS DATETIME(6)) AS dt1,
       CAST(@bad_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('0000-00-00' AS DATE) AS d1,
       CAST(@zero_date AS DATE) AS d2,
       CAST('0000-00-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('2000-01-00' AS DATE) AS d1,
       CAST(@zero_day AS DATE) AS d2,
       CAST('2000-01-00 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_day_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-00-01' AS DATE) AS d1,
       CAST(@zero_month AS DATE) AS d2,
       CAST('2000-00-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_month_dt AS DATETIME(6)) AS dt2;
SELECT CAST('0000-01-01' AS DATE) AS d1,
       CAST(@zero_year AS DATE) AS d2,
       CAST('0000-01-01 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@zero_year_dt AS DATETIME(6)) AS dt2;
SELECT CAST('2000-02-31' AS DATE) AS d1,
       CAST(@invalid_date AS DATE) AS d2,
       CAST('2000-02-31 00:00:00.000000' AS DATETIME(6)) AS dt1,
       CAST(@invalid_datetime AS DATETIME(6)) AS dt2;
SELECT CAST('YYYY-MM-DD' AS DATE) AS d1,
       CAST(@bad_date AS DATE) AS d2,
       CAST('YYYY-MM-DD HH:MM:SS.ffffff' AS DATETIME(6)) AS dt1,
       CAST(@bad_datetime AS DATETIME(6)) AS dt2;
CREATE TABLE t AS
  SELECT CONCAT(CAST(-1 AS UNSIGNED)) AS col1,
         1.0 + CAST(-1 AS UNSIGNED) AS col2,
         CONCAT(CAST(9223372036854775808 AS SIGNED)) AS col3;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (x VARCHAR(10) NOT NULL);
INSERT INTO t VALUES ('');
DROP TABLE t;
CREATE TABLE tmp(beer CHAR(1));
INSERT INTO tmp VALUES (CONVERT(X'F09F8DBA' USING utf8mb4));
SELECT HEX(beer), beer FROM tmp;
CREATE TABLE t AS
    SELECT CONVERT((SELECT beer FROM tmp) USING binary) AS beer;
DROP TABLE t, tmp;
CREATE TABLE t AS
    SELECT CONVERT(X'F09F8DBA' USING utf8mb4) AS beer;
DROP TABLE t;
CREATE TABLE t AS
    SELECT CONVERT(CONVERT(X'F09F8DBA' USING utf8mb4) USING binary) AS beer;
DROP TABLE t;
CREATE TABLE t AS
    SELECT CONVERT(CONVERT(X'F09F8DBA', CHAR(1) CHARACTER SET utf8mb4) USING binary) AS beer;
DROP TABLE t;
CREATE TABLE t AS
    SELECT CONVERT(CONVERT(_utf8mb3'a' USING utf8mb4) USING utf8mb3) AS a;
SELECT a FROM t;
DROP TABLE t;
CREATE TABLE t AS
    SELECT CONVERT(X'D83CDF7A' USING utf16) as beer;
SELECT HEX(beer), CHAR_LENGTH(beer) FROM t;
DROP TABLE t;
SELECT CAST(1111111111111111 AS FLOAT) = CAST(1111111111111110 AS FLOAT) AS eq;
SELECT CAST(CAST(1111111111111111 AS FLOAT) AS CHAR) AS v;
SELECT CAST(CAST(1111111111111111 AS FLOAT) AS SIGNED) AS v;
SELECT CAST(CAST(1111111111111111 AS FLOAT) AS DECIMAL(20,2)) AS v;
