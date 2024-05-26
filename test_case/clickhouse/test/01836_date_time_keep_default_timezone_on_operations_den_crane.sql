SELECT toTypeName(now());
DROP TABLE IF EXISTS tt_null;
DROP TABLE IF EXISTS tt;
DROP TABLE IF EXISTS tt_mv;
create table tt_null(p String) engine = Null;
create table tt(p String,tmin AggregateFunction(min, DateTime)) 
engine = AggregatingMergeTree  order by p;
create materialized view tt_mv to tt as 
select p, minState(now() - interval 30 minute) as tmin
from tt_null group by p;
insert into tt_null values('x');
DROP TABLE tt_null;
DROP TABLE tt;
DROP TABLE tt_mv;
