PRAGMA enable_verification;
create table integers as with recursive t as (select 1 as x union all select x+1 from t where x < 3) select * from t;;
with recursive t as (select 1 as x union all select x+1 from t where x < 3 order by x) select * from t;
with recursive t as (select 1 as x union all select x+1 from t where x < 3 LIMIT 1) select * from t;
with recursive t as (select 1 as x union all select x+1 from t where x < 3 OFFSET 1) select * from t;
with recursive t as (select 1 as x union all select x+1 from t where x < 3 LIMIT 1 OFFSET 1) select * from t;
with recursive t as (select 1 as x union all select x+1 from t where x < 3) select * from t;
with recursive t as (select 1 as x union all select x+1 from t as m where m.x < 3) select * from t;
with recursive t as (select 1 as x union all select m.x+f.x from t as m, t as f where m.x < 3) select * from t;
with recursive t as (select 1 as x, 'hello' as y union all select x+1, y || '-' || 'hello' from t where x < 3) select * from t;;
with recursive t as (select 1 as x union all select x+1 from t where x < 3) select min(a1.x) from t a1, t a2;;
with recursive t as (select 1 as x union all select x+(SELECT 1) from t where x < 3) select * from t;;
with recursive t as (select (select min(x) from integers) as x union all select x+1 from t where x < 3) select * from t;;
with recursive t as (select 1 as x union all select sum(x+1) AS x from t where x < 3 group by x) select * from t;
with recursive t as (select 1 as x union all select sum(x+1) AS x from t where x < 3)
select * from (select * from t limit 10) t1(x) order by x nulls last;
WITH RECURSIVE t AS (
	SELECT 1 AS i
	UNION ALL
	SELECT j
	FROM t, generate_series(0, 10, 1) series(j)
	WHERE j=i+1
)
SELECT * FROM t;;
