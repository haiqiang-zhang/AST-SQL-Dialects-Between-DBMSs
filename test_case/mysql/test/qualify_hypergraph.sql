CREATE VIEW v1 as
SELECT salesperson_id,   SUM(sale_amount) AS total_sales,
RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS sales_rank
FROM sales GROUP BY salesperson_id
QUALIFY SUM(sale_amount) > 3000;
CREATE VIEW v2 as
SELECT SUM(sale_amount) AS total_sales,
RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS sales_rank
FROM sales GROUP BY salesperson_id
QUALIFY SUM(sale_amount) > 3000;
DROP VIEW v1, v2;
DROP TABLE sales;
CREATE TABLE t1 (pk INT);
CREATE TABLE t2 (pk INT, col_decimal_10_8 DECIMAL(10,8));
DROP TABLE t1, t2;
CREATE TABLE t1 (col_varchar137 VARCHAR(137), col_float FLOAT);
CREATE TABLE t2 (pk INT);
DROP TABLE t1, t2;
CREATE TABLE t1 (pk INT, col_float_key FLOAT );
CREATE TABLE t2 (col_varchar132 VARCHAR(132), col_timestamp_key TIMESTAMP);
DROP TABLE t1, t2;
CREATE TABLE cc (col_time TIME, col_year YEAR, col_double_key DOUBLE,
                 col_char_255 CHAR(255));
DROP TABLE cc;
