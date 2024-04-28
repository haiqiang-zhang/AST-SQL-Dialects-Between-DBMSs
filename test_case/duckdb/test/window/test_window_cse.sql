PRAGMA enable_verification;
PRAGMA explain_output = PHYSICAL_ONLY;;
SELECT SETSEED(0.867309);;
CREATE TABLE eventlog AS
	SELECT ts,
		CHR((RANDOM() * 3 + 65)::INTEGER) AS activity_name,
		(RANDOM() * 100)::INTEGER AS case_id
	FROM generate_series('2023-01-01'::TIMESTAMP, '2023-02-01'::TIMESTAMP, INTERVAL 1 HOUR) tbl(ts);;
CREATE VIEW cse AS 
WITH t AS (SELECT
    string_agg(activity_name, ',' order by ts asc, activity_name) as trace,
    1 as cnt
from
    eventlog
group by case_id
)
SELECT
    trace,
    sum(cnt) as cnt_trace,
    sum(cnt_trace) over () as cnt_total,
    sum(cnt) / sum(cnt_trace) over () as rel,
    sum(cnt_trace) over (
         order by cnt_trace desc 
         ROWS between UNBOUNDED PRECEDING and CURRENT ROW) 
      / sum(cnt_trace) over () 
      as rel
from t
group by trace
order by cnt_trace desc;
CREATE VIEW noncse AS
SELECT
    quantile(x, 0.3) over() as q3,
    quantile(x, 0.7) over() as q7
FROM generate_series(1, 10) as tbl(x);;
EXPLAIN FROM cse;;
EXPLAIN FROM cse;;
EXPLAIN FROM cse;;
EXPLAIN FROM cse;;
EXPLAIN FROM noncse;;
