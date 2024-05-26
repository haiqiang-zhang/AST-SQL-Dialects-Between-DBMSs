select release_lock("lock_bug26141_sync") into @a;
select get_lock("lock_bug26141_wait", 1000) into @a;
update t1 set c=3 where c=1;
select * from t1;
select * from t2;
select * from t3;
drop table t1, t2, t3;
