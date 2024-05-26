PRAGMA enable_verification;
create table a(i integer);
insert into a values (42);
create view va AS (with cte as (Select i as j from a) select * from cte);
create view vb AS (with cte1 as (Select i as j from a), cte2 as (select ref.j+1 as k from cte1 as ref) select * from cte2);
