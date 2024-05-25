select var_samp(1), exists(select 1 from t1 lock in share mode) 
      from t1 into @a,@b;
select var_samp(1), exists(select 1 from t1 for update)
      from t1 into @a,@b;
drop table t1,t2;
