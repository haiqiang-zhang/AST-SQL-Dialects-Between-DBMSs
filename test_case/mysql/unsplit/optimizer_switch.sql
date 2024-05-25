select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
select @@optimizer_switch;
create table t1 (a1 char(8), a2 char(8));
create table t2 (b1 char(8), b2 char(8));
insert into t1 values ('1 - 00', '2 - 00');
insert into t1 values ('1 - 01', '2 - 01');
insert into t1 values ('1 - 02', '2 - 02');
insert into t2 values ('1 - 01', '2 - 01');
insert into t2 values ('1 - 01', '2 - 01');
insert into t2 values ('1 - 02', '2 - 02');
insert into t2 values ('1 - 02', '2 - 02');
insert into t2 values ('1 - 03', '2 - 03');
prepare st1 from
"select * from t1 where (a1, a2) in (select b1, min(b2) from t2 where b1 > '0' group by b1)";
prepare st1 from
"select * from t1 where (a1, a2) in (select b1, min(b2) from t2 where b1 > '0' group by b1)";
drop table t1, t2;
CREATE TABLE t1 (f1 INTEGER);
CREATE TABLE t2 LIKE t1;
ALTER TABLE t2 CHANGE COLUMN f1 my_column INT;
ALTER TABLE t2 CHANGE COLUMN my_column f1 INT;
ALTER TABLE t2 CHANGE COLUMN f1 my_column INT;
DROP TABLE t1, t2;
DROP TABLE IF EXISTS t1, t2;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;
CREATE TABLE t1 ( f1 int );
CREATE TABLE t2 ( f1 int );
insert into t2 values (5), (7);
CREATE OR REPLACE VIEW v1 AS SELECT * FROM t1 LIMIT 2;
create procedure p1() 
select COUNT(*) 
FROM v1 WHERE f1 IN 
(SELECT f1 FROM t2 WHERE f1 = ANY (SELECT f1 FROM v1));
drop table t1, t2;
drop view v1;
drop procedure p1;
CREATE TABLE it (
  id INT NOT NULL,
  expr_key INT NOT NULL,
  expr_nokey INT NOT NULL,
  expr_padder INT DEFAULT NULL,
  KEY expr_key(expr_key)
);
INSERT INTO it VALUES (135,218264606,218264606,100);
INSERT INTO it VALUES (201,810783319,810783319,200);
CREATE TABLE ot (
  id INT NOT NULL,
  expr_key INT NOT NULL,
  expr_nokey INT NOT NULL,
  KEY expr_key(expr_key)
);
DROP TABLE it, ot;
CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL);
CREATE TABLE t2 (c INT NOT NULL, d INT NOT NULL);
CREATE TABLE t3 (e INT NOT NULL);
CREATE TABLE t4 (f INT NOT NULL, g INT NOT NULL);
INSERT INTO t1 VALUES (1,10);
INSERT INTO t1 VALUES (2,10);
INSERT INTO t1 VALUES (1,20);
INSERT INTO t1 VALUES (2,20);
INSERT INTO t1 VALUES (3,20);
INSERT INTO t1 VALUES (2,30);
INSERT INTO t1 VALUES (4,40);
INSERT INTO t2 VALUES (2,10);
INSERT INTO t2 VALUES (2,20);
INSERT INTO t2 VALUES (4,10);
INSERT INTO t2 VALUES (5,10);
INSERT INTO t2 VALUES (3,20);
INSERT INTO t2 VALUES (2,40);
INSERT INTO t3 VALUES (10);
INSERT INTO t3 VALUES (30);
INSERT INTO t3 VALUES (10);
INSERT INTO t3 VALUES (20);
INSERT INTO t4 VALUES (2,10);
INSERT INTO t4 VALUES (2,10);
INSERT INTO t4 VALUES (3,10);
INSERT INTO t4 VALUES (4,10);
INSERT INTO t4 VALUES (4,20);
INSERT INTO t4 VALUES (4,20);
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d >= SOME(SELECT e FROM t3 as tc
                                  WHERE ta.b=tc.e));
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d >= SOME(SELECT SUM(g) FROM t4 as tc
                                  GROUP BY f
                                  HAVING ta.a=tc.f));
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d IN (SELECT g FROM t4 as tc
                                  WHERE ta.a=tc.f
                                  ORDER BY tc.f));
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d >= SOME(SELECT e FROM t3 as tc
                                  WHERE tb.d=tc.e));
SELECT * FROM t1 AS t
WHERE t.a NOT IN (SELECT a FROM t1 AS ta
                  WHERE ta.a IN (SELECT c FROM t2 AS tb
                                 WHERE tb.d >= SOME(SELECT e FROM t3 as tc
                                                    WHERE t.b=tc.e)));
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE EXISTS (SELECT * FROM t3 as tc
                             WHERE ta.b=tc.e));
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d = (SELECT MIN(e) FROM t3 as tc
                             WHERE ta.b=tc.e));
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE (SELECT MIN(e) FROM t3 as tc
                      WHERE tb.d=tc.e) < SOME(SELECT e FROM t3 as tc
                                              WHERE ta.b=tc.e));
DROP TABLE t1, t2, t3, t4;
