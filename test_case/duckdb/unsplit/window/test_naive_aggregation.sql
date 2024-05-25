SET default_null_order='nulls_first';
PRAGMA enable_verification;
PRAGMA debug_window_mode=separate;
CREATE TABLE empsalary (depname varchar, empno bigint, salary int, enroll_date date);
INSERT INTO empsalary VALUES ('develop', 10, 5200, '2007-08-01'), ('sales', 1, 5000, '2006-10-01'), ('personnel', 5, 3500, '2007-12-10'), ('sales', 4, 4800, '2007-08-08'), ('personnel', 2, 3900, '2006-12-23'), ('develop', 7, 4200, '2008-01-01'), ('develop', 9, 4500, '2008-01-01'), ('sales', 3, 4800, '2007-08-01'), ('develop', 8, 6000, '2006-10-01'), ('develop', 11, 5200, '2007-08-15');
CREATE TABLE filtering AS
	SELECT
		 x
		,round(x * 0.333,0) % 3 AS y
		,round(x * 0.333,0) % 3 AS z
	FROM generate_series(0,10) tbl(x);
CREATE TABLE figure1 AS 
	SELECT * 
	FROM VALUES 
			(1, 'a'),
			(2, 'b'),
			(3, 'b'),
			(4, 'c'),
			(5, 'c'),
			(6, 'b'),
			(7, 'c'),
			(8, 'a')
		v(i, s);
SELECT depname, empno, salary, sum(salary) OVER (PARTITION BY depname ORDER BY empno) FROM empsalary ORDER BY depname, empno;
SELECT sum(salary) OVER (PARTITION BY depname ORDER BY salary) ss FROM empsalary ORDER BY depname, ss;
SELECT depname, min(salary) OVER (PARTITION BY depname ORDER BY salary, empno) m1, max(salary) OVER (PARTITION BY depname ORDER BY salary, empno) m2, AVG(salary) OVER (PARTITION BY depname ORDER BY salary, empno) m3 FROM empsalary ORDER BY depname, empno;
SELECT depname, STDDEV_POP(salary) OVER (PARTITION BY depname ORDER BY salary, empno) s FROM empsalary ORDER BY depname, empno;
SELECT depname, COVAR_POP(salary, empno) OVER (PARTITION BY depname ORDER BY salary, empno) c FROM empsalary ORDER BY depname, empno;
SELECT
	 x
	,y
	,z
	,avg(x) OVER (PARTITION BY y) AS plain_window
	,avg(x) FILTER (WHERE x = 1) OVER (PARTITION BY y) AS x_filtered_window
	,avg(x) FILTER (WHERE z = 0) OVER (PARTITION BY y) AS z_filtered_window
FROM filtering
ORDER BY y, x;
SELECT
	 x
	,y
	,z
	,count(*) OVER (PARTITION BY y) AS plain_window
	,count(*) FILTER (WHERE x = 1) OVER (PARTITION BY y) AS x_filtered_window
	,count(*) FILTER (WHERE z = 0) OVER (PARTITION BY y) AS z_filtered_window
FROM filtering
ORDER BY y, x;
SELECT
	 x
	,y
	,z
	,median(x) OVER (PARTITION BY y) AS plain_window
	,median(x) FILTER (WHERE x = 1) OVER (PARTITION BY y) AS x_filtered_window
	,median(x) FILTER (WHERE z = 0) OVER (PARTITION BY y) AS z_filtered_window
FROM filtering
ORDER BY y, x;
SELECT x, count(x) FILTER (WHERE x % 2 = 0) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING)
FROM generate_series(0,10) tbl(x);
SELECT i
	, s
	, COUNT(DISTINCT s) OVER( ORDER BY i ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS c
FROM figure1
ORDER BY i;
SELECT i
	, s
	, COUNT(DISTINCT s) OVER( ORDER BY i ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING EXCLUDE TIES) AS c
FROM figure1
ORDER BY i;