CREATE TABLE t1(id int, value text);
CREATE TABLE t2(ctx int, id int, value text);
INSERT INTO t1 VALUES(1,'try');
INSERT INTO t2 VALUES(1,1,'good');
INSERT INTO t2 VALUES(2,2,'evil');
select * from t2 left join t1 on t1.id=t2.ctx where t1.value is null;
