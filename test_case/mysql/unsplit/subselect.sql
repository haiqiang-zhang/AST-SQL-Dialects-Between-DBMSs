create table t1(a int,b int,key(a),key(b));
insert into t1(a,b) values (1,2),(2,1),(2,3),(3,4),(5,4),(5,5),
  (6,7),(7,4),(5,3);
drop table t1;
CREATE TABLE t1 (f1 INT NOT NULL);
CREATE VIEW v1 (a) AS SELECT f1 IN (SELECT f1 FROM t1) FROM t1;
SELECT * FROM v1;
drop view v1;
drop table t1;
