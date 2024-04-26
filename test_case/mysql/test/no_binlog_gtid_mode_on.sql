--   i) SET SESSION GTID_NEXT='UUID:GNO'
--  ii) Execute a statement
-- iii) See that an entry is added in 'gtid_executed' table.
--  iv) Execute above three steps for all different types of statements
--##############################################################################

-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc

-- Clean gtid_executed so that test can execute after other tests
RESET BINARY LOGS AND GTIDS;

-- Initial setup
connect (connection_for_table_check,127.0.0.1,root,,test,$MASTER_MYPORT);
let $master_uuid= `SELECT @@GLOBAL.SERVER_UUID`;

-- Remember the current gtid_executed context
--connection connection_for_table_check
--source include/gtid_step_reset.inc

-- Check-1: CREATE TABLE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:1'
CREATE TABLE t1( i INT) engine=INNODB;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-2: INSERT
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:2'
INSERT INTO t1 VALUES (12);
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-3: INSERT SELECT
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:3'
INSERT INTO t1 SELECT * FROM t1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-4: UPDATE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:4'
UPDATE t1 SET i=13 WHERE i=12;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-5: DELETE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:5'
DELETE FROM t1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-6: ALTER
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:6'
ALTER TABLE t1 ADD COLUMN other_column INT;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-7: CREATE INDEX
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
CREATE INDEX t_index ON t1(i);
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-8: DROP INDEX
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:8'
DROP INDEX t_index ON t1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-9: RENAME TABLE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:9'
RENAME TABLE t1 TO t2;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-10: DROP TABLE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:10'
DROP TABLE t2;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-11: CREATE TEMPORARY TABLE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:11'
CREATE TEMPORARY TABLE t1(i INT);
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-12: DROP TEMPORARY TABLE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:12'
DROP TEMPORARY TABLE t1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-13: CREATE VIEW
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:13'
CREATE VIEW v1 as SELECT 1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-14: DROP VIEW
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:14'
DROP VIEW v1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-15: CREATE USER
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:15'
CREATE USER user1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-16: ALTER USER
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:16'
ALTER USER user1 IDENTIFIED BY 'passwd';
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-17: GRANT
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:17'
GRANT ALL ON *.* TO user1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-18: REVOKE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:18'
REVOKE ALL PRIVILEGES ON *.* FROM user1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-19: DROP USER
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:19'
DROP USER user1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-20: CREATE DATABASE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:20'
CREATE DATABASE db1;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-21: ALTER DATABASE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:21'
ALTER DATABASE db1 DEFAULT CHARACTER SET utf8mb3;
SELECT GTID_EXECUTED_FROM_TABLE();

-- Check-22: DROP DATABASE
--connection default
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:22'
DROP DATABASE db1;
SELECT GTID_EXECUTED_FROM_TABLE();
CREATE TABLE t1(dt DATETIME) engine=INNODB;
INSERT INTO t1 VALUES (CONVERT_TZ('2015-07-01 01:00:00', 'UTC', 'No-such-time-zone'));
SET SESSION GTID_NEXT='AUTOMATIC';
DROP TABLE t1;
