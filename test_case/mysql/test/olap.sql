DROP TABLE IF EXISTS t1,t2;

SET @sav_dpi= @@div_precision_increment;
SET div_precision_increment= 5;

CREATE TABLE t1(
product VARCHAR(32),
country_id INTEGER NOT NULL,
year INTEGER,
profit INTEGER);

INSERT INTO t1  VALUES ( 'Computer', 2,2000, 1200),
( 'TV', 1, 1999, 150),
( 'Calculator', 1, 1999,50),
( 'Computer', 1, 1999,1500),
( 'Computer', 1, 2000,1500),
( 'TV', 1, 2000, 150),
( 'TV', 2, 2000, 100),
( 'TV', 2, 2000, 100),
( 'Calculator', 1, 2000,75),
( 'Calculator', 2, 2000,75),
( 'TV', 1, 1999, 100),
( 'Computer', 1, 1999,1200),
( 'Computer', 2, 2000,1500),
( 'Calculator', 2, 2000,75),
( 'Phone', 3, 2003,10)
;

CREATE TABLE t2 (
country_id INTEGER PRIMARY KEY,
country CHAR(20) NOT NULL);

INSERT INTO t2 VALUES (1, 'USA'),(2,'India'), (3,'Finland');

-- First simple rollups, with just grand total
--sorted_result
SELECT product, SUM(profit) FROM t1 GROUP BY product;
SELECT product, SUM(profit) FROM t1 GROUP BY product WITH ROLLUP;
SELECT product, SUM(profit) FROM t1 GROUP BY 1 WITH ROLLUP;
SELECT product, SUM(profit),AVG(profit) FROM t1 GROUP BY product WITH ROLLUP;

-- Sub totals
--sorted_result
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year;
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year WITH ROLLUP;
SELECT product, country_id , SUM(profit) FROM t1
GROUP BY product, country_id WITH ROLLUP
ORDER BY product DESC, GROUPING (country_id), country_id;

-- limit
--echo
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year WITH ROLLUP LIMIT 5;
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year WITH ROLLUP limit 3,3;
SELECT product, country_id, COUNT(*), COUNT(distinct year)
FROM t1 GROUP BY product, country_id;
SELECT product, country_id, COUNT(*), COUNT(distinct year)
FROM t1 GROUP BY product, country_id WITH ROLLUP;

-- Test of having
--echo
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year WITH ROLLUP HAVING country_id = 1;
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year WITH ROLLUP HAVING SUM(profit) > 200;
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year WITH ROLLUP HAVING SUM(profit) > 7000;

-- Functions
--sorted_result
SELECT CONCAT(product,':',country_id) AS 'prod', CONCAT(":",year,":") AS 'year',
1+1, SUM(profit)/COUNT(*) FROM t1 GROUP BY 1,2 WITH ROLLUP;
SELECT product, SUM(profit)/COUNT(*) FROM t1 GROUP BY product WITH ROLLUP;
SELECT LEFT(product,4) AS prod, SUM(profit)/COUNT(*) FROM t1
GROUP BY prod WITH ROLLUP;
SELECT CONCAT(product,':',country_id), 1+1, SUM(profit)/COUNT(*) FROM t1
GROUP BY CONCAT(product,':',country_id) WITH ROLLUP;

SET @saved_sql_mode = @@session.sql_mode;
SET SESSION sql_mode= '';
SELECT UPPER(product) AS prod,
       SUM(profit)/COUNT(*)
  FROM t1 GROUP BY prod WITH ROLLUP HAVING prod='COMPUTER' ;
SET SESSION sql_mode= @saved_sql_mode;

-- Joins
SELECT product, country , year, SUM(profit) FROM t1,t2 WHERE
t1.country_id=t2.country_id GROUP BY product, country, year WITH ROLLUP;

-- Derived tables and sub SELECTs
SELECT product, `SUM` FROM (SELECT product, SUM(profit) AS 'sum' FROM t1
                            GROUP BY product WITH ROLLUP) AS tmp
WHERE product is null;
SELECT product FROM t1 WHERE EXISTS
(SELECT product, country_id , SUM(profit) FROM t1 AS t2
 WHERE t1.product=t2.product GROUP BY product, country_id WITH ROLLUP
 HAVING SUM(profit) > 6000);

-- The following does not return the expected answer, but this is a limitation
-- in the implementation so we should just document it
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY product, country_id, year HAVING country_id is NULL;
SELECT CONCAT(':',product,':'), SUM(profit), AVG(profit) FROM t1
GROUP BY product WITH ROLLUP;
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY CUBE (product, country_id, year);
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY CUBE (product, country_id, year)
UNION ALL
SELECT product, country_id , year, SUM(profit) FROM t1
GROUP BY ROLLUP (product, country_id, year);

drop table t1,t2;

--
-- Test bug with const tables
--

CREATE TABLE t1 (i int);
INSERT INTO t1 VALUES(100);
CREATE TABLE t2 (i int);
INSERT INTO t2 VALUES (100),(200);
SELECT i, COUNT(*) FROM t1 GROUP BY i WITH ROLLUP;
SELECT t1.i, t2.i, COUNT(*) FROM t1,t2 GROUP BY t1.i,t2.i WITH ROLLUP;
DROP TABLE t1,t2;

CREATE TABLE user_day(
  user_id INT NOT NULL,
  date DATE NOT NULL,
  UNIQUE INDEX user_date (user_id, date)
);

INSERT INTO user_day VALUES
  (1, '2004-06-06' ),
  (1, '2004-06-07' ),
  (2, '2004-06-06' );

SELECT
       d.date AS day,
       COUNT(d.user_id) as sample,
       COUNT(next_day.user_id) AS not_cancelled
  FROM user_day d
       LEFT JOIN user_day next_day
       ON next_day.user_id=d.user_id AND
          next_day.date= DATE_ADD( d.date, interval 1 day )
  GROUP BY day;

