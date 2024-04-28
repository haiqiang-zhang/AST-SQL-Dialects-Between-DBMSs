with recursive t as (select 1 as x intersect select x+1 from t where x < 3) select * from t order by x;
with recursive t as (select 1 as x except select x+1 from t where x < 3) select * from t order by x;
WITH RECURSIVE cte AS (SELECT 42) SELECT * FROM cte;;
