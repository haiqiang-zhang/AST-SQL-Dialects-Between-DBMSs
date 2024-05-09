create table t1 (i int) engine=myisam max_rows=100000000000;
alter table t1 max_rows=100;
alter table t1 max_rows=100000000000;
drop table t1;
CREATE TABLE t3(c1 DATETIME NOT NULL) ENGINE=MYISAM;
ALTER TABLE t3 ADD INDEX(c1);
DROP TABLE t3;
