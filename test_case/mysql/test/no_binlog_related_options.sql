
-- Clean all configuration changes after running the test to
-- make sure the test is repeatable.
--source include/force_restart.inc

call mtr.add_suppression("You need to use --log-bin to make --binlog-format work.");

SELECT @@GLOBAL.log_bin;

SELECT @@GLOBAL.log_replica_updates;
