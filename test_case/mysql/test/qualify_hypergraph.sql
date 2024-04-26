
CREATE TABLE t1 (
  a int NOT NULL,
  b int NOT NULL,
  c double NOT NULL
);
INSERT INTO t1 VALUES (1,1,5),(1,1,2),(1,2,5),(2,1,4),(2,1,1),(2,2,2),(2,2,3),
(2,3,1),(2,3,1),(3,3,3),(3,3,5),(3,4,5),(4,4,5),(4,4,3),(5,3,1);
SELECT a, b, c, ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b,c) AS rnk
FROM t1 QUALIFY rnk>1;
SELECT a, b, c
FROM t1 QUALIFY ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b,c)>1;
SELECT a, b, c
FROM t1
QUALIFY ROW_NUMBER() OVER () >
        (SELECT MIN(c) FROM t1 GROUP BY a  HAVING MAX(c) > 3);
SELECT a, b, c
FROM t1
QUALIFY (MIN(a) OVER () + RANK() OVER () ) > 5;
SELECT a, b, c,
MIN(b) OVER (PARTITION BY b ORDER BY a DESC,b ASC,c DESC) AS mn
FROM t1
QUALIFY ( RANK() OVER () + mn) >5;
SELECT a, b, c,
MIN(b) OVER (PARTITION BY b ORDER BY a DESC,b ASC,c DESC) AS mn,
RANK() OVER (PARTITION BY b ORDER BY a DESC,b ASC,c DESC) AS rnk
FROM t1
QUALIFY ( rnk + mn) >5;
SELECT a, b,
       MIN(b) OVER (PARTITION BY b ORDER BY a DESC,b ASC,c DESC) AS mn,
       RANK() OVER (PARTITION BY b ORDER BY a DESC,b ASC,c DESC) AS rnk
FROM t1
QUALIFY ROW_NUMBER() OVER (PARTITION BY a ORDER BY b)>1;
SELECT
a, b, ( SELECT sum(rnk)
        FROM ( SELECT ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b,c) AS rnk
               FROM t1 qualify rnk > t0.a
              ) as z
      )
FROM (values row(1,10), row(2,20)) as t0(a,b);
SELECT  b
FROM t1
QUALIFY ROW_NUMBER() OVER (PARTITION BY a ORDER BY a)>1;
SELECT  b
FROM t1
QUALIFY ROW_NUMBER() OVER ()>1 and 2*b>2;
SELECT  b
FROM t1
QUALIFY ROW_NUMBER() OVER (PARTITION BY a ORDER BY a)>1 and c>2;
SELECT  b
FROM t1
QUALIFY ROW_NUMBER() OVER (PARTITION BY a ORDER BY a)>1 and a>2;
SELECT a, b, c, ROW_NUMBER() OVER () AS rnk
FROM t1
QUALIFY 2*rnk>1;
SELECT a, b, c, ROW_NUMBER() OVER () AS rnk
FROM t1
QUALIFY a+rnk>5;


--# Aggregate over window functions is not supported
--error ER_WINDOW_INVALID_WINDOW_FUNC_USE
SELECT a, b, c
FROM t1
QUALIFY AVG(ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b,c))>1;
SELECT a FROM t1 QUALIFY b> 10;
SELECT a, b, ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b) AS rnk
FROM t1
QUALIFY c>1;
SELECT a, b, ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b) AS rnk
FROM t1
QUALIFY 2*a>1;
SELECT a
FROM t1
QUALIFY ROW_NUMBER() OVER (PARTITION BY a) + b > 0;
SELECT a, b, ROW_NUMBER() OVER (PARTITION BY a ORDER BY a,b,c) AS rnk
FROM t1
QUALIFY rnk>1 and c>2;
SELECT MAX(a)
FROM t1 GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER () + RANK() OVER () ) > 5;
SELECT MAX(a)
FROM t1 GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER () + RANK() OVER () ) >= 2;
SELECT MAX(a) FROM t1
GROUP BY b, 2*c WITH ROLLUP
HAVING AVG(c)>1
QUALIFY MIN(2*b) OVER () + RANK() OVER () > 3;
SELECT 1 FROM t1
GROUP BY b, 2*c WITH ROLLUP
HAVING AVG(c)>1
QUALIFY MIN(2*b) OVER () + RANK() OVER () + MAX(a) > 4;
SELECT MAX(b) FROM t1
GROUP BY b, 2*c WITH ROLLUP
HAVING AVG(c)>1
QUALIFY MIN(2*b) OVER () + RANK() OVER () + MAX(a) > 4;
SELECT MAX(a) FROM t1
GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER ()) > 1;
SELECT MAX(a)
FROM t1
GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER () + RANK() OVER () ) > 5;

