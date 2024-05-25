CREATE VIEW v1 (a) AS SELECT f1 IN (SELECT f1 FROM t1) FROM t1;
SELECT * FROM v1;
drop view v1;
drop table t1;
