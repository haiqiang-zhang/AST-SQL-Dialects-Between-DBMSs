PRAGMA enable_verification;
create table integers as with recursive t as (select 1 as x union all select x+1 from t where x < 3) select * from t;
