
if ( !$LOCKING_SERVICE ) {
  skip Locking service plugin requires the environment variable \$LOCKING_SERVICE to be set (normally done by mtr);

-- Check the service locks via UDF's which invoke the functions for the
-- locking service.
-- Some main test for this WL is the locking_service unit test.
-- The checks here are partially
-- - duplicates of checks in the unit test
-- - integration tests
--
-- Note:
-- Some sub tests check the impact of service locks on the content of
-- performance_schema tables. They are placed here and not in the suite
-- 'perfschema' because
-- 1. The UDF's are some non trivial infrastructure which we need here anyway.
-- 2. Some of the checks related to our service locks already use the content of
--    performance_schema tables for internal purposes.
-- 3. In order to avoid frequent maintenance in case the layout or the content
--    of performance_schema tables gets changed intentionally we check only
--    some minimal set of content of the corresponding performance_schema tables.
--    The omitted content is covered for other types of locks in
--    performance_schema test anyway.
--

--replace_result $LOCKING_SERVICE LOCKING_SERVICE_LIB
eval
CREATE FUNCTION service_get_read_locks  RETURNS INT SONAME "$LOCKING_SERVICE";
CREATE FUNCTION service_get_write_locks RETURNS INT SONAME "$LOCKING_SERVICE";
CREATE FUNCTION service_release_locks   RETURNS INT SONAME "$LOCKING_SERVICE";
--

-- Positive case checked later
-- SELECT service_get_read_locks('positive', 'lock1', 'lock2', 0);
SELECT service_get_read_locks();
SELECT service_get_read_locks('negative');
SELECT service_get_read_locks('negative', 'lock1');
SELECT service_get_read_locks(         1, 'lock1', 'lock2', 0);
SELECT service_get_read_locks(        '', 'lock1', 'lock2', 0);
SELECT service_get_read_locks('negative',       1, 'lock2', 0);

-- Positive case checked later
-- SELECT service_get_write_locks('positive', 'lock3', 'lock4', 0);
SELECT service_get_write_locks();
SELECT service_get_write_locks('negative');
SELECT service_get_write_locks('negative', 'lock1');
SELECT service_get_write_locks(         1, 'lock1', 'lock2', 0);
SELECT service_get_write_locks(        '', 'lock1', 'lock2', 0);
SELECT service_get_write_locks('negative',       1, 'lock2', 0);
SELECT service_get_write_locks('negative',      '', 'lock2', 0);
SELECT service_get_write_locks('negative', 'lock1',       1, 0);
SELECT service_get_write_locks('negative', 'lock1',      '', 0);
SELECT service_get_write_locks('negative', 'lock1', 'lock2', 'hello');

-- Positive case checked later
-- SELECT service_release_locks('positive');
SELECT service_release_locks();
SELECT service_release_locks('negative', 'hello');
SELECT service_release_locks(         1);
SELECT service_release_locks(        '');
UPDATE performance_schema.setup_instruments SET enabled = 'NO', timed = 'YES';

-- Enable only metadata wait event to prevent other wait events filling history
UPDATE performance_schema.setup_instruments SET enabled = 'YES'
WHERE name = 'wait/lock/metadata/sql/mdl';

SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';

SELECT service_get_read_locks('pfs_check', 'lock1', 'lock2', 0);
SELECT service_get_write_locks('pfs_check', 'lock3', 'lock4', 0);
SELECT OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, LOCK_TYPE, LOCK_DURATION,
       LOCK_STATUS
FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';

SELECT service_release_locks('pfs_check');
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';

SELECT service_get_write_locks("namespace1", "lock1", 60);
SELECT service_get_write_locks("namespace2", "lock1", "lock2", 60);
SELECT service_release_locks("namespace1");
SELECT service_release_locks("namespace2");
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.events_waits_current
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks("namespace1", "lock1", "lock2", 60);
SELECT service_get_write_locks("namespace1", "lock1", 1);
SELECT service_get_write_locks("namespace1", "lock2", 1);
SELECT service_get_read_locks("namespace1", "lock1", 1);
SELECT service_get_write_locks("namespace1", "lock1", 0);
SELECT service_get_write_locks("namespace1", "lock2", 0);
SELECT service_get_read_locks("namespace1", "lock1", 0);
SELECT OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE, OPERATION
FROM performance_schema.events_waits_history_long
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT COUNT(*) = 1 AS expect_1 FROM performance_schema.events_waits_current
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks("namespace1", "lock1", 60);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for locking service lock";
SELECT COUNT(*) = 1 AS expect_1 FROM information_schema.processlist
WHERE state = 'Waiting for locking service lock';
SELECT OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE, OPERATION
FROM performance_schema.events_waits_current
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_release_locks("namespace1");
SELECT COUNT(*) = 0 AS expect_1 FROM information_schema.processlist
WHERE state = 'Waiting for locking service lock';
SELECT COUNT(*) = 1 AS expect_1 FROM performance_schema.events_waits_current
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_release_locks("namespace1");
SELECT service_get_write_locks('holder_name_space',
                               'first', 'middle', 'last', 1);
SELECT service_get_write_locks('holder_name_space',
                               'first', 'l2_1', 'l3_1', 0);
SELECT service_get_write_locks('holder_name_space',
                               'l1_2', 'middle', 'l3_2', 0);
SELECT service_get_write_locks('holder_name_space',
                               'l1_3', 'l2_3', 'last', 0);
SELECT object_schema, object_name, lock_type, lock_status
  FROM performance_schema.metadata_locks
  WHERE OBJECT_TYPE = 'LOCKING SERVICE';

-- Release locks and cleanup
--disconnect con1
--source include/wait_until_disconnected.inc
--connection default
SELECT service_release_locks("holder_name_space");
let $holder_id= `SELECT CONNECTION_ID()`;
let $requestor_id= `SELECT CONNECTION_ID()`;
SELECT service_get_write_locks(RPAD('holder_name_space_', 64, 'a'),
                              'l1', 'l2', 'l3', 0) AS col1;
SELECT service_release_locks(RPAD('holder_name_space_', 64, 'a')) AS col1;
SELECT service_get_write_locks(RPAD('holder_name_space_', 65, 'a'),
                              'l1', 'l2', 'l3', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
       RPAD('l1_', 64, 'a'), RPAD('l2_', 64, 'a'), RPAD('l3_', 64, 'a'), 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space',
                              RPAD('l1_', 65, 'a'), 'l2_1', 'l3_1', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
                              'l1_2', RPAD('l2_', 65, 'a'), 'l3_2', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
                              'l1_3', 'l2_3', RPAD('l3_', 65, 'a'), 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
       'l1_1', 'l2_1', 'l3_1',
       'l1_2', 'l2_2', 'l3_2',
       'l1_3', 'l2_3', 'l3_3', 1) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space ', 'lock', 0) AS col1;
SELECT service_release_locks('holder_name_space ') AS col1;
SELECT service_get_write_locks(' holder_name_space', 'lock', 0) AS col1;
SELECT service_release_locks(' holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_spac', 'lock', 0) AS col1;
SELECT service_release_locks('holder_name_spac') AS col1;
SELECT service_get_write_locks('older_name_space', 'lock', 0) AS col1;
SELECT service_release_locks('older_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock ', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', ' lock', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', 'loc', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', 'ock', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
--

--echo -- 6.4.3: Variation of lock namespace in release_locks
--connection holder
SELECT service_release_locks('holder_name_space ') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_release_locks(' holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_release_locks('holder_name_spac') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_release_locks('older_name_spac') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
let $one_waits=
SELECT COUNT(*) = 1 FROM information_schema.processlist
WHERE state = 'Waiting for locking service lock' AND id = ;
let $timeout= 0;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', $timeout) AS col1;
let $timeout= -1;
SELECT service_get_write_locks('holder_name_space', 'lock', $timeout) AS col1;
let $wait_condition= $one_waits $requestor_id AND time > 1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
let $timeout= 1.0E-5;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', $timeout) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks('holder_name_space', 'l1', 'l1', 0) AS col1;
SELECT COUNT(*) = 2 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks('holder_name_space', 'l2', 0) AS col1,
       service_get_write_locks('holder_name_space', 'l2', 0);
SELECT service_get_write_locks('holder_name_space', 'l3', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'l3', 0) AS col1;
SELECT COUNT(*) = 6 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_release_locks('holder_name_space') AS col1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks('holder_name_space',
                              'first', 'middle', 'last', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
                              'first', 'l2_1', 'l3_1', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
                              'l1_2', 'middle', 'l3_2', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
                              'l1_3', 'l2_3', 'last', 0) AS col1;
SELECT service_get_write_locks('holder_name_space',
       'l1_1', 'l2_1', 'l3_1',
       'l1_2', 'l2_2', 'l3_2',
       'l1_3', 'l2_3', 'l3_3', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
--    waiting for the lock.
-- 3. "holder" and/or "default" does some operation.
-- Maybe
-- 4. "holder" or "default" polls on the processlist if "requestor" is
--    waiting for the lock.
-- 5. "holder" and/or "default" does some operation which should finally lead
--    to freeing the lock
-- 6. "requestor" reaps his result (success).
-- 7. "requestor" frees his locks.
--echo -- 6.9.1: ROLLBACK of "holder".
--connection holder
SET SESSION AUTOCOMMIT = OFF;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SET @aux = 1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
let $holder_id= `SELECT CONNECTION_ID()`;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
let $holder_id= `SELECT CONNECTION_ID()`;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
let $holder_id= `SELECT CONNECTION_ID()`;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
let $holder_id= `SELECT CONNECTION_ID()`;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_read_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_get_write_locks('holder_name_space', 'lock', 10) AS col1;
SET @aux = 1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_get_read_locks('holder_name_space', 'l1', 0) AS col1;
SELECT service_get_read_locks('holder_name_space', 'l1', 'l2', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'l1', 10) AS col1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SET @aux = 1;
let $wait_condition= $one_waits $requestor_id;
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
CREATE TEMPORARY TABLE t1 AS SELECT 1 AS col1;
CREATE TEMPORARY TABLE t1
AS SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_get_write_locks('holder_name_space', 'lock', 0) AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
DROP TEMPORARY TABLE t1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks('holder_name_space', 'l2', 0) AS col1;
SELECT COUNT(*) = 1 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_get_write_locks('holder_name_space', 'l1', 0) AS col1,
       service_get_write_locks('holder_name_space', 'l2', 0);
SELECT COUNT(*) = 2 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
CREATE TABLE t1 (col1 VARCHAR(10));
INSERT INTO t1 VALUES ('l1'), ('l2'), ('l3');
SELECT service_get_write_locks('holder_name_space', 'l2', 0);
CREATE TEMPORARY TABLE t2 ENGINE = InnoDB AS
SELECT service_get_write_locks('holder_name_space', col1, 0) AS col1 FROM t1
ORDER BY col1;
DROP TEMPORARY TABLE t2;
SELECT COUNT(*) = 2 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
SELECT service_release_locks('holder_name_space') AS col1;
{
   -- In case the UDF limitation is lifted than maybe implement and than enable.
   --echo -- 6.15.2: INSERT INTO ... SELECT ... UDF ... FROM ...
   --echo -- 6.15.3: INSERT INTO ... SELECT ... FROM ... WHERE ... UDF ...
}
--connection requestor
SELECT service_release_locks('holder_name_space') AS col1;
SELECT service_release_locks('holder_name_space') AS col1;
DROP TABLE t1;
SELECT COUNT(*) = 0 AS expect_1 FROM performance_schema.metadata_locks
WHERE OBJECT_TYPE = 'LOCKING SERVICE';
let $wait_condition=
SELECT COUNT(*) = 0 FROM information_schema.processlist
WHERE id IN ($requestor_id, $holder_id);

SELECT service_get_write_locks('holder_name_space', 'lock', 0);

SELECT service_release_locks('holder_name_space');

DROP FUNCTION service_get_read_locks;
DROP FUNCTION service_get_write_locks;
DROP FUNCTION service_release_locks;

-- Restore previous state of performance_schema instruments
UPDATE performance_schema.setup_instruments SET enabled = 'YES';
