select * from t1 left outer join t2 on t1.a=t2.x where t2.z='ok';
select * from t1 left outer join t2 on t1.a=t2.x and t2.z='ok';
create index i2 on t2(z);
select * from t1 left outer join t2 on t1.a=t2.x where t2.z='ok';
select * from t1 left outer join t2 on t1.a=t2.x and t2.z='ok';
select * from t1 left outer join t2 on t1.a=t2.x where t2.z>='ok';
select * from t1 left outer join t2 on t1.a=t2.x and t2.z>='ok';
select * from t1 left outer join t2 on t1.a=t2.x where t2.z IN ('ok');
select * from t1 left outer join t2 on t1.a=t2.x and t2.z IN ('ok');
