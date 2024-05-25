PRAGMA enable_verification;
with cte as (select 42 AS a) (DESCRIBE TABLE cte);
(DESCRIBE TABLE cte) ORDER BY 1;
DESCRIBE select 42 AS a

query I nosort describe
with cte as (select 42 AS a) FROM (DESCRIBE TABLE cte)

query I nosort describe
with cte as (select 42 AS a) FROM (DESCRIBE TABLE cte)

query I nosort summarize
SUMMARIZE select 42 AS a

query I nosort summarize
with cte as (select 42 AS a) FROM (SUMMARIZE TABLE cte)

query I nosort summarize
with cte as (select 42 AS a) FROM (SUMMARIZE TABLE cte)

statement error
with cte as (select 42 AS a) (DESCRIBE TABLE cte);
