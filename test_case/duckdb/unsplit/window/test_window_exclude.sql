PRAGMA enable_verification;
CREATE TABLE tenk1d (
        unique1	        int4,
		four		int4,
        col             int4
);
INSERT INTO tenk1d (unique1, four, col) VALUES 
  (0, 0, NULL),
  (1, 1, 1),
  (2, 2, NULL),
  (3, 3, 3),
  (4, 0, NULL),
  (5, 1, 1),
  (6, 2, NULL),
  (7, 3, 3),
  (8, 0, NULL),
  (9, 1, 1);
CREATE TABLE empsalary (
depname varchar,
empno bigint,
salary int,
enroll_date date
);
INSERT INTO empsalary VALUES
('develop', 10, 5200, '2007-08-01'),
('sales', 1, 5000, '2006-10-01'),
('personnel', 5, 3500, '2007-12-10'),
('sales', 4, 4800, '2007-08-08'),
('personnel', 2, 3900, '2006-12-23'),
('develop', 7, 4200, '2008-01-01'),
('develop', 9, 4500, '2008-01-01'),
('sales', 3, 4800, '2007-08-01'),
('develop', 8, 6000, '2006-10-01'),
('develop', 11, 5200, '2007-08-15');
SELECT sum(unique1) over (w range between unbounded preceding and current row exclude current row),
	unique1, four
FROM tenk1d  WINDOW w AS (order by four) ORDER BY four, unique1;
SELECT sum(unique1) over (w range between unbounded preceding and current row exclude group),
	unique1, four
FROM tenk1d  WINDOW w AS (order by four) ORDER BY four, unique1;
SELECT sum(unique1) over (w range between unbounded preceding and current row exclude ties),
	unique1, four
FROM tenk1d  WINDOW w AS (order by four) ORDER BY four, unique1;
SELECT sum(unique1) over (partition by four order by unique1 range between 5::int8 preceding and 6::int2 following
	exclude current row),unique1, four
FROM tenk1d  ORDER BY four, unique1;
SELECT sum(unique1) filter (where four > 1)over (order by unique1 rows between unbounded preceding and current row
	exclude current row),unique1, four
FROM tenk1d  ORDER BY unique1, four;
SELECT sum(unique1) filter (where four > 0) over (partition by four order by unique1 rows between unbounded preceding
        and current row exclude current row),unique1, four
FROM tenk1d  ORDER BY unique1, four;
SELECT first_value(four) over (order by four rows between unbounded preceding
        and current row exclude group), four
FROM tenk1d ORDER BY four;
SELECT last_value(four) over (order by four rows between current row
        and unbounded following exclude current row), four
FROM tenk1d ORDER BY four;
SELECT nth_value(four, 5) over (order by four rows between unbounded preceding
        and unbounded following exclude ties), four
FROM tenk1d ORDER BY four;
SELECT nth_value(col, 3 ignore nulls) over (order by four rows between unbounded preceding                                               
       and unbounded following exclude current row),four, col
FROM tenk1d ORDER BY four, col;
SELECT DISTINCT first_value(col IGNORE NULLS) OVER (ORDER BY i ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE CURRENT ROW)
FROM (  SELECT * 
        FROM generate_series(1,3000) AS _(i), (SELECT NULL::integer)
          UNION ALL
        SELECT 3001, 1
     ) AS _(i, col)
ORDER BY ALL NULLS FIRST;
SELECT sum(unique1) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE CURRENT ROW), unique1
FROM tenk1d ORDER BY unique1;
SELECT sum(unique1) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE GROUP), unique1
FROM tenk1d ORDER BY unique1;
SELECT sum(unique1) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE TIES), unique1
FROM tenk1d ORDER BY unique1;
SELECT DISTINCT j,sum(j) OVER (ORDER BY j ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE GROUP) FROM generate_series(1,300), generate_series(1,10) AS __(j) ORDER BY j;
SELECT i, last_value(i) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE CURRENT ROW) FROM generate_series(1,10) AS _(i)
WHERE i <> 10
ORDER BY i;
SELECT DISTINCT j,sum(j) OVER (ORDER BY j ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE TIES) FROM generate_series(1,300), generate_series(1,10) AS __(j) ORDER BY j;
SELECT DISTINCT j,sum(j) FILTER (where i <> 3) OVER (ORDER BY j ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE TIES) AS sum FROM generate_series(1,300) _(i), generate_series(1,10) AS __(j) ORDER BY j, sum;
SELECT j, sum(j) OVER (ORDER BY j ROWS BETWEEN UNBOUNDED PRECEDING AND 30 FOLLOWING EXCLUDE CURRENT ROW) FROM generate_series(1,40) AS _(j) ORDER BY j;
EXPLAIN
SELECT unique1, COUNT(*) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE CURRENT ROW) FROM tenk1d;
SELECT unique1, four, sum(unique1) OVER (PARTITION BY four ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE CURRENT ROW) FROM tenk1d ORDER BY four, unique1;
SELECT unique1, four, sum(unique1) OVER (PARTITION BY four ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE GROUP) FROM tenk1d ORDER BY four, unique1;
SELECT unique1, four, sum(unique1) OVER (PARTITION BY four ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING EXCLUDE TIES) FROM tenk1d ORDER BY four, unique1;
SELECT i, COUNT(*) OVER (ORDER BY i ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING EXCLUDE CURRENT ROW) 
FROM generate_series(1,10) AS _(i) 
ORDER BY i;
SELECT i, COUNT(*) OVER (ORDER BY i ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING EXCLUDE GROUP) 
FROM (
	SELECT * FROM generate_series(1,5) 
	UNION ALL 
	SELECT * FROM generate_series(1,5)
) AS _(i) 
ORDER BY i;
SELECT i, COUNT(*) OVER (ORDER BY i ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING EXCLUDE TIES) 
FROM (
	SELECT *  FROM generate_series(1,5) 
	UNION ALL 
	SELECT *  FROM generate_series(1,5)) 
	AS _(i) 
