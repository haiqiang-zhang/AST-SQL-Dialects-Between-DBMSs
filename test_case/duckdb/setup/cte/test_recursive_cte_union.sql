PRAGMA enable_verification;
create table integers as with recursive t as (select 1 as x union select x+1 from t where x < 3) select * from t;
create view vr as (with recursive t(x) as (select 1 union select x+1 from t where x < 3) select * from t order by x);
