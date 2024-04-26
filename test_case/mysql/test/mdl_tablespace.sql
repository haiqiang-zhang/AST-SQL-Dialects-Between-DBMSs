SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'ALTER TABLESPACE%';
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con2
  WAIT_FOR cont_con2';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con2';

SET DEBUG_SYNC= 'now SIGNAL cont_con1';
SET DEBUG_SYNC= 'now SIGNAL cont_con2';
DROP TABLESPACE ts1;
DROP TABLESPACE ts2;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';
CREATE TABLESPACE ts2 ADD DATAFILE 'ts2_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
CREATE TABLE t2 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
CREATE TABLE t3 (pk INTEGER PRIMARY KEY) TABLESPACE ts2;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con2
  WAIT_FOR cont_con2';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con2';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con3
  WAIT_FOR cont_con3';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con3';
SET DEBUG_SYNC= 'now SIGNAL waiting_con4';
SET DEBUG_SYNC= 'now WAIT_FOR waiting_con4';
LET $wait_condition=
  SELECT COUNT(*) = 2 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE '%TABLESPACE%';

SET DEBUG_SYNC= 'now SIGNAL cont_con2';
SET DEBUG_SYNC= 'now SIGNAL cont_con3';

LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'ALTER TABLESPACE%';

SET DEBUG_SYNC= 'now SIGNAL cont_con1';

LET $wait_condition=
  SELECT COUNT(*) = 0 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'ALTER TABLESPACE%';
DROP TABLE t1;
DROP TABLE t3;
DROP TABLESPACE ts2;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd';
CREATE TABLESPACE ts2 ADD DATAFILE 'ts2.ibd';

CREATE SCHEMA s1;

CREATE TABLE s1.t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
CREATE TABLE s1.t2 (pk INTEGER PRIMARY KEY) TABLESPACE ts2;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET DEBUG_SYNC= 'now SIGNAL go_con3';
SET DEBUG_SYNC= 'now WAIT_FOR go_con3';
LET $wait_condition=
  SELECT COUNT(*) = 2 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'DROP TABLESPACE%';

SET DEBUG_SYNC= 'now SIGNAL cont_con1';

LET $wait_condition=
  SELECT COUNT(*) = 0 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'DROP TABLESPACE%';
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';
CREATE TABLESPACE ts2 ADD DATAFILE 'ts2_1.ibd';
CREATE TABLESPACE ts3 ADD DATAFILE 'ts3_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
CREATE TABLE t2 (pk INTEGER PRIMARY KEY) TABLESPACE ts2;
CREATE TABLE t3 (pk INTEGER PRIMARY KEY) TABLESPACE ts3;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table HIT_LIMIT 1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table HIT_LIMIT 1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table HIT_LIMIT 1';
DROP TABLE t1;
DROP TABLESPACE ts1;
DROP TABLE t2;
DROP TABLESPACE ts2;
DROP TABLE t3;
DROP TABLESPACE ts3;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';
CREATE TABLESPACE ts2 ADD DATAFILE 'ts2_1.ibd';
CREATE TABLESPACE ts3 ADD DATAFILE 'ts3_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
CREATE TABLE t2 (pk INTEGER PRIMARY KEY) TABLESPACE ts2;
CREATE TABLE t3 (pk INTEGER PRIMARY KEY) TABLESPACE ts3;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con2
  WAIT_FOR cont_con2';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con2';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con3
  WAIT_FOR cont_con3';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con3';
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
SET DEBUG_SYNC= 'now SIGNAL cont_con2';
SET DEBUG_SYNC= 'now SIGNAL cont_con3';
DROP TABLE t1;
DROP TABLESPACE ts1;
DROP TABLE t2;
DROP TABLESPACE ts2;
DROP TABLE t3;
DROP TABLESPACE ts3;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
DROP TABLE t1;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
INSERT INTO t1 (pk) VALUES (1);
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SELECT * FROM t1 FOR UPDATE;
SET DEBUG_SYNC= 'now SIGNAL done_con2';
SET DEBUG_SYNC= 'now WAIT_FOR done_con2';
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
DROP TABLE t1;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table HIT_LIMIT 1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
DROP TABLE t1;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1 NO_CLEAR_EVENT';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1 NO_CLEAR_EVENT';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'DROP TABLESPACE%';

