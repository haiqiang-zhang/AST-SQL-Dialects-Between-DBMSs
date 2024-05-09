drop table if exists t1;
create table t1  (
  id     INTEGER AUTO_INCREMENT PRIMARY KEY,
  emp    CHAR(10) NOT NULL,
  salary DECIMAL(6,2) NOT NULL,
  l INTEGER NOT NULL,
  r INTEGER NOT NULL);
prepare st_ins from 'insert into t1 set emp = ?, salary = ?, l = ?, r = ?';
select * from t1;
prepare st_raise_base from 'update t1 set salary = salary * ( 1 + ? ) where r - l = 1';
prepare st_raise_mgr  from 'update t1 set salary = salary + ? where r - l > 1';
select * from t1;
prepare st_round from 'update t1 set salary = salary + ? - ( salary MOD ? )';
select * from t1;
drop table t1;
