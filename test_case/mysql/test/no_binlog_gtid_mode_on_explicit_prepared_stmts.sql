
-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc

-- Clean gtid_executed so that test can execute after other tests
FLUSH LOGS;
let $master_uuid= `SELECT @@GLOBAL.SERVER_UUID`;
