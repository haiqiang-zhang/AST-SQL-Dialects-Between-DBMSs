--  Test a dump with --output-as-version= SERVER
--  Test a dump with --output-as-version= BEFORE_8_2_0
--  Test a dump with --output-as-version= BEFORE_8_0_23
--  Test a dump with server  @@GLOBAL.terminology_use_previous= BEFORE_8_0_26 and mysqldump --output-as-version= SERVER
--  Test the dumps are valid
-- 3. For the usage of mysqldump with --dump-replica --apply-replica-statements --include-source-host-port
--  Test a dump with --output-as-version= SERVER
--  Test a dump with --output-as-version= BEFORE_8_2_0
--  Test a dump with --output-as-version= BEFORE_8_0_23
--  Test a dump with server  @@GLOBAL.terminology_use_previous= BEFORE_8_0_26 and mysqldump --output-as-version= SERVER
--  Test the dumps are valid
-- 3. Cleanup
--
-- ==== References ====
--
-- WL#14190: Replace old terms in replication SQL commands on the SOURCE
--

-- Binlog is required
--source include/have_log_bin.inc
--let $use_gtids= 0
--let $rpl_skip_start_slave = 1
--source include/master-slave.inc

--echo --
--echo -- Create the database/table for testing

--source include/rpl_connection_master.inc

CREATE DATABASE mysqldump_test_db;
CREATE TABLE mysqldump_test_db.t1 (a INT);
INSERT INTO mysqldump_test_db.t1 VALUES (1);

SET @@GLOBAL.terminology_use_previous = BEFORE_8_0_26;

-- Change the binlog position for later testing
INSERT INTO mysqldump_test_db.t1 VALUES (2);

SET @@GLOBAL.terminology_use_previous = BEFORE_8_0_26;

INSERT INTO mysqldump_test_db.t1 VALUES (3);

-- The dump deletes and then applies the data and starts replication, so there should be 3 rows on the table
--let $wait_condition = SELECT COUNT(*) = 3 FROM mysqldump_test_db.t1
--source include/wait_condition.inc

--exec $MYSQL --host=127.0.0.1 -P $SLAVE_MYPORT < $dump_file_rep_source

-- The dump deletes and then applies the data and starts replication, so there should be 3 rows on the table
--let $wait_condition = SELECT COUNT(*) = 3 FROM mysqldump_test_db.t1
--source include/wait_condition.inc

--echo --
--echo -- Cleanup

--source include/restore_sysvars.inc
--source include/destroy_json_functions.inc

--source include/rpl_connection_master.inc

--remove_file $dump_file_master

--remove_file $dump_file_rep_source

DROP DATABASE mysqldump_test_db;
