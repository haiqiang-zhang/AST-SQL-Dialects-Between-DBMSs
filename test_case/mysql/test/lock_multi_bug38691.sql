--           ``FLUSH TABLES WITH READ LOCK''
-- MySQL >= 5.0
--


-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Test to see if select will get the lock ahead of low priority update

connect (locker,localhost,root,,);
DROP TABLE IF EXISTS t1,t2,t3;

CREATE TABLE t1 (
  a int(11) unsigned default NULL,
  b varchar(255) default NULL,
  UNIQUE KEY a (a),
  KEY b (b)
);

INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3);
CREATE TABLE t2 SELECT * FROM t1;
CREATE TABLE t3 SELECT * FROM t1;
let $i = 100;
         SET a = NULL WHERE t1.b <> t2.b;
  ALTER TABLE t2 ADD COLUMN (c INT), ALGORITHM=COPY;
  ALTER TABLE t2 DROP COLUMN c, ALGORITHM=COPY;
                     SET a = NULL WHERE t1.b <> t2.b';

let $i = 100;
  ALTER TABLE t2 ADD COLUMN (c INT), ALGORITHM=COPY;
  ALTER TABLE t2 DROP COLUMN c, ALGORITHM=COPY;
let $i = 100;
  dec $i;
  ALTER TABLE t2 ADD COLUMN a int(11) unsigned default NULL, ALGORITHM=COPY;
  UPDATE t2 SET a=b;
  ALTER TABLE t2 DROP COLUMN a, ALGORITHM=COPY;
let $i = 100;
  dec $i;
  ALTER TABLE t2 ADD COLUMN a int(11) unsigned default NULL, ALGORITHM=COPY;
  UPDATE t2 SET a=b;
  ALTER TABLE t2 DROP COLUMN a, ALGORITHM=COPY;
DROP TABLE t1, t2, t3;
