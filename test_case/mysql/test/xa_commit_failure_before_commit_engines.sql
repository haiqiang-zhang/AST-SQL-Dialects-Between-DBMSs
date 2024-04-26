--     RECOVER`.
--
-- ==== Implementation ====
--
-- 1. Setup scenario: create table and insert some records.
-- 2. Start and execute an XA transaction containing an insert until before
--    `XA COMMIT`.
-- 3. Crash the server during `XA COMMIT` execution before committing in the
--    storage engines.
-- 4. Restart server and check:
--    a. Error log for messages stating that recovery process found one
--       transaction needing recovery.
--    b. There is one pending XA transaction listed in the output of `XA
--       RECOVER`.
--    c. There aren't changes to the table.
-- 5. Commit the transaction.
-- 6. Check the table has changed.
--
-- ==== References ====
--
-- WL#11300: Crash-safe XA + binary log
--
-- Related tests:
--   see extra/xa_crash_safe_tests/setup.inc
--
--source include/not_valgrind.inc
--source include/have_debug.inc
--source include/have_debug_sync.inc
--let $option_name = log_bin
--let $option_value = 0
--source include/only_with_option.inc

-- 1. Setup scenario: create table and insert some records.
--
--let $xid_data = xid1
--let $xid = `SELECT CONCAT("X'", LOWER(HEX('$xid_data')), "',X'',1")`
--source extra/xa_crash_safe_tests/setup.inc

-- 2. Start and execute an XA transaction containing an insert until before
--    `XA COMMIT`.
--
--connect(con1, localhost, root,,)
--connection con1
--eval XA START $xid
INSERT INTO t1 VALUES (1);

-- 3. Crash the server during `XA COMMIT` execution before committing in the
--    storage engines.
--
--let $auxiliary_connection = default
--let $statement_connection = con1
--let $statement = XA COMMIT $xid
--let $sync_point = before_commit_in_engines
--source include/execute_to_conditional_timestamp_sync_point.inc
--source include/kill_mysqld.inc
--source extra/xa_crash_safe_tests/cleanup_connection.inc

-- 4. Restart server and check:
--
--source include/start_mysqld.inc

-- 4.a. Error log for messages stating that recovery process found one
--      transaction needing recovery.
--
--let $assert_select = Successfully prepared 1 XA transaction
--source extra/xa_crash_safe_tests/assert_recovery_message.inc

-- 4.b. There is one pending XA transaction listed in the output of `XA
--      RECOVER`.
--
--let $expected_prepared_xa_count = 1
--source extra/xa_crash_safe_tests/assert_xa_recover.inc

-- 4.c. There aren't changes to the table.
--
--let $expected_row_count = 1
--source extra/xa_crash_safe_tests/assert_row_count.inc

-- 5. Commit the transaction.
--
--eval XA COMMIT $xid

-- 6. Check the table has changed.
--
--let $expected_row_count = 2
--source extra/xa_crash_safe_tests/assert_row_count.inc

DROP TABLE t1;