SELECT
       d.date AS day,
       COUNT(d.user_id) as sample,
       COUNT(next_day.user_id) AS not_cancelled
  FROM user_day d
       LEFT JOIN user_day next_day
       ON next_day.user_id=d.user_id AND
          next_day.date= DATE_ADD( d.date, interval 1 day )
  GROUP BY day
    WITH ROLLUP;

DROP TABLE user_day;

--
-- Tests for bugs #8616, #8615: distinct sum with rollup
--

CREATE TABLE t1 (a int, b int);

INSERT INTO t1 VALUES
  (1,4),
  (2,2), (2,2),
  (4,1), (4,1), (4,1), (4,1),
  (2,1), (2,1);
SELECT SUM(b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT DISTINCT SUM(b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT SUM(b), COUNT(DISTINCT b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT DISTINCT SUM(b), COUNT(DISTINCT b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT SUM(b), COUNT(*) FROM t1 GROUP BY a WITH ROLLUP;
SELECT DISTINCT SUM(b), COUNT(*) FROM t1 GROUP BY a WITH ROLLUP;
SELECT SUM(b), COUNT(DISTINCT b), COUNT(*) FROM t1 GROUP BY a WITH ROLLUP;
SELECT DISTINCT SUM(b), COUNT(DISTINCT b), COUNT(*) FROM t1
  GROUP BY a WITH ROLLUP;
SELECT a, SUM(b) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT DISTINCT a, SUM(b) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT b, a, SUM(b) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT DISTINCT b,a, SUM(b) FROM t1 GROUP BY a,b WITH ROLLUP;

ALTER TABLE t1 ADD COLUMN c INT;
SELECT a,b,SUM(c) FROM t1 GROUP BY a,b,c WITH ROLLUP;
SELECT distinct a,b,SUM(c) FROM t1 GROUP BY a,b,c WITH ROLLUP;

DROP TABLE t1;

--
-- Tests for bugs #8617: SQL_CACL_FOUND_ROWS with rollup and limit
--

CREATE TABLE t1 (a int, b int);

INSERT INTO t1 VALUES
  (1,4),
  (2,2), (2,2),
  (4,1), (4,1), (4,1), (4,1),
  (2,1), (2,1);

SELECT a, SUM(b) FROM t1 GROUP BY a WITH ROLLUP LIMIT 1;
SELECT SQL_CALC_FOUND_ROWS a, SUM(b) FROM t1 GROUP BY a WITH ROLLUP LIMIT 1;

DROP TABLE t1;

--
-- Tests for bug #9681: ROLLUP in subquery for derived table wiht
--                      a group by field declared as NOT NULL
--

CREATE TABLE t1 (a int(11) NOT NULL);
INSERT INTO t1 VALUES (1),(2);

SELECT a, SUM(a) m FROM  t1 GROUP BY a WITH ROLLUP;
SELECT * FROM ( SELECT a, SUM(a) m FROM  t1 GROUP BY a WITH ROLLUP ) t2;

DROP TABLE t1;
set div_precision_increment= @sav_dpi;

--
-- Tests for bug #7914: ROLLUP over expressions on temporary table
--

CREATE TABLE t1 (a int(11));
INSERT INTO t1 VALUES (1),(2);

SELECT a, SUM(a), SUM(a)+1 FROM (SELECT a FROM t1 UNION select 2) d
  GROUP BY a;
SELECT a, SUM(a), SUM(a)+1 FROM (SELECT a FROM t1 UNION select 2) d
  GROUP BY a WITH ROLLUP;

SELECT a, SUM(a), SUM(a)+1 FROM (SELECT 1 a UNION select 2) d
  GROUP BY a;
SELECT a, SUM(a), SUM(a)+1 FROM (SELECT 1 a UNION select 2) d
  GROUP BY a WITH ROLLUP;

SELECT a, SUM(a), SUM(a)+1, CONCAT(SUM(a),'x'), SUM(a)+SUM(a), SUM(a)
  FROM (SELECT 1 a, 2 b UNION SELECT 2,3 UNION SELECT 5,6 ) d
    GROUP BY a WITH ROLLUP;

DROP TABLE t1;

--
-- Tests for bug #7894: ROLLUP over expressions on group by attributes
--

CREATE TABLE t1 (a int(11));
INSERT INTO t1 VALUES (1),(2);

SELECT a, a+1, SUM(a) FROM t1 GROUP BY a WITH ROLLUP;
SELECT a+1 FROM t1 GROUP BY a WITH ROLLUP;
SELECT a+SUM(a) FROM t1 GROUP BY a WITH ROLLUP;
SELECT a, a+1 as b FROM t1 GROUP BY a WITH ROLLUP HAVING b > 2;
SELECT a, a+1 as b FROM t1 GROUP BY a WITH ROLLUP HAVING a IS NULL;
SELECT a, a+1 as b FROM t1 GROUP BY a WITH ROLLUP HAVING b IS NULL;
SELECT IFNULL(a, 'TEST') FROM t1 GROUP BY a WITH ROLLUP;

CREATE TABLE t2 (a int, b int);
INSERT INTO t2 VALUES
  (1,4),
  (2,2), (2,2),
  (4,1), (4,1), (4,1), (4,1),
  (2,1), (2,1);

SELECT a,b,SUM(b) FROM t2 GROUP BY a,b WITH ROLLUP;
SELECT a,b,SUM(b), a+b as c FROM t2
  GROUP BY a,b WITH ROLLUP HAVING c IS NULL;
SELECT IFNULL(a, 'TEST'), COALESCE(b, 'TEST') FROM t2
  GROUP BY a, b WITH ROLLUP;

DROP TABLE t1,t2;

--
-- Test for bug #11543: ROLLUP query with a repeated column in GROUP BY
--

CREATE TABLE t1 (a INT(10) NOT NULL, b INT(10) NOT NULL);
INSERT INTO t1 VALUES (1, 1);
INSERT INTO t1 VALUES (1, 2);

--
-- In SQL, conceptually GROUP BY (and thus also ROLLUP) happens before
-- projection (the SELECT list), so GROUP BY on aliases is disallowed.
-- However, MySQL extends the standard by allowing such aliases.
-- This makes the following query ambiguous, and MySQL has gone back and forth
-- a few times on what the implementation should be.
--
-- After reading t1 and doing GROUP BY, the rows will look like this:
--
--   <group 1, a>  <group 2, b>  <group 3, a>  COUNT(*)
--   1             1             1             1
--   1             1             NULL          1
--   1             2             1             1
--   1             2             NULL          1
--   1             NULL          NULL          2
--   NULL          NULL          NULL          2
--
-- Now, in the projection, what does the three parameters resolve to?
-- It is obvious that b has to resolve to <group 2>, since that is the
-- only candidate. The first a (the one without an alias) could resolve
-- to either <group 1> or <group 3>, but we arbitrarily (and not unreasonably)
-- resolve it to the one that is specified the first, ie., <group 1>.
--
-- Now, what should “a AS c” resolve to? It would not be unreasonable to
-- resolve it consistently with the first a, ie., to <group 1>. The alternative,
-- which is what Postgres chooses, is to say that “a AS c” fits better with
-- <group 3> due to the alias. Both are possible, and we make no guarantee
-- that it will not change in the future, but for now, we've chosen to do the
-- same.
--
SELECT a, b, a AS c, COUNT(*) AS count FROM t1 GROUP BY a, b, c WITH ROLLUP;

DROP TABLE t1;

-- Bug #12885(1): derived table specified by a subquery with
--                ROLLUP over expressions on not nullable group by attributes
--

CREATE TABLE t1 (a int(11) NOT NULL);
INSERT INTO t1 VALUES (1),(2);

SELECT * FROM (SELECT a, a + 1, COUNT(*) FROM t1 GROUP BY a WITH ROLLUP) t;
SELECT * FROM (SELECT a, LENGTH(a), COUNT(*) FROM t1 GROUP BY a WITH ROLLUP) t;

DROP TABLE t1;

--
-- Bug #12887 Distinct is not always applied after rollup
--
CREATE TABLE t1 ( a VARCHAR(9), b INT );
INSERT INTO t1 VALUES('a',1),(NULL,2);
SELECT a, MAX(b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT DISTINCT a, MAX(b) FROM t1 GROUP BY a WITH ROLLUP;
DROP TABLE t1;

--
-- Bug #20825: rollup puts non-equal values together
--
CREATE TABLE t1 (a VARCHAR(22) NOT NULL , b INT);
INSERT INTO t1 VALUES ("2006-07-01 21:30", 1), ("2006-07-01 23:30", 10);
SELECT LEFT(a,10), a, SUM(b) FROM t1 GROUP BY 1,2 WITH ROLLUP;
SELECT LEFT(a,10) x, a, SUM(b) FROM t1 GROUP BY x,a WITH ROLLUP;
DROP TABLE t1;

--
-- Bug #24856: ROLLUP by const item in a query with DISTINCT
--

CREATE TABLE t1 (a int, b int);
INSERT INTO t1
  VALUES (2,10),(3,30),(2,40),(1,10),(2,30),(1,20),(2,10);
SELECT a, SUM(b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT DISTINCT a, SUM(b) FROM t1 GROUP BY a WITH ROLLUP;
SELECT a, b, COUNT(*) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT DISTINCT a, b, COUNT(*) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT 'x', a, SUM(b) FROM t1 GROUP BY 1,2 WITH ROLLUP;
SELECT DISTINCT 'x', a, SUM(b) FROM t1 GROUP BY 1,2 WITH ROLLUP;
SELECT DISTINCT 'x', a, SUM(b) FROM t1 GROUP BY 1,2 WITH ROLLUP;

DROP TABLE t1;

-- End of 4.1 tests

--
-- Tests for bug #11639: ROLLUP over view executed through filesort
--

CREATE TABLE t1(id int, type char(1));
INSERT INTO t1 VALUES
  (1,"A"),(2,"C"),(3,"A"),(4,"A"),(5,"B"),
  (6,"B"),(7,"A"),(8,"C"),(9,"A"),(10,"C");
CREATE VIEW v1 AS SELECT * FROM t1;

SELECT type FROM t1 GROUP BY type WITH ROLLUP;
SELECT type FROM v1 GROUP BY type WITH ROLLUP;

DROP VIEW v1;
DROP TABLE t1;

--
-- Bug #12885(2): view specified by a subquery with
--                ROLLUP over expressions on not nullable group by attributes
--

CREATE TABLE t1 (a int(11) NOT NULL);
INSERT INTO t1 VALUES (1),(2);

CREATE VIEW v1 AS
  SELECT a, LENGTH(a), COUNT(*) FROM t1 GROUP BY a WITH ROLLUP;
SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;

--
-- Bug #26830: derived table WITH ROLLUP
--

CREATE TABLE t1 (a int, KEY (a));
INSERT INTO t1 VALUES (3), (1), (4), (1), (3), (1), (1);

SELECT * FROM (SELECT a, SUM(a) FROM t1 GROUP BY a WITH ROLLUP) as t;

DROP TABLE t1;
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT COUNT(a) FROM t1 GROUP BY NULL WITH ROLLUP;
DROP TABLE t1;

--
-- Bug #32558: group by null-returning expression with rollup causes crash
--
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(0);
SELECT 1 FROM t1 GROUP BY (DATE(NULL)) WITH ROLLUP;
DROP TABLE t1;

CREATE TABLE t1 (a INT NOT NULL PRIMARY KEY);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (b INT);
INSERT INTO t2 VALUES (100);

-- Verify that the sorting iterator does not have any rollup_group_item()
-- in its sorting list, since the sorting is before group by.
--skip_if_hypergraph  -- Does not have the unneeded extra temporary table.
EXPLAIN FORMAT=tree
SELECT a, b FROM t1, t2 GROUP BY a, b WITH ROLLUP;
SELECT a, b FROM t1, t2 GROUP BY a, b WITH ROLLUP;
SELECT DISTINCT b FROM t1, t2 GROUP BY a, b WITH ROLLUP;

DROP TABLE t1, t2;

CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
SELECT b FROM t1, t2 GROUP BY a, b WITH ROLLUP;
SELECT DISTINCT b FROM t1, t2 GROUP BY a, b WITH ROLLUP;

DROP TABLE t1, t2;

CREATE TABLE t1 (f1 DATETIME);
INSERT INTO  t1 VALUES ('2012-12-20 00:00:00'), (NULL);

SELECT f1 FROM t1 GROUP BY
(SELECT f1 FROM t1 HAVING f1 < '2012-12-21 00:00:00') WITH ROLLUP;

DROP TABLE t1;

CREATE TABLE t1 (f1 DATE);
INSERT INTO  t1 VALUES ('2012-12-20'), (NULL);

SELECT f1 FROM t1 GROUP BY
(SELECT f1 FROM t1 HAVING f1 < '2012-12-21') WITH ROLLUP;

DROP TABLE t1;

CREATE TABLE t1 (f1 TIME);
INSERT INTO  t1 VALUES ('11:11:11'), (NULL);

SELECT f1 FROM t1 GROUP BY
(SELECT f1 FROM t1 HAVING f1 < '12:12:12') WITH ROLLUP;

DROP TABLE t1;

CREATE TABLE t1(a INTEGER) engine=innodb;
SELECT NOW() FROM t1 GROUP BY (select 1) WITH ROLLUP;
DROP TABLE t1;

CREATE TABLE t1(a INTEGER) engine=innodb;
SELECT RELEASE_ALL_LOCKS() FROM t1 GROUP BY a WITH ROLLUP;
DROP TABLE t1;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(0);
INSERT INTO t1 VALUES(1);
SELECT NOT EXISTS (SELECT 1) FROM t1 JOIN t1 a USING(a)
GROUP BY 1 WITH ROLLUP ORDER BY 1 DESC;
DROP TABLE t1;

CREATE TABLE t0 (i0 INTEGER);

INSERT INTO t0 VALUES (1), (2), (3), (4), (5);

CREATE TABLE t1 (
  a INTEGER,
  b INTEGER,
  c INTEGER,
  INDEX k1 (a),
  INDEX k2 (a,b)
);

INSERT INTO t1
  SELECT i0 + (10 * i0) + (100 * i0),
    (i0 + (10 * i0) + (100 * i0)) % 100,
    (i0 + (10 * i0) + (100 * i0)) % 100
  FROM t0;

INSERT INTO t1
  SELECT i0 + (10 * i0) + (100 * i0),
    (i0 + (10 * i0) + (100 * i0) + 1) % 100,
    (i0 + (10 * i0) + (100 * i0) + 1) % 100
  FROM t0;

INSERT INTO t1
  SELECT i0 + (10 * i0) + (100 * i0),
    (i0 + (10 * i0) + (100 * i0) + 1) % 100,
    (i0 + (10 * i0) + (100 * i0) + 2) % 100
  FROM t0;

SELECT * FROM t1 ORDER BY a,b,c;

-- Testing for syntax
-- Success cases
SELECT a, b, c, GROUPING(a) FROM t1 GROUP BY a,b,c WITH ROLLUP;
SELECT a, b, c, GROUPING(a, b) FROM t1 GROUP BY a,b,c WITH ROLLUP;
SELECT a, b, c, GROUPING(a, b, c) FROM t1 GROUP BY a,b,c WITH ROLLUP;
SELECT a, b FROM t1 GROUP BY a,b WITH ROLLUP HAVING GROUPING(b) = 1;

-- Failure cases
--error ER_FIELD_IN_GROUPING_NOT_GROUP_BY
SELECT a, b, GROUPING(c) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT a, b, c, GROUPING(a, b, c) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT a, GROUPING(SUM(a)) FROM t1 GROUP BY (a) WITH ROLLUP;
SELECT a, b, GROUPING(a) FROM t1 GROUP BY a,b;
SELECT a, b, GROUPING(a) FROM t1 ;
SELECT a, b FROM t1 WHERE GROUPING(a)=1 GROUP BY a,b WITH ROLLUP;
SELECT a, b FROM t1 GROUP BY GROUPING(a),GROUPING(b) WITH ROLLUP;

-- Check for GROUPING by position. We do not allow it
-- error ER_WRONG_ARGUMENTS
SELECT a, b, c, GROUPING(1) FROM t1 GROUP BY a,b,c WITH ROLLUP;
SELECT a, GROUPING(1) FROM t1 GROUP BY 1 WITH ROLLUP;
SELECT GROUPING(1) FROM t1 GROUP BY 1 WITH ROLLUP;

-- Check the restriction on the number of args to
-- grouping function
let $query1= CREATE TABLE t3 (;
let $col_cnt=64;
{
  let $query1= $query1 i$col_cnt INTEGER,;
  dec $col_cnt;

let $query1= $query1 i65 INTEGER);

let $query= SELECT GROUPING(;
let col_cnt=64;
let $query= $query i$col_cnt,;
dec $col_cnt;
let $query= $query i65) FROM t3 GROUP BY (i1) WITH ROLLUP;
DROP TABLE t3;

-- Check for expressions
--error ER_FIELD_IN_GROUPING_NOT_GROUP_BY
SELECT a, b, GROUPING(c + c) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT a, b, GROUPING(c + c) FROM t1 GROUP BY a,b,(c + c) WITH ROLLUP;

-- We do not allow sub-queries as arguments to GROUPING()
--error ER_FIELD_IN_GROUPING_NOT_GROUP_BY
SELECT GROUPING((SELECT MAX(b) FROM t1)) FROM t1
GROUP BY (SELECT MAX(b) FROM t1) WITH ROLLUP;
SELECT (SELECT MAX(b) FROM t1) FROM t1 GROUP BY (SELECT MAX(b) FROM t1)
  WITH ROLLUP HAVING GROUPING((SELECT 1 FROM DUAL))=0;
SELECT (SELECT MAX(b) FROM t1) FROM t1 GROUP BY (SELECT MAX(b) FROM t1)
  WITH ROLLUP HAVING GROUPING((SELECT MAX(b) FROM t1))=0;

-- Test GROUPING() with ALL/ANY/EXISTS
SELECT 1 WHERE EXISTS (SELECT a FROM t1 GROUP BY a WITH ROLLUP);
SELECT 1 WHERE 2 >
ALL (SELECT GROUPING(a) FROM t1 GROUP BY a WITH ROLLUP);
SELECT 1 WHERE 1 =
ANY (SELECT GROUPING(a) FROM t1 GROUP BY a WITH ROLLUP);

-- Test with prepared statements
PREPARE ps FROM "SELECT a FROM t1 GROUP BY a WITH ROLLUP HAVING GROUPING(a)=0";

-- Test with derived tables with prepared statements
CREATE VIEW v AS SELECT * FROM t1;
DROP VIEW v;

-- Test with view and GROUPING() in having clause
--CREATE VIEW v AS SELECT (SELECT  MAX(a) FROM t1) as field1 FROM t1
--GROUP BY field1 WITH ROLLUP HAVING GROUPING(field1)=0;

-- Test with derived tables
SELECT  MAX(a) FROM t1 WHERE (b) IN (SELECT MIN(t2.b)
FROM (SELECT b from t1) AS t2 GROUP BY t2.b);
SELECT  MAX(a) FROM t1 WHERE (b) IN (SELECT MIN(t2.b)
FROM t1 AS t2 GROUP BY t2.b WITH
ROLLUP HAVING GROUPING (t2.b)=0);
SELECT  MAX(a) FROM t1 WHERE (b) IN (SELECT MIN(t2.b)
FROM (SELECT b from t1) AS t2 GROUP BY t2.b WITH
ROLLUP HAVING GROUPING (t2.b)=0);
            GROUP BY a,b,c WITH ROLLUP)
SELECT * FROM qn;
SELECT * FROM qn;
SELECT MIN(t2.b) FROM (SELECT b from t1) AS t2 GROUP BY t2.b WITH
ROLLUP HAVING GROUPING (t2.b)=0))
SELECT * FROM qn;
           FROM t1 GROUP BY (SELECT MAX(b) FROM t1) WITH ROLLUP)
SELECT qn.field1 FROM qn;

-- Usage

-- Check for grouping of the two columns
SELECT a as Department,b as Employees, SUM(c), GROUPING(a) as GP_A,
       GROUPING(b) as GP_B FROM t1 GROUP BY a,b WITH ROLLUP;

-- Check for the rows having only super-aggregates
SELECT a as Department,b as Employees, SUM(c), GROUPING(a) as GP_A,
       GROUPING(b) as GP_B FROM t1 GROUP BY a,b WITH ROLLUP
       HAVING GP_A=1 OR GP_B=1;

-- Differentiate Super-Aggregates and Aggregates
SELECT IF(GROUPING(a)=1,'All Departments', a) as Department,
       IF(GROUPING(b)=1, 'All Employees', b) as Employees,
       SUM(c) as SUM
FROM t1 GROUP BY a,b WITH ROLLUP;

-- Use grouping to differentiate between NULLs FROM the table data
-- and NULLs FROM the ROLLUP

INSERT INTO t1 values (1111,NULL,112);
INSERT INTO t1 values (1111,NULL,NULL);
INSERT INTO t1 values (NULL,112,NULL);

SELECT a as Department, b as Employees, SUM(c), GROUPING(a) as GP_A,
       GROUPING(b) as GP_B FROM t1 GROUP BY a,b WITH ROLLUP;

SELECT a as Department, b as Employees, SUM(c), GROUPING(a) as GP_A,
       GROUPING(b) as GP_B FROM t1 GROUP BY a,b WITH ROLLUP
       HAVING (GP_A =1 AND GP_B=1) OR (GP_B=1);

SELECT a, b, a + COALESCE(b, 0), AVG(b) OVER () FROM t1 GROUP BY a, b WITH ROLLUP;

DROP TABLE t0,t1;

-- End of test for WL#1979

--echo --
--echo -- Bug#25174118 ROLLUP NULL'S GET REPLACED WITH LAST ROW'S VALUE FOR PREPARED STMTS ON A VIEW
--echo --

CREATE TABLE t(a INT);
INSERT INTO t VALUES(1),(2),(3);
CREATE VIEW v AS SELECT * FROM t;
SELECT COALESCE(a,'rollup_null') FROM v GROUP BY a WITH ROLLUP;
DROP TABLE t;
DROP PREPARE ps;
DROP VIEW v;

CREATE TABLE t0 (i0 INTEGER);
INSERT INTO t0 VALUES (1), (2), (3), (4), (5);

CREATE TABLE t1 (i INTEGER, j INTEGER, k INTEGER, INDEX k1(i), INDEX k2(j,k));
INSERT INTO t1
  SELECT i0 + (10 * i0) + (100 * i0),
    (i0 + (10 * i0) + (100 * i0)) % 100,
    (i0 + (10 * i0) + (100 * i0)) % 100
  FROM t0;

INSERT INTO t1
  SELECT i0 + (10 * i0) + (100 * i0),
    (i0 + (10 * i0) + (100 * i0) + 1) % 100,
    (i0 + (10 * i0) + (100 * i0) + 1) % 100
  FROM t0;

INSERT INTO t1
  SELECT i0 + (10 * i0) + (100 * i0),
    (i0 + (10 * i0) + (100 * i0) + 1) % 100,
    (i0 + (10 * i0) + (100 * i0) + 2) % 100
  FROM t0;
SELECT i, j, AVG(k) FROM t1 GROUP BY i,j WITH ROLLUP ORDER BY i,j;
SELECT i, j, AVG(k) FROM t1 GROUP BY i,j WITH ROLLUP ORDER BY i,j LIMIT 5;
SELECT i, j, SUM(k) FROM t1 GROUP BY i,j WITH ROLLUP
HAVING i > 10 and j < 1000 ORDER BY i,j;
SELECT i, j, SUM(k)/COUNT(*) as avg FROM t1 GROUP BY i,j WITH ROLLUP
ORDER BY avg;
SELECT CONCAT(i,':',j) as ij, CONCAT(j,':',i) as ji FROM t1 GROUP BY ij, ji
WITH ROLLUP ORDER BY ij,ji;
SELECT i, sum FROM (SELECT i, SUM(j) AS 'sum' FROM t1 GROUP BY i WITH ROLLUP
                      ORDER BY i) AS tmp WHERE i is NULL;
SELECT i FROM t1 WHERE EXISTS (SELECT i, j, SUM(k) FROM t1 AS t2
                               WHERE t1.i=t2.i GROUP BY i,j WITH ROLLUP
                               HAVING SUM(k) > 40 ORDER BY i,j );
SELECT a, SUM(a), SUM(a)+1, CONCAT(SUM(a),'x'), SUM(a)+SUM(a), SUM(a)
  FROM (SELECT 1 a, 2 b UNION SELECT 2,3 UNION SELECT 5,6 ) d
      GROUP BY a WITH ROLLUP ORDER BY SUM(a);
SELECT i, j, i AS k, COUNT(*) AS count FROM t1 GROUP BY i, j, k WITH ROLLUP;
SELECT * FROM (SELECT i, j, SUM(k) FROM t1 GROUP BY i, j WITH ROLLUP) as tmp
ORDER BY i,j;
SELECT i, j, i+j, AVG(j) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NULL ORDER BY i;
SELECT i, j, i+j, FIRST_VALUE(i) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NULL ORDER BY i;
SELECT i,j FROM t1 GROUP BY i,j WITH ROLLUP HAVING i=111 ORDER BY i;
SELECT i,j FROM t1 GROUP BY i,j WITH ROLLUP HAVING i+j < 200 ORDER BY i;
SELECT i, j, i+j, AVG(k) from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NULL ORDER BY i;
SELECT i, j, i+j, AVG(k) from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NOT NULL ORDER BY i+j;
SELECT i, GROUPING(i+j), AVG(k) from t1 GROUP BY i,i+j WITH ROLLUP
HAVING i is NOT NULL ORDER BY i+j;
SELECT i, GROUPING(i+j), AVG(k) from t1 GROUP BY i,i+j WITH ROLLUP
HAVING AVG(k) > 10 ORDER BY i;
SELECT i, GROUPING(i+j), AVG(k) from t1 GROUP BY i,i+j WITH ROLLUP
HAVING AVG(k) + 20 < 35 ORDER BY i;
SELECT DISTINCT i,j FROM t1 GROUP BY i,j WITH ROLLUP HAVING i=111 ORDER BY i;
SELECT DISTINCT i FROM t1 GROUP BY i,j WITH ROLLUP HAVING i=111 ORDER BY i;
SELECT DISTINCT i,j FROM t1 GROUP BY i,j WITH ROLLUP
HAVING i+j < 200 ORDER BY i;
SELECT DISTINCT i, j, i+j, AVG(k) from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NULL ORDER BY i;
SELECT DISTINCT i, j, i+j, AVG(k) from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NOT NULL ORDER BY i+j;
SELECT DISTINCT i, i+j, GROUPING(i+j), AVG(k) from t1 GROUP BY i,i+j WITH ROLLUP
HAVING i is NOT NULL ORDER BY i+j;
SELECT DISTINCT i, GROUPING(i+j), AVG(k) from t1 GROUP BY i,i+j WITH ROLLUP
HAVING AVG(k) > 10 ORDER BY i;
SELECT DISTINCT i, GROUPING(i+j), AVG(k) from t1 GROUP BY i,i+j WITH ROLLUP
HAVING AVG(k) + 20 < 35 ORDER BY i;
SELECT i, j, AVG(k) FROM t1 GROUP BY i,j WITH ROLLUP
ORDER BY GROUPING(i),i,GROUPING(j),j;
SELECT i, j, AVG(k) FROM t1 GROUP BY i,j WITH ROLLUP
ORDER BY GROUPING(i),i,GROUPING(j),j LIMIT 5;
SELECT i, j, SUM(k) FROM t1 GROUP BY i,j WITH ROLLUP
HAVING i > 10 and j < 1000 ORDER BY GROUPING(i),i,GROUPING(j),j;
SELECT CONCAT(i,':',j) as ij, CONCAT(j,':',i) as ji FROM t1
GROUP BY ij, ji WITH ROLLUP ORDER BY GROUPING(ij),ij,GROUPING(ji),ji;
SELECT i, 'sum' FROM (SELECT i, SUM(j) AS 'sum' FROM t1 GROUP BY i
                      WITH ROLLUP ORDER BY GROUPING(i),i) AS tmp WHERE i is NULL;
SELECT i FROM t1 WHERE EXISTS (SELECT i, j, SUM(k) FROM t1 AS t2
                               WHERE t1.i=t2.i GROUP BY i,j WITH ROLLUP
                               HAVING SUM(k) > 40 ORDER BY GROUPING(i),i,
                               GROUPING(j),j);
SELECT a, SUM(a), SUM(a)+1, CONCAT(SUM(a),'x'), SUM(a)+SUM(a), SUM(a)
  FROM (SELECT 1 a, 2 b UNION SELECT 2,3 UNION SELECT 5,6 ) d
      GROUP BY a WITH ROLLUP ORDER BY GROUPING(a),a;
SELECT i, j, i AS k, COUNT(*) AS count FROM t1 GROUP BY i, j, k WITH ROLLUP
ORDER BY GROUPING(i),i, GROUPING(j),j, GROUPING(k),k;
SELECT * FROM (SELECT i, j, SUM(k) FROM t1 GROUP BY i, j WITH ROLLUP
               ORDER BY GROUPING(i),i, GROUPING(j),j) as tmp;
SELECT i, j, i+j, AVG(j) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NULL ORDER BY GROUPING(i);
SELECT i, j, i+j, FIRST_VALUE(i) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING i+j is NULL ORDER BY GROUPING(i);
SELECT i, j, i+j, FIRST_VALUE(i) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING GROUPING(i) = 1 ORDER BY GROUPING(i);
SELECT i, j, i+j, FIRST_VALUE(i) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING 1 + 2 - GROUPING(i) = 2 ORDER BY GROUPING(i);
SELECT i, j, i+j, AVG(j), AVG(j) over () from t1 GROUP BY i,j WITH ROLLUP
HAVING GROUPING(j)+AVG(j) > 11 ORDER BY GROUPING(i);
SELECT i,j, SUM(k), GROUPING(i), GROUPING(j) FROM t1 GROUP BY i,j
WITH ROLLUP HAVING GROUPING(i) = 1 OR GROUPING (j) = 1
ORDER BY GROUPING(i),i,GROUPING(j),j;
SELECT DISTINCT GROUPING(i), GROUPING(j) FROM t1 GROUP BY i,j WITH ROLLUP;
SELECT DISTINCT GROUPING(i), GROUPING(j) FROM t1 GROUP BY i,j WITH ROLLUP
ORDER BY GROUPING(i), GROUPING(j);
SELECT DISTINCT j, GROUPING(j) FROM t1 GROUP BY i,j WITH ROLLUP;
SELECT i, j, AVG(k) FROM t1 GROUP BY i,j+GROUPING(i) WITH ROLLUP;

DROP TABLE t0,t1;

CREATE TABLE t1 (
  f1 INTEGER,
  pk INTEGER NOT NULL,
  PRIMARY KEY (pk)
);

INSERT INTO t1 VALUES(7,3);

-- See the discussion on #11543 above for how field1 and field2 are resolved.
--sorted_result
SELECT  alias1.f1 AS field1, alias1.f1 AS field2, (alias1.f1 +1) AS field3 FROM
  ( t1 AS alias1, t1 as alias2 ) WHERE alias1.pk = 3
  GROUP BY field1, field2, field3 WITH ROLLUP  ORDER BY field2;

SELECT f1 FROM t1 WHERE pk = 3 GROUP BY f1 WITH ROLLUP ORDER BY f1;
DROP TABLE t1;

CREATE TABLE t1(
  pk INTEGER NOT NULL AUTO_INCREMENT,
  col_time time DEFAULT NULL,
  PRIMARY KEY (pk)
);

INSERT INTO t1 VALUES (1,'00:20:09'),(2,'00:20:01'),(3,'00:20:02');

SELECT GROUPING(table2.col_time) AS field1 FROM t1 AS table1,t1 as table2
  WHERE table2.pk = 1 GROUP BY table2.col_time WITH ROLLUP
  ORDER BY GROUPING(table2.col_time);

DROP TABLE t1;

CREATE TABLE t(a INT,b BLOB);
INSERT INTO t VALUES (1,'a'),(1,'b'),(2,'c'),(3,'d');

-- This query is pretty nonsensical, and the query output itself doesn't matter much;
SELECT (((@e:=`b`)) NOT BETWEEN 0x0b5f09 AND (CHAR(md5(@pub1),
  (CONNECTION_ID()+LEAD(5225.750000,110) RESPECT NULLS OVER(ORDER BY b, a)))))
  FROM t GROUP BY b,a WITH ROLLUP;

SELECT a + COUNT(*) OVER () FROM t GROUP BY a WITH ROLLUP;

SELECT a, b, a + SUM(a) OVER () FROM t GROUP BY a,b WITH ROLLUP;

DROP TABLE t;
CREATE TABLE t1 (a int, b int);
INSERT INTO t1 VALUES
  (1,4),
  (2,2), (2,2),
  (4,1), (4,1), (4,1), (4,1),
  (2,1), (2,1);
SELECT (a+1) IS NULL, GROUPING(a+1) FROM t1 GROUP BY a+1 WITH ROLLUP;

DROP TABLE t1;
CREATE TABLE t(a INT);
INSERT INTO t VALUES (1), (2), (3);
SELECT a AS f1, 'w' AS f2 FROM t GROUP BY f1, f2 WITH ROLLUP HAVING ISNULL(f2);
SELECT a AS f1, 'w' AS f2 FROM t GROUP BY f1, f2 WITH ROLLUP HAVING ISNULL(f1);
SELECT a AS f1, 'w' AS f2 FROM t GROUP BY f1, f2 WITH ROLLUP HAVING GROUPING(f2)=1;
SELECT a AS f1, 'w' AS f2 FROM t GROUP BY f1, f2 WITH ROLLUP HAVING GROUPING(f2)=0;
SELECT a AS f1, 'w' AS f2 FROM t GROUP BY f1, f2 WITH ROLLUP HAVING GROUPING(f1)=0;
SELECT a = 3,          a AS f1 FROM t GROUP BY f1 WITH ROLLUP;
SELECT a = 3 or a = 3, a AS f1 FROM t GROUP BY f1 WITH ROLLUP;

DROP TABLE t;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (2, 10), (3, NULL);

SELECT DISTINCT COUNT(*), f1+f2 FROM t1 GROUP BY f1+F2 WITH ROLLUP;
SELECT COUNT(*), f1+f2 FROM t1 GROUP BY f1+F2 WITH ROLLUP;

DROP TABLE t1;

CREATE TABLE t1 ( f1 VARCHAR(10) COLLATE utf8mb4_da_0900_ai_ci );
CREATE TABLE t2 AS SELECT f1, COUNT(*) FROM t1 GROUP BY f1 WITH ROLLUP;

DROP TABLE t1, t2;

CREATE TABLE t1 ( a INTEGER, b INTEGER );
INSERT INTO t1 VALUES (1,1), (1,2), (2,3), (2,4);
SELECT a, b, 2*a+b, SUM(a+b) OVER () FROM t1 GROUP BY a, b WITH ROLLUP;
DROP TABLE t1;

CREATE TABLE IF NOT EXISTS t1 (a DECIMAL(6,3));
INSERT INTO t1 VALUES (1.1);
SELECT a FROM t1 GROUP BY a WITH ROLLUP;
DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER,f2 INTEGER);
INSERT INTO t1 VALUES (1,10),(1,20),(2,NULL),(2,NULL),(3,50);
SELECT f1, SUM(f2) FROM t1 GROUP BY f1 WITH ROLLUP HAVING SUM(f2) IS NOT NULL;
DROP TABLE t1;

CREATE TABLE t1 ( f1 INTEGER );
CREATE VIEW v1 AS SELECT f1 FROM t1 GROUP BY f1 WITH ROLLUP;
DROP VIEW v1;
DROP TABLE t1;

CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1), (2), (3);
SELECT ( SELECT 'a' ) AS f1
  FROM t1 AS alias1, t1 alias2
  GROUP BY f1 WITH ROLLUP
  HAVING f1 < 7;
DROP TABLE t1;

CREATE TABLE t1 ( i INTEGER NOT NULL PRIMARY KEY );
INSERT INTO t1 VALUES (1), (2), (3);
SELECT DISTINCT i FROM t1 WHERE i = 1 GROUP BY i WITH ROLLUP;
DROP TABLE t1;

CREATE TABLE t1 ( a TIME );

SELECT
  t1.a
FROM
  t1, t1 AS t2
GROUP BY t1.a WITH ROLLUP
HAVING COUNT(*) = 0 AND t1.a = '刔';

DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER PRIMARY KEY);
INSERT INTO t1 values (1);

