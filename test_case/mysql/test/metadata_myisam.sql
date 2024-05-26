select * from v1 group by id limit 1;
select * from v1 group by id limit 0;
select * from v1 where id=1000 group by id;
select * from v1 where id=1 group by id;
select * from v2 where renamed=1 group by renamed;
select * from v3 where renamed=1 group by renamed;
drop table t1;
drop view v1,v2,v3;
