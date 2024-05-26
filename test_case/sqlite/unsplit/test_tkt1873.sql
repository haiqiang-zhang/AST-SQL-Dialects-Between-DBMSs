CREATE TABLE t1(x, y);
ATTACH 'test2.db' AS aux;
INSERT INTO t1 VALUES(1, 2);
INSERT INTO t1 VALUES(3, 4);
INSERT INTO t2 VALUES(5, 6);
INSERT INTO t2 VALUES(7, 8);
select * from t2;
select * from t2;