-- Result should have a NULL for the super-aggregate row
SELECT CONCAT(INSTR(f1,'w')) FROM t1 GROUP BY f1 WITH ROLLUP;

DROP TABLE t1;

CREATE TABLE t1 ( a INTEGER );
DROP TABLE t1;

CREATE TABLE t1 ( a VARCHAR(10), b TIMESTAMP );

SELECT
  REPLACE( IF( t2.a = t2.b, _latin1 'a', 'e'), 'd', 'b' )
FROM
  t1, t1 AS t2
GROUP BY
  REPLACE( IF( t2.a = t2.b, _latin1 'a', 'e'), 'd', 'b' )
WITH ROLLUP;

DROP TABLE t1;

CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (2020, 2);

CREATE TABLE t2 (b INTEGER);
INSERT INTO t2 VALUES (2);

SELECT a, GROUPING(a) AS ga
  FROM t1 JOIN t2 USING (b)
  GROUP BY a WITH ROLLUP
  HAVING ga = 0;

DROP TABLE t1, t2;

CREATE TABLE t (x INTEGER);
INSERT INTO t VALUES (NULL), (0), (1), (2), (3);
SELECT DISTINCT x AS a, x AS b FROM t GROUP BY a, b WITH ROLLUP;
DROP TABLE t;

