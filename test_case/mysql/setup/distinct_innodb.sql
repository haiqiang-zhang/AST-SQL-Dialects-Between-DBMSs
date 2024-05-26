CREATE TABLE t1 (
  col_int_key int(11) NOT NULL,
  col_time_key time NOT NULL,
  col_datetime_key datetime NOT NULL,
  KEY col_int_key (col_int_key),
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (7,'06:17:39','2003-08-21 00:00:00');
DROP TABLE t1;
create table t1(a int, b int, c int) engine=InnoDB;
create table t2(a int, b int, c int) engine=InnoDB;
insert into t2 values();
create view v1 as select t1.* from t1 left join t2 on 1;
drop view v1;
create view v1 as select t1.a*2 as a, t1.b*2 as b, t1.c*2 as c from t1;
drop view v1;
