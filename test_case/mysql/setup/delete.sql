drop table if exists t1,t2,t3,t11,t12;
CREATE TABLE t1 (a tinyint(3), b tinyint(5));
INSERT INTO t1 VALUES (1,1);
INSERT LOW_PRIORITY INTO t1 VALUES (1,2);
INSERT INTO t1 VALUES (1,3);
DELETE from t1 where a=1 limit 1;
DELETE LOW_PRIORITY from t1 where a=1;
INSERT INTO t1 VALUES (1,1);
DELETE from t1;
