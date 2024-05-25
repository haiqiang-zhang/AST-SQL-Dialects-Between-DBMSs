PRAGMA enable_verification;
create table a(i integer);
insert into a values (42);
create view va AS (with cte as (Select i as j from a) select * from cte);
create view vb AS (with cte1 as (Select i as j from a), cte2 as (select ref.j+1 as k from cte1 as ref) select * from cte2);
with cte1 as (Select i as j from a) select * from cte1;
with cte1 as (Select i as j from a) select x from cte1 t1(x);
with cte1(xxx) as (Select i as j from a) select xxx from cte1;
with cte1(xxx) as (Select i as j from a) select x from cte1 t1(x);
with cte1 as (Select i as j from a), cte2 as (select ref.j as k from cte1 as ref), cte3 as (select ref2.j+1 as i from cte1 as ref2) select * from cte2 , cte3;
with cte1 as (select i as j from a), cte2 as (select ref.j as k from cte1 as ref), cte3 as (select ref2.j+1 as i from cte1 as ref2) select * from cte2 union all select * FROM cte3;
with cte3 as (select ref2.j as i from cte1 as ref2), cte1 as (Select i as j from a), cte2 as (select ref.j+1 as k from cte1 as ref) select * from cte2 union all select * FROM cte3;
with cte1 as (Select i as j from a) select * from cte1 cte11, cte1 cte12;
with cte1 as (Select i as j from a) select * from cte1 where j = (select max(j) from cte1 as cte2);
with cte1(x, y) as (select 42 a, 84 b) select zzz, y from cte1 t1(zzz);
select * from va;
with cte AS (SELECT * FROM va) SELECT * FROM cte;
select * from vb;
SELECT 1 UNION ALL (WITH cte AS (SELECT 42) SELECT * FROM cte);
WITH RECURSIVE cte(d) AS (
		SELECT 1
	UNION ALL
		(WITH c(d) AS (SELECT * FROM cte)
			SELECT d + 1
			FROM c
			WHERE FALSE
		)
)
SELECT max(d) FROM cte;
with cte (a) as (
    select 1
)
select
    a as alias1,
    alias1 as alias2
from cte
where alias2 > 0;
