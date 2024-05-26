pragma enable_verification;
create table t as with q(id,s) as (values(1,42)),
a(s)as materialized(select 42)
select id from q join a on q.s=a.s;
