drop table if exists t1,t2;
CREATE TABLE t1 (a int, t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE t2 (a int, t datetime);
insert into t1 values(2,"2002-03-03");
insert into t1 (a) values(4);
insert into t1 select * from t2;
insert into t1 (a) select a+1 from t2 where a=8;
