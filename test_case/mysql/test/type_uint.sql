insert ignore into t1 values (-1);
insert ignore into t1 values ('5000000000');
select * from t1;
drop table t1;
