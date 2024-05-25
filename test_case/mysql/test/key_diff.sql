select * from t1,t1 as t2;
select t1.*,t2.* from t1,t1 as t2 where t1.A=t2.B order by binary t1.a,t2.a;
select * from t1 where a='a';
drop table t1;
