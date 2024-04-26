--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (locker,localhost,root,,);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1( a INT, b INT );
INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3), (4, 4);
let $i = 100;
  ALTER TABLE t1 ADD COLUMN (c INT);
  ALTER TABLE t1 DROP COLUMN c;

let $i = 100;
  ALTER TABLE t1 ADD COLUMN (c INT);
  ALTER TABLE t1 DROP COLUMN c;
let $i = 100;
  dec $i;
  ALTER TABLE t1 ADD COLUMN a int(11) unsigned default NULL;
  UPDATE t1 SET a=b;
  ALTER TABLE t1 DROP COLUMN a;
let $i = 100;
  dec $i;
  ALTER TABLE t1 ADD COLUMN a INT;
  UPDATE t1 SET a=b;
  ALTER TABLE t1 DROP COLUMN a;
ALTER TABLE t1 ADD COLUMN a INT;
let $i = 100;
  ALTER TABLE t1 ADD COLUMN (c INT);
  ALTER TABLE t1 DROP COLUMN c;

let $i = 100;
  ALTER TABLE t1 ADD COLUMN (c INT);
  ALTER TABLE t1 DROP COLUMN c;
let $i = 100;
  dec $i;
  ALTER TABLE t1 ADD COLUMN a int(11) unsigned default NULL;
  UPDATE t1 SET a=b;
  ALTER TABLE t1 DROP COLUMN a;
let $i = 100;
  dec $i;
  ALTER TABLE t1 ADD COLUMN a INT;
  UPDATE t1 SET a=b;
  ALTER TABLE t1 DROP COLUMN a;
DROP TABLE t1;
