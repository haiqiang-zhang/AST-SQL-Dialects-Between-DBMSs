select * from t1;
prepare st_raise_base from 'update t1 set salary = salary * ( 1 + ? ) where r - l = 1';
prepare st_raise_mgr  from 'update t1 set salary = salary + ? where r - l > 1';
select * from t1;
prepare st_round from 'update t1 set salary = salary + ? - ( salary MOD ? )';
select * from t1;
drop table t1;
