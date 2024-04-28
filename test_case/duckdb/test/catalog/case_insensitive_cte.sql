PRAGMA enable_verification;
with cte AS (SELECT 42 "A")
select a from cte;
with "CTE" AS (SELECT 42)
select * from cte;