SET DEBUG_SYNC= 'now SIGNAL cont_con1';
LET $wait_condition=
  SELECT COUNT(*) = 0 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'DROP TABLESPACE%';
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
SET CHARACTER SET utf8mb3;
CREATE TABLESPACE `` ADD DATAFILE 'x.ibd';
--                 0        1         2         3         4         5         6   6
--                 1........0.........0.........0.........0.........0.........0...4
CREATE TABLESPACE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ADD DATAFILE 'x.ibd';
DROP TABLESPACE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
--                 0        1         2         3         4         5         6    6
--                 1........0.........0.........0.........0.........0.........0....5
CREATE TABLESPACE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ADD DATAFILE 'x.ibd';
--                  0        1         2         3         4         5         6   6
--                  1........0.........0.........0.........0.........0.........0...4
CREATE TABLESPACE `¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥` ADD DATAFILE 'x.ibd';
DROP TABLESPACE `¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥`;
--                  0        1         2         3         4         5         6    6
--                  1........0.........0.........0.........0.........0.........0....5
CREATE TABLESPACE `¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥` ADD DATAFILE 'x.ibd';
--                  0        1         2         3         4         5         6   6
--                  1........0.........0.........0.........0.........0.........0...4
CREATE TABLESPACE `€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€` ADD DATAFILE 'x.ibd';
DROP TABLESPACE `€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€`;
--                  0        1         2         3         4         5         6    6
--                  1........0.........0.........0.........0.........0.........0....5
CREATE TABLESPACE `€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€` ADD DATAFILE 'x.ibd';
CREATE TABLESPACE `a𐍈` ADD DATAFILE 'x.ibd';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
ALTER TABLESPACE ts1 ADD DATAFILE 'ts1_2.ibd';
ALTER TABLESPACE ts1 ADD DATAFILE 'ts1_2.ibd';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET @start_session_value= @@session.lock_wait_timeout;
SET @@session.lock_wait_timeout= 1;
DROP TABLE t1;
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
SET @@session.lock_wait_timeout= @start_session_value;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';

