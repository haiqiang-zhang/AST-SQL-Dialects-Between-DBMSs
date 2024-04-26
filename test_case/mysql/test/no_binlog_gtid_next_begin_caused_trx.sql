--


-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc

-- Make sure the test is repeatable
RESET BINARY LOGS AND GTIDS;
