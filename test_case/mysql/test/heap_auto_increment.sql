select * from t1;
delete from t1 where a=6;
ALTER TABLE t1 add c int;
insert into t1 values (NULL,7,7);
update t1 set a=8,b=b+1,c=c+1 where a=7;
insert into t1 values (NULL,9,9);
select * from t1;
drop table t1;
create table t1 (
  skey tinyint unsigned NOT NULL auto_increment PRIMARY KEY,
  sval char(20)
) engine=heap;
insert into t1 values (NULL, "hello");
insert into t1 values (NULL, "hey");
select * from t1;
select _rowid,t1._rowid,skey,sval from t1;
drop table t1;