CREATE TABLE t1_src (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
CREATE TABLE t2_src (pk INTEGER PRIMARY KEY);

CREATE TABLE t1_new LIKE t1_src;
DROP TABLE t1_new;

CREATE TABLE t2_new LIKE t2_src;
DROP TABLE t2_new;
DROP TABLE t1_src;
DROP TABLE t2_src;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1_1.ibd';
CREATE TABLE t1 (pk INTEGER PRIMARY KEY) TABLESPACE ts1;
ALTER TABLE t1 TABLESPACE ``;
ALTER TABLE t1 TABLESPACE `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`;
CREATE TABLE t2 (pk INTEGER PRIMARY KEY) TABLESPACE ``;
CREATE TABLE t2 (pk INTEGER PRIMARY KEY) TABLESPACE `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`;
DROP TABLE t1;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'ALTER TABLESPACE%';

LET $wait_condition=
  SELECT COUNT(*) = 2 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE';

SELECT object_type, object_name, lock_type, lock_duration, lock_status
  FROM performance_schema.metadata_locks
  WHERE object_type LIKE 'TABLESPACE'
  ORDER BY lock_status;

LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.events_waits_current
    WHERE object_type LIKE 'TABLESPACE';

SELECT event_name, object_name, object_type, operation
  FROM performance_schema.events_waits_current
  WHERE object_type LIKE 'TABLESPACE';

-- Disable all waits except wait/lock/metadata/sql/mdl and empty the table
-- so that the table doesn't get full and the event that we need to wait on
-- doesn't get removed from the table.
--replace_regex /[0-9]+/X/
CALL sys.ps_setup_disable_instrument('wait');

SET DEBUG_SYNC= 'now SIGNAL cont_con1';

LET $wait_condition=
  SELECT COUNT(*) = 0 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for tablespace metadata lock' AND
          info LIKE 'ALTER TABLESPACE%';

LET $wait_condition=
  SELECT COUNT(*) = 0 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE';

LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.events_waits_history_long
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';

SELECT event_name, object_name, object_type, operation
  FROM performance_schema.events_waits_current
  WHERE object_type LIKE 'TABLESPACE';

SELECT event_name, object_name, object_type, operation
  FROM performance_schema.events_waits_history_long
  WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd';

CREATE TABLE t1 (
  a INT NOT NULL,
  PRIMARY KEY (a)
)
ENGINE=InnoDB
TABLESPACE ts1;
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock
  WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';
SET DEBUG_SYNC= 'now SIGNAL cont';

SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock
  WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';
SET DEBUG_SYNC= 'now SIGNAL cont';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock
  WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';
SET DEBUG_SYNC= 'now SIGNAL cont';

SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock
  WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';
SET DEBUG_SYNC= 'now SIGNAL cont';

SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock
  WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts1';
SET DEBUG_SYNC= 'now SIGNAL cont';

-- TODO : Enable following once shared tablespace are allowed in Partitioned
--        Table (wl#12034).
----echo #############################################
----echo # Case6: Checking ALTER TABLE ... PARTITION
--
--CREATE TABLESPACE ts2 ADD DATAFILE 'ts2.ibd';
--  SIGNAL got_lock
--  WAIT_FOR cont';
--  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
--    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts2';

SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock
  WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.metadata_locks
    WHERE object_type LIKE 'TABLESPACE' AND object_name LIKE 'ts2';
SET DEBUG_SYNC= 'now SIGNAL cont';


-- TODO : Enable following once shared tablespace are allowed in Partitioned
--        Table (wl#12034).
----echo #############################################
----echo # Case8 - A tablespace name 65 3-byte characters should
----echo # be rejected, when specified for table partition.
--
----error ER_TOO_LONG_IDENT
--CREATE TABLE t5 (
--  a INT NOT NULL,
--  PRIMARY KEY (a)
--)
--ENGINE=InnoDB
--PARTITION BY RANGE (a)
--PARTITIONS 1
--(PARTITION P1 VALUES LESS THAN (2) TABLESPACE
--  `€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€`);
--  partition p2 values less than (4) tablespace
--  `€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€`);
SET DEBUG_SYNC= 'RESET';
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLESPACE ts1;

CREATE TABLESPACE ts1 ADD DATAFILE 'df1.ibd';
ALTER TABLESPACE ts1 RENAME TO ts2;
ALTER TABLESPACE ts2 RENAME TO ts1;

SET SESSION debug="+d,tspr_post_se";
ALTER TABLESPACE ts1 RENAME TO ts2;

SET SESSION debug="-d,tspr_post_se";
ALTER TABLESPACE ts1 RENAME TO ts2;

SET SESSION debug="+d,tspr_post_update";
ALTER TABLESPACE ts2 RENAME TO ts3;

SET SESSION debug="-d,tspr_post_update";
ALTER TABLESPACE ts2 RENAME TO ts3;

SET SESSION debug="+d,tspr_post_intcmt";
ALTER TABLESPACE ts3 RENAME TO ts4;

SET SESSION debug="-d,tspr_post_intcmt";
ALTER TABLESPACE ts3 RENAME TO ts4;

DROP TABLESPACE ts4;

CREATE TABLESPACE ts1 ADD DATAFILE 'df1.ibd';
SET @@session.lock_wait_timeout= 1;
ALTER TABLESPACE ts1 RENAME TO ts2;

CREATE TABLE t1(i INT) TABLESPACE ts1;
SET @@session.lock_wait_timeout= 1;
ALTER TABLESPACE ts1 RENAME TO ts2;

DROP TABLE t1;
DROP TABLESPACE ts1;

CREATE TABLESPACE ts1 ADD DATAFILE 'df1.ibd';
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET @@session.lock_wait_timeout= 1;
DROP TABLESPACE ts1;
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
DROP TABLESPACE ts2;

CREATE TABLESPACE ts1 ADD DATAFILE 'df1.ibd';
CREATE TABLE t1(i INT) TABLESPACE ts1;
SET DEBUG_SYNC= 'after_wait_locked_tablespace_name_for_table
  SIGNAL got_lock_con1
  WAIT_FOR cont_con1';
SET DEBUG_SYNC= 'now WAIT_FOR got_lock_con1';
SET @@session.lock_wait_timeout= 1;
ALTER TABLESPACE ts1 RENAME TO t1;
SET DEBUG_SYNC= 'now SIGNAL cont_con1';
DROP TABLE t2;
DROP TABLESPACE ts1;
SET @@session.lock_wait_timeout= DEFAULT;

CREATE TABLESPACE s1 ADD DATAFILE 's1.ibd';

CREATE TABLE t1 (pk INTEGER PRIMARY KEY);
ALTER TABLE t1 TABLESPACE s1;
DROP TABLE t1;
DROP TABLESPACE s1;

CREATE TABLE test1(a INT NOT NULL, b CHAR(2) NOT NULL, PRIMARY KEY(a, b))
ENGINE=INNODB;

CREATE TABLE test2(a INT NOT NULL, b CHAR(2) NOT NULL, PRIMARY KEY(a, b))
ENGINE=INNODB;
SELECT OBJECT_TYPE, OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
      OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;

ALTER TABLE test1 RENAME test1_tmp;
SELECT OBJECT_TYPE, OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
      OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;
ALTER TABLE test2 RENAME test1;
SELECT OBJECT_TYPE, OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
      OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;
SELECT OBJECT_TYPE, OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;

DROP TABLE test1_tmp;
DROP TABLE test1;
CREATE TABLE part1(a INT) PARTITION BY HASH (a) PARTITIONS 10;
CREATE TABLE part2(a INT) PARTITION BY HASH (a) PARTITIONS 10;
SELECT OBJECT_TYPE, REPLACE(OBJECT_NAME, '--p#', '#P#'), LOCK_TYPE,
LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;

ALTER TABLE part1 RENAME TO part1_tmp;
SELECT OBJECT_TYPE, REPLACE(OBJECT_NAME, '--p#', '#P#'), LOCK_TYPE,
LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;
ALTER TABLE part2 RENAME TO part1;
SELECT OBJECT_TYPE, REPLACE(OBJECT_NAME, '--p#', '#P#'), LOCK_TYPE,
LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;
SELECT OBJECT_TYPE, OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'table' AND OBJECT_SCHEMA = 'test' OR
OBJECT_TYPE = 'tablespace'
ORDER BY OBJECT_NAME;

DROP TABLE part1_tmp;
DROP TABLE part1;
