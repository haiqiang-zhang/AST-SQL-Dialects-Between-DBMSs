--                                                                      #
-- Testing of the Debug Sync Facility.                                  #
--                                                                      #
-- There is important documentation within sql/debug_sync.cc            #
--                                                                      #
-- Used objects in this test case:                                      #
-- p0 - synchronization point 0. Non-existent dummy sync point.         #
-- s1 - signal 1.                                                       #
-- s2 - signal 2.                                                       #
--                                                                      #
-- Creation:                                                            #
-- 2008-02-18 istruewing                                                #
--                                                                      #
--#######################################################################

--
-- We need the Debug Sync Facility.
--
--source include/have_debug_sync.inc

--source include/force_myisam_default.inc
--source include/have_myisam.inc

--
-- Test.
CREATE TABLE t1 (c1 INT) ENGINE=myisam;
INSERT INTO t1 VALUES (1);
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "UPDATE t1 SET c1=GET_LOCK('mysqltest_lock', 100)";

-- Retain action after use. First used by general_log.
SET DEBUG_SYNC= 'wait_for_lock SIGNAL locked EXECUTE 2';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DROP TABLE t1;