CREATE TABLE t (id BIGINT AUTO_INCREMENT PRIMARY KEY, i1 INT, i2 INT, i3 INT, s1 VARCHAR(20), s2 VARCHAR(20)) ENGINE=INNODB;
INSERT INTO t VALUES
    (DEFAULT,0,0,NULL, '', NULL), (DEFAULT,0,0,0, '123', 'abc'), (DEFAULT,0,0,1, '456', 'def'),
    (DEFAULT,1,1,NULL, '', NULL), (DEFAULT,1,1,1, '123', 'abc'),  (DEFAULT,1,1,5, '456', 'def'),
    (DEFAULT,1,2,9, '', NULL), (DEFAULT,1,2,9, '123', NULL), (DEFAULT,1,2,10, '456', 'def'),
    (DEFAULT,2,1,1, '', NULL), (DEFAULT,2,1,1, '123', 'abc'),  (DEFAULT,2,1,NULL, '456', 'def'),
    (DEFAULT,2,2,9, '', NULL), (DEFAULT,2,2,NULL, '123', 'abc'), (DEFAULT,2,2,12, '456', NULL),
    (DEFAULT,3,1,1, '', NULL), (DEFAULT,3,1,1, NULL, 'abc'), (DEFAULT,3,1,11, '456', 'def'),
    (DEFAULT,3,2,9, '', NULL), (DEFAULT,3,2,9, '123', 'abc'), (DEFAULT,3,2,16, NULL, 'def'), (DEFAULT,3, 2, 20, '789', 'ghi');

SELECT DISTINCT t1.i1, t1.i2 FROM t AS t1 JOIN t AS t2 ON t1.i3 = t2.i2 GROUP BY t1.i1, t1.i2 WITH ROLLUP ORDER BY t1.i1, t1.i2;
SELECT DISTINCT i1, i2, GROUPING(i1), GROUPING(i2), GROUPING(i1+i2), GROUPING(i1) + GROUPING(i2) FROM t GROUP BY i1, i2, i1 + i2 WITH ROLLUP ORDER BY i1, i2, i1+i2;
SELECT DISTINCT i1, i2, GROUPING(i1), GROUPING(i2) FROM t GROUP BY i1, i2 WITH ROLLUP ORDER BY i1, i2, GROUPING(i1+i2);
DROP TABLE t;
