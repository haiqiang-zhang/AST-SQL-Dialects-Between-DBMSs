select i from t union select 1 where false order by 1;
select i from t except select 1 where false order by 1;
