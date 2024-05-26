SELECT 1 UNION ALL SELECT * FROM range(2, 100) UNION ALL SELECT 999 LIMIT 5;
SELECT 'select count(case'a union all select 'when a='||range||' then 1' from range(100) LIMIT 5;
SELECT STRING_AGG(a, ' ') FROM (SELECT 'select count(case'a union all select 'when a='||range||' then 1' from range(2) union all select 'end) from t') tbl;
SELECT 'select count(case'a union all select 'when a='||range||' then 1' from range(2) union all select 'end) from t' LIMIT 5;
SELECT 'select count(case'a union all select 'when a='||range||' then 1' from range(100) union all select 'end) from t' LIMIT 5;
SELECT 1
UNION ALL
(
	SELECT * FROM generate_series(10, 12, 1)
	UNION ALL
	(
		SELECT * FROM generate_series(100, 103, 1)
	)
	UNION ALL
	SELECT * FROM generate_series(1000, 1002, 1)
)
UNION ALL
SELECT * FROM generate_series(10000, 10002, 1)
UNION ALL
(
	SELECT * FROM generate_series(100000, 100002, 1)
	UNION ALL
	SELECT * FROM generate_series(1000000, 1000003, 1)
);
SELECT ARRAY_AGG(1)
UNION ALL
(
	SELECT ARRAY_AGG(i) FROM generate_series(10, 12, 1) tbl(i)
	UNION ALL
	(
		SELECT ARRAY_AGG(i) FROM generate_series(100, 103, 1) tbl(i)
	)
	UNION ALL
	SELECT ARRAY_AGG(i) FROM generate_series(1000, 1002, 1) tbl(i)
)
UNION ALL
SELECT ARRAY_AGG(i) FROM generate_series(10000, 10002, 1) tbl(i)
UNION ALL
(
	SELECT ARRAY_AGG(i) FROM generate_series(100000, 100002, 1) tbl(i)
	UNION ALL
	SELECT ARRAY_AGG(i) FROM generate_series(1000000, 1000003, 1) tbl(i)
);
SELECT 1
UNION ALL
(
	SELECT * FROM generate_series(10, 12, 1)
	UNION ALL
	(
		SELECT * FROM generate_series(100, 103, 1)
	)
	UNION ALL
	SELECT * FROM generate_series(1000, 1002, 1)
)
UNION ALL
SELECT * FROM generate_series(10000, 10002, 1)
UNION ALL
(
	SELECT * FROM generate_series(100000, 100002, 1)
	UNION ALL
	SELECT * FROM generate_series(1000000, 1000003, 1)
)
LIMIT 1000;
SELECT ARRAY_AGG(1)
UNION ALL
(
	SELECT ARRAY_AGG(i) FROM generate_series(10, 12, 1) tbl(i)
	UNION ALL
	(
		SELECT ARRAY_AGG(i) FROM generate_series(100, 103, 1) tbl(i)
	)
	UNION ALL
	SELECT ARRAY_AGG(i) FROM generate_series(1000, 1002, 1) tbl(i)
)
UNION ALL
SELECT ARRAY_AGG(i) FROM generate_series(10000, 10002, 1) tbl(i)
UNION ALL
(
	SELECT ARRAY_AGG(i) FROM generate_series(100000, 100002, 1) tbl(i)
	UNION ALL
	SELECT ARRAY_AGG(i) FROM generate_series(1000000, 1000003, 1) tbl(i)
)
LIMIT 1000;
