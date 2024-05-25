select pub from t1;
select priv from t1;
select * from (select pub from t1) as dt;
select /*+ merge(dt) */ * from (select priv from t1) as dt;
select /*+ no_merge(dt) */ * from (select priv from t1) as dt;
drop database mysqltest1;
