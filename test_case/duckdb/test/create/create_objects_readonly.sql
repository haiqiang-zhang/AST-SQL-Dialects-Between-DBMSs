create table t1 as select 'c1' as c1;
CREATE schema s2;;
CREATE TABLE test AS SELECT * FROM range(10) t(i);;
CREATE view v1 AS SELECT * FROM range(10) t(i);;
CREATE macro add(a, b) AS a + b;;
CREATE TYPE mood AS ENUM ('happy', 'sad', 'curious');;
CREATE SEQUENCE serial START 101;;
