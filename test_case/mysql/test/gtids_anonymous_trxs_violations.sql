
--
-- BUG#20748502: ASSERTION `THD->VARIABLES.GTID_NEXT.TYPE== ANONYMOUS_GROUP' FAILED.
--
-- This test case verifies that the server does not
-- assert. The steps to reproduce the assert are:
--
--  1. set autocommit to zero
--  2. create a temporary table - this would raise the
--     GTID-violation flag
--  3. Set GTID_NEXT explicitly
--  4. Issue a statement and commit the current
--     transaction - since GTID_NEXT and GTID-violation are
--     set then the system will try to decrease the number
--     of GTID-violation transactions.
--

SET @@GLOBAL.GTID_MODE=OFF_PERMISSIVE;

CREATE TABLE t2 (c1 INT);
set @@autocommit=0;
CREATE TEMPORARY TABLE t1(a INT key);
SET SESSION GTID_NEXT='AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE:1';
INSERT INTO t2 VALUES(1);
SET SESSION GTID_NEXT=AUTOMATIC;
DROP TABLE t2;
SET GLOBAL GTID_MODE=OFF;

--
-- Bug #20743468:  ASSERTION `OLD_VALUE >= 1' FAILED. | ABORT (SIG=6) IN GTID_STATE::END_ANONYMOUS_
--
-- This test case verifies that the server does not
-- assert. The steps to reproduce the assert are:
--
--  1. set autocommit to zero
--  2. Issue CREATE TABLE ... SELECT - this would raise the
--     GTID-violation flag (when it should not if the binlog
--     is disabled).
--  3. Issue a BINLOG statement - this implicitly sets GTID_NEXT
--     to ANONYMOUS.
--  4. Issue a DDL - since GTID_NEXT and GTID-violation are set
--     then the system will try to decrease the number of
--     GTID-violation transactions.

-- needs a valid server id (>=1)
--replace_result $new_server_id NEW_SERVER_ID
--eval SET GLOBAL server_id= $new_server_id

USE test;
CREATE TABLE t1 SELECT 1 a;
DROP FUNCTION IF EXISTS inexistent_function;
DROP TABLE t1;

--
-- One needs to set GTID_NEXT to DEFAULT after the
-- BINLOG '<fd event>', since it implicitly sets
-- GTID_NEXT to ANONYMOUS (by design).
--
SET SESSION GTID_NEXT=DEFAULT;
SET GLOBAL GTID_MODE=OFF;
