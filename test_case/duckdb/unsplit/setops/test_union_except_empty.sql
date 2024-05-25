PRAGMA enable_verification;
create table t (i int);
insert into t values (1),(2),(3),(4),(4);
select i from t union select 1 where false order by 1;
select i from t except select 1 where false order by 1;
