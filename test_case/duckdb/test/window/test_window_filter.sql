SELECT
	 x
	,y
	,z
	,avg(x) OVER (PARTITION BY y) AS plain_window
	,avg(x) FILTER (WHERE x = 1) OVER (PARTITION BY y) AS x_filtered_window
	,avg(x) FILTER (WHERE z = 0) OVER (PARTITION BY y) AS z_filtered_window
FROM testing
ORDER BY y, x;
SELECT
	 x
	,y
	,z
	,count(*) OVER (PARTITION BY y) AS plain_window
	,count(*) FILTER (WHERE x = 1) OVER (PARTITION BY y) AS x_filtered_window
	,count(*) FILTER (WHERE z = 0) OVER (PARTITION BY y) AS z_filtered_window
FROM testing
ORDER BY y, x;
SELECT
	 x
	,y
	,z
	,median(x) OVER (PARTITION BY y) AS plain_window
	,median(x) FILTER (WHERE x = 1) OVER (PARTITION BY y) AS x_filtered_window
	,median(x) FILTER (WHERE z = 0) OVER (PARTITION BY y) AS z_filtered_window
FROM testing
ORDER BY y, x;
SELECT x, count(x) FILTER (WHERE x % 2 = 0) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING)
FROM generate_series(0,10) tbl(x);
