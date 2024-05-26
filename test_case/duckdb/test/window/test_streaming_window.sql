PREPARE sw1 AS
	SELECT i, row_number() OVER() AS row_no
	FROM range(10, 20) tbl(i)
	QUALIFY row_no <= ?::BIGINT;
explain select first_value(i IGNORE NULLS) over () from integers;
EXPLAIN
SELECT i, COUNT(*) OVER() FROM integers;
EXPLAIN
SELECT i, SUM(i) OVER() FROM integers;
EXPLAIN
SELECT j, COUNT(j) FILTER(WHERE i = 2) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
EXPLAIN
SELECT j, SUM(j) FILTER(WHERE i = 2) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
explain select row_number() over (), i, j from integers;
select row_number() over (), i, j from integers;
explain select rank() over (), i, j from integers;
select rank() over (), i, j from integers;
explain select dense_rank() over (), i, j from integers;
select dense_rank() over (), i, j from integers;
explain select percent_rank() over (), i, j from integers;
select percent_rank() over (), i, j from integers;
EXPLAIN
SELECT i, COUNT(*) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
SELECT i, COUNT(*) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
EXPLAIN
SELECT j, COUNT(j) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
SELECT j, COUNT(j) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
EXPLAIN
SELECT i, SUM(i) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
EXPLAIN
SELECT i, SUM(i) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
SELECT i, SUM(i) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM integers;
EXPLAIN
SELECT SUM(s) FROM (
	SELECT SUM(i) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) s
	FROM range(5000) tbl(i)
);
SELECT SUM(s) FROM (
	SELECT SUM(i) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) s
	FROM range(5000) tbl(i)
);
explain select i, j, first_value(i) over (), first_value(j) over () from integers;
select i, j, first_value(i) over (), first_value(j) over () from integers;
select row_number() over (), first_value(i) over (), first_value(j) over () from integers;
select row_number() over (), row_number() over () from integers;
explain select first_value(i IGNORE NULLS) over () from integers;
explain select first_value(i) over (), last_value(i) over () from integers;
explain select last_value(i) over (), first_value(i) over () from integers;
explain select first_value(i) over (), last_value(i) over (order by j) from integers;
explain select last_value(i) over (order by j), first_value(i) over () from integers;
SELECT id AS sparse_id, row_number() OVER () AS rnum
FROM vertices_view;
WITH RECURSIVE rte AS (
	SELECT 1 l, 1::BIGINT r
	UNION  ALL
	SELECT l+1, row_number() OVER()
	FROM rte
	WHERE l < 3
)
SELECT * FROM rte;
EXECUTE sw1(10);
EXECUTE sw1(2);
