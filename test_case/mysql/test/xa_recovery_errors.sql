--     outputted to the server log.
-- R2. Server will abort if any pending transaction fails to finish in the
--     SE.
--
-- ==== Implementation ====
--
-- For each of the possible errors(1) returned by the SE and for each of the
-- possible actions(2) performed by the SE:
-- 1. Start the transaction and insert some record.
-- 2. Setup a conditional sync point for timestamp for the statement
--    associated with the one of the possible SE actions(2) and execute up
--    until that sync point.
-- 3. Kill the server.
-- 4. Restart server passing debug symbols that will simulate SEs returning
--    a given error(1) and expect crash during start.
-- 5. Find in the server log the error message corresponding to the
--    simulated error(1).
-- 6. Restart the server without the debug symbols.
--
-- (1) List of possible errors returned by the SE:
-- - XAER_ASYNC
-- - XAER_RMERR
-- - XAER_NOTA
-- - XAER_INVAL
-- - XAER_PROTO
-- - XAER_RMFAIL
-- - XAER_DUPID
-- - XAER_OUTSIDE
--
-- (2) List of possible SE actions during recovery:
-- - Prepare an XA transaction
-- - Commit an XA transaction
-- - Rollback an XA transaction
-- - Commit an XA transaction with one-phase
--
-- ==== References ====
--
-- WL#11300: Crash-safe XA + binary log
--
-- Related tests;
--   see extra/xa_crash_safe_tests/setup.inc
--
--source include/not_valgrind.inc
--source include/have_debug.inc
--source include/have_debug_sync.inc
--source include/big_test.inc
--let $option_name = log_bin
--let $option_value = 0
--source include/only_with_option.inc

let $messages = .*Crash recovery finished in InnoDB engine. Failed to.*
.*Crash recovery failed. Either correct the problem*
.*Can.t init tc log.*
.*Aborting.*;

let $xa_errors = [
  "XAER_ASYNC",
  "XAER_RMERR",
  "XAER_NOTA",
  "XAER_INVAL",
  "XAER_PROTO",
  "XAER_RMFAIL",
  "XAER_DUPID",
  "XAER_OUTSIDE"
];

-- Include $error_on_recovery_for_xa_transaction procedures
--source extra/xa_crash_safe_tests/utility_functions.inc

--let $nth_iteration = 3

-- Prepare an XA transaction
--let $action = prepare
--let $expected_recovery = rollback
--let $sync_point = before_set_prepared_in_tc
--source $error_on_recovery_for_xa_transaction

-- Commit an XA transaction
--let $action = commit
--let $expected_recovery = prepare
--let $sync_point = before_commit_in_engines
--source $error_on_recovery_for_xa_transaction

-- Rollback an XA transaction
--let $action = rollback
--let $expected_recovery = prepare
--let $sync_point = before_rollback_in_engines
--source $error_on_recovery_for_xa_transaction

-- Commit an XA transaction with one-phase
--let $action = commit
--let $xa_opt = one phase
--let $expected_recovery = none
--let $sync_point = before_commit_in_engines
--source $error_on_recovery_for_xa_transaction

--connection default
DROP TABLE t1;
