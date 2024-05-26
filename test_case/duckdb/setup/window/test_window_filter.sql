PRAGMA enable_verification;
CREATE TABLE testing AS
	SELECT
		 x
		,round(x * 0.333,0) % 3 AS y
		,round(x * 0.333,0) % 3 AS z
	FROM generate_series(0,10) tbl(x);
