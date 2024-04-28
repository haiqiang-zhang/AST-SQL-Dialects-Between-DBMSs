CREATE TABLE rides (
	id INTEGER,
	requested_date DATE,
	city VARCHAR,
	wait_time INTEGER
);;
INSERT INTO rides VALUES
	(0, '2023-01-05', 'San Francisco', 2925),
	(1, '2023-01-03', 'San Francisco', 755),
	(2, '2023-01-03', 'San Francisco', 2880),
	(3, '2023-01-05', 'San Francisco', 1502),
	(4, '2023-01-03', 'San Francisco', 2900),
	(5, '2023-01-01', 'San Francisco', 1210),
	(6, '2023-01-04', 'San Francisco', 200),
	(7, '2023-01-02', 'San Francisco', 980),
	(8, '2023-01-02', 'San Francisco', 430),
	(9, '2023-01-05', 'San Francisco', 2999),
	(10, '2023-01-01', 'San Francisco', 856),
	(11, '2023-01-02', 'San Francisco', 490),
	(12, '2023-01-02', 'San Francisco', 720),;
SELECT "id", "requested_date", "city", "wait_time", min("wait_time") OVER win_3d 
FROM rides 
WINDOW win_3d AS (
	PARTITION BY "city" 
	ORDER BY requested_date ASC 
	RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 1 DAYS PRECEDING) 
ORDER BY "requested_date", "city", "id";
