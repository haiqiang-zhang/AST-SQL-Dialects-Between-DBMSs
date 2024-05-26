CREATE TABLE test1(i1 int, i2 int, r1 real, r2 real, t1 text, t2 text);
INSERT INTO test1 VALUES(1,2,1.1,2.2,'hello','world');
BEGIN;
UPDATE test1 SET i1=10, i2=20;
