--  

-- Thread stack overrun in debug mode on sparc
--source include/not_sparc_debug.inc

create table t1 (a int not null);

-- The query may or may not fail with an error;
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( 
  select a from t1 where a in ( select a from t1) 
  )))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))';

drop table t1;