ORDER BY i;
SELECT i, array_agg(i) OVER w
FROM (
	SELECT * FROM generate_series(1,5)
    UNION ALL
    SELECT * FROM generate_series(1,5) 
) AS _(i)
WINDOW w AS (ORDER BY i ROWS UNBOUNDED PRECEDING EXCLUDE CURRENT ROW)
ORDER BY i;
SELECT i, array_agg(i) OVER w
FROM (
	SELECT * FROM generate_series(1,5)
    UNION ALL
    SELECT * FROM generate_series(1,5) 
) AS _(i)
WINDOW w AS (ORDER BY i ROWS UNBOUNDED PRECEDING EXCLUDE GROUP)
ORDER BY i;
SELECT i, array_agg(i) OVER w
FROM (
	SELECT * FROM generate_series(1,5)
    UNION ALL
    SELECT * FROM generate_series(1,5) 
) AS _(i)
WINDOW w AS (ORDER BY i ROWS UNBOUNDED PRECEDING EXCLUDE TIES)
ORDER BY i;
SELECT i, mode(i) OVER  w
FROM (
	SELECT * FROM generate_series(1,5)
    UNION ALL
    SELECT * FROM generate_series(1,5) 
) AS _(i)
WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING EXCLUDE CURRENT ROW)
ORDER BY i;
SELECT i, mode(i) OVER  w
FROM (
	SELECT * FROM generate_series(1,5)
    UNION ALL
    SELECT * FROM generate_series(1,5) 
) AS _(i)
WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING EXCLUDE GROUP)
ORDER BY i;
SELECT i, mode(i) OVER w 
FROM (
	SELECT * FROM generate_series(1,5)
    UNION ALL
    SELECT * FROM generate_series(1,5) 
) AS _(i)
WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING EXCLUDE TIES)
ORDER BY i;
SELECT i, median(i) OVER (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING EXCLUDE CURRENT ROW) 
FROM generate_series(1,10) AS _(i) ORDER BY i;
SELECT i, median(i) OVER (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING EXCLUDE GROUP) 
FROM generate_series(1,5) AS _(i), 
	generate_series(1,2) 
ORDER BY i;
SELECT i, median(i) OVER (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING EXCLUDE TIES) 
FROM generate_series(1,5) AS _(i), 
	generate_series(1,2) 
ORDER BY i;
WITH t1(x, y) AS (VALUES
 ( 1, 3 ),
 ( 2, 2 ),
 ( 3, 1 )
)
SELECT x, y, QUANTILE_DISC(y, 0) OVER (
	ORDER BY x 
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	EXCLUDE CURRENT ROW)
FROM t1;
WITH t1(x, y) AS (VALUES
 ( 1, 3 ),
 ( 2, 2 ),
 ( 3, 1 )
)
SELECT x, y, QUANTILE_DISC(y, 0) OVER (
	ORDER BY x 
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	EXCLUDE CURRENT ROW)
FROM t1;
select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude current row), salary, enroll_date from empsalary ORDER BY enroll_date, salary;
select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude group), salary, enroll_date from empsalary ORDER BY enroll_date, salary;
select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude ties), salary, enroll_date from empsalary ORDER BY enroll_date, salary;
select first_value(salary) over(order by salary range between 1000 preceding and 1000 following) AS first_value,
	lead(salary) over(order by salary range between 1000 preceding and 1000 following) AS lead,
	nth_value(salary, 1) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary ORDER BY first_value, lead;
select last_value(salary) over(order by salary range between 1000 preceding and 1000 following) AS last_value,
	lag(salary) over(order by salary range between 1000 preceding and 1000 following) AS lag,
	salary from empsalary ORDER BY last_value, lag;
select first_value(salary) over(order by salary range between 1000 following and 3000 following
	exclude current row) AS first_value,
	lead(salary) over(order by salary range between 1000 following and 3000 following exclude ties) AS lead,
	nth_value(salary, 1) over(order by salary range between 1000 following and 3000 following
	exclude ties),
	salary from empsalary ORDER BY first_value, lead;
select last_value(salary) over(order by salary range between 1000 following and 3000 following
	exclude group) AS last_value,
	lag(salary) over(order by salary range between 1000 following and 3000 following exclude group) AS lag,
	salary from empsalary ORDER BY last_value, lag;
