
-- This test checks that setting of optimizer_switch works correctly.
-- Test cases for bugs related to changing the setting of optimizer_switch,
-- should go here.

--echo
--echo BUG--37120 optimizer_switch allowable values not according to specification
--echo

--replace_result hypergraph_optimizer=on hypergraph_optimizer=off
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='materialization=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='semijoin=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='loosescan=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='semijoin=off,materialization=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='materialization=off,semijoin=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='semijoin=off,materialization=off,loosescan=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='semijoin=off,loosescan=off';
select @@optimizer_switch;

set optimizer_switch='default';
set optimizer_switch='materialization=off,loosescan=off';
select @@optimizer_switch;
set optimizer_switch='default';


-- test re-optimization/re-execution with different execution methods
-- prepare once, exec with different modes
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

set @@optimizer_switch="semijoin=off";
set @@optimizer_switch="semijoin=on,materialization=off";
set @@optimizer_switch="semijoin=off,materialization=on";

set optimizer_switch='default';
set @@optimizer_switch="materialization=off";
set @@optimizer_switch="semijoin=off,materialization=on";
set @@optimizer_switch="semijoin=on,materialization=off";

set optimizer_switch='default';
drop table t1, t2;

SET SESSION optimizer_switch = 'default,semijoin=off';
CREATE TABLE t1 (f1 INTEGER);
CREATE TABLE t2 LIKE t1;
CREATE PROCEDURE p1 () BEGIN SELECT f1 FROM t1 WHERE f1 IN (SELECT f1 FROM t2);
ALTER TABLE t2 CHANGE COLUMN f1 my_column INT;
DROP PROCEDURE p1;
ALTER TABLE t2 CHANGE COLUMN my_column f1 INT;

SET SESSION optimizer_switch = 'semijoin=on';
CREATE PROCEDURE p1 () BEGIN SELECT f1 FROM t1 WHERE f1 IN (SELECT f1 FROM t2);
ALTER TABLE t2 CHANGE COLUMN f1 my_column INT;
DROP PROCEDURE p1;
DROP TABLE t1, t2;
SET SESSION optimizer_switch = 'default';
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

SET SESSION optimizer_switch = 'semijoin=on';
SET SESSION optimizer_switch = 'semijoin=off';

drop table t1, t2;
drop view v1;
drop procedure p1;

set SESSION optimizer_switch='default';

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
let proc_text=
CREATE PROCEDURE run_n_times(x int)
BEGIN
DECLARE c int;
  SET x = x-1;
  SELECT COUNT(expr_key) INTO c FROM ot
  WHERE expr_key IN (SELECT expr_nokey FROM it)
    AND ot.expr_key<100000000;
END WHILE;
SET optimizer_switch="default";
SET optimizer_switch="firstmatch=off,materialization=off";
SET optimizer_switch="default";
DROP PROCEDURE run_n_times;

-- Re-create procedure to avoid caching effects
eval $proc_text;
SET optimizer_switch="firstmatch=off,materialization=off";
SET optimizer_switch="default";
DROP PROCEDURE run_n_times;

-- Re-create procedure to avoid caching effects
eval $proc_text;
SET optimizer_switch="semijoin=off,materialization=off";
SET optimizer_switch="default";
DROP PROCEDURE run_n_times;

DROP TABLE it, ot;

-- End of Bug#50489

--echo -- 
--echo -- BUG#31480: Incorrect result for nested subquery when executed via semijoin
--echo -- 

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

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d >= SOME(SELECT e FROM t3 as tc
                                  WHERE ta.b=tc.e));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d >= SOME(SELECT SUM(g) FROM t4 as tc
                                  GROUP BY f
                                  HAVING ta.a=tc.f));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d IN (SELECT g FROM t4 as tc
                                  WHERE ta.a=tc.f
                                  ORDER BY tc.f));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d >= SOME(SELECT e FROM t3 as tc
                                  WHERE tb.d=tc.e));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS t
WHERE t.a NOT IN (SELECT a FROM t1 AS ta
                  WHERE ta.a IN (SELECT c FROM t2 AS tb
                                 WHERE tb.d >= SOME(SELECT e FROM t3 as tc
                                                    WHERE t.b=tc.e)));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE EXISTS (SELECT * FROM t3 as tc
                             WHERE ta.b=tc.e));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE tb.d = (SELECT MIN(e) FROM t3 as tc
                             WHERE ta.b=tc.e));

set @@optimizer_switch='materialization=off,semijoin=on';

set @@optimizer_switch='materialization=off,semijoin=off';

let query=
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE (SELECT MIN(e) FROM t3 as tc
                      WHERE tb.d=tc.e) < SOME(SELECT e FROM t3 as tc
                                              WHERE ta.b=tc.e));

set @@optimizer_switch='materialization=off,semijoin=on';

DROP TABLE t1, t2, t3, t4;

set @@optimizer_switch='default';
