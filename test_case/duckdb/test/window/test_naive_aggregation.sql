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