SET @orig_sql_mode = @@sql_mode;
SET @@sql_mode     = '';
SELECT MAX(a)
FROM t1 GROUP BY b WITH ROLLUP
QUALIFY (MIN(c) OVER () + RANK() OVER () ) >= 2;
SELECT MAX(a)
FROM t1 GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER () + RANK() OVER () ) >= 2;
SELECT MAX(a)
FROM t1 GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER () + RANK() OVER () ) > 5;
SELECT MAX(a) FROM t1
GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER ()) > 1;
SELECT MAX(a)
FROM t1
GROUP BY b,c WITH ROLLUP
QUALIFY (MIN(a) OVER () + RANK() OVER () ) > 5;
SELECT a FROM t1 GROUP BY b, 2*c WITH ROLLUP
HAVING AVG(c)>1
QUALIFY ROW_NUMBER() OVER () + MAX(a) > 4;
SELECT a FROM t1
GROUP BY b, 2*c WITH ROLLUP
QUALIFY LEAD(c,2) OVER () > 4;
SELECT a FROM t1
GROUP BY b, 2*c WITH ROLLUP
QUALIFY LAG(c,6) OVER () > 4;
SELECT b,c, MAX(a)
FROM t1 GROUP BY b,c WITH ROLLUP
QUALIFY LEAD(b) OVER(ORDER BY c) >1 AND b IS NULL;

SET @@sql_mode = @orig_sql_mode;
DROP TABLE t1;

CREATE TABLE sales (salesperson_id INT, sale_amount DECIMAL(10, 2));
INSERT INTO sales (salesperson_id, sale_amount)
VALUES (1, 100.00), (2, 200.00), (1, 150.00),
       (3, 300.00),(2, 120.00), (3, 250.00);
SELECT RANK() OVER () AS sales_rank
FROM sales QUALIFY SUM(sale_amount) > 300;

CREATE VIEW v1 as
SELECT salesperson_id,   SUM(sale_amount) AS total_sales,
RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS sales_rank
FROM sales GROUP BY salesperson_id
QUALIFY SUM(sale_amount) > 3000;
SELECT * FROM v1;

SET @start_value_optimizer_switch = @@optimizer_switch;
SET optimizer_switch="hypergraph_optimizer=off";
SELECT * FROM v1;

CREATE VIEW v2 as
SELECT SUM(sale_amount) AS total_sales,
RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS sales_rank
FROM sales GROUP BY salesperson_id
QUALIFY SUM(sale_amount) > 3000;
SELECT * FROM v2;

SET @@optimizer_switch = @start_value_optimizer_switch;
SELECT * FROM v2;

DROP VIEW v1, v2;
DROP TABLE sales;

CREATE TABLE t1 (pk INT);
CREATE TABLE t2 (pk INT, col_decimal_10_8 DECIMAL(10,8));
SET @start_value_optimizer_switch = @@optimizer_switch;
SET optimizer_switch="subquery_to_derived=on,hypergraph_optimizer=on";
SELECT  RANK() OVER () AS field3
FROM t1
 WHERE ( SELECT  MAX( t2.col_decimal_10_8 ) AS derived_1
         FROM  t2) IS NOT NULL
QUALIFY field3 <=> 'a';

SET @@optimizer_switch = @start_value_optimizer_switch;
DROP TABLE t1, t2;

CREATE TABLE t1 (col_varchar137 VARCHAR(137), col_float FLOAT);
CREATE TABLE t2 (pk INT);
SELECT t1.col_varchar137 AS field1
FROM t1, LATERAL ( SELECT t1.col_float AS field2 FROM  t2 ) AS table6
QUALIFY field2 != 'USA';

DROP TABLE t1, t2;

CREATE TABLE t1 (pk INT, col_float_key FLOAT );
CREATE TABLE t2 (col_varchar132 VARCHAR(132), col_timestamp_key TIMESTAMP);
SELECT CUME_DIST() OVER () AS field1
FROM t1
WHERE
  EXISTS ( SELECT LEAST(t2.col_varchar132, t2.col_timestamp_key) AS SQ1_field1
           FROM  t2
         )
  AND ( FLOOR(ATAN(t1.col_float_key) ) IS NULL )
QUALIFY field1 = 'V' COLLATE utf8mb4_icelandic_ci;

DROP TABLE t1, t2;

CREATE TABLE cc (col_time TIME, col_year YEAR, col_double_key DOUBLE,
                 col_char_255 CHAR(255));
SET @orig_sql_mode = @@sql_mode;
SET @@sql_mode     = '';

SELECT SUM( col_time + CAST(col_year AS FLOAT) ) AS field1,
       ROW_NUMBER() OVER () AS field2
FROM cc
WHERE (12, 'H') IN ( SELECT
                        DENSE_RANK() OVER ( ORDER BY col_double_key ),
                        FIRST_VALUE(col_char_255)
                        OVER ( ROWS BETWEEN CURRENT ROW
                                          AND UNBOUNDED FOLLOWING )
                      FROM cc )
QUALIFY field1 <=> 'M';

SET @@sql_mode = @orig_sql_mode;

DROP TABLE cc;
