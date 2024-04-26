
-- We need to have performance_schema.error_log to ourselves:
--source include/not_parallel.inc

--echo -- Make sure performance_schema.error_log and session agree on the timezone.
SET @@session.time_zone=@@global.log_timestamps;
SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
CREATE USER 'user31633859'@'127.0.0.1';
SELECT COUNT(thread_id)
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
CREATE DEFINER='user31633859'@'127.0.0.1' EVENT
  IF NOT EXISTS
  mysql.event31633859
  ON SCHEDULE EVERY 1 SECOND
  DO SET @dummy=1;
SET @@global.offline_mode=ON;
SET @@global.super_read_only=ON;
SELECT definer,event_name
  FROM information_schema.events
 WHERE event_schema='mysql'
   AND event_name='event31633859';
let $wait_condition=
  SELECT COUNT(thread_id)=0 FROM performance_schema.threads WHERE name='thread/sql/event_scheduler';
SELECT @@global.offline_mode;
SELECT @@global.super_read_only;
SELECT error_code,data
  FROM performance_schema.error_log
 WHERE error_code='MY-010045' AND logged>@pfs_errlog_latest;
SELECT COUNT(thread_id)
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
SELECT @@global.event_scheduler;

SET @@global.super_read_only=OFF;
let $wait_condition=
  SELECT COUNT(thread_id)>0 FROM performance_schema.threads WHERE name='thread/sql/event_scheduler';
SELECT COUNT(thread_id)>0 FROM performance_schema.threads WHERE name='thread/sql/event_scheduler';
SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
SET @@global.offline_mode=ON;
SET @@global.read_only=ON;
SET @@global.super_read_only=ON;
let $wait_condition=
  SELECT COUNT(thread_id)=0 FROM performance_schema.threads WHERE name='thread/sql/event_scheduler';
SELECT @@global.offline_mode;
SELECT @@global.super_read_only;
SELECT @@global.read_only;
SELECT error_code,data
  FROM performance_schema.error_log
 WHERE error_code='MY-010045' AND logged>@pfs_errlog_latest;
SELECT COUNT(thread_id)
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
SELECT @@global.event_scheduler;

SET @@global.read_only=OFF;
let $wait_condition=
  SELECT COUNT(thread_id)>0 FROM performance_schema.threads WHERE name='thread/sql/event_scheduler';
SELECT COUNT(thread_id)>0 FROM performance_schema.threads WHERE name='thread/sql/event_scheduler';
SELECT @@global.offline_mode;
SELECT @@global.super_read_only;
SELECT @@global.read_only;

SET @@global.read_only=OFF;
SET @@global.offline_mode=OFF;

DROP EVENT mysql.event31633859;
DROP USER 'user31633859'@'127.0.0.1';
SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
CREATE USER 'user33711304'@'127.0.0.1';
CREATE table t1 (f1 INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, f2 TIMESTAMP);
CREATE DEFINER='user33711304'@'127.0.0.1' EVENT
  IF NOT EXISTS
  mysql.event33711304
  ON SCHEDULE EVERY 1 SECOND
  DO INSERT INTO test.t1 VALUES (NULL, CURRENT_TIMESTAMP);
let $wait_timeout= 60;
let $wait_condition= SELECT COUNT(*)>0 FROM t1;
SELECT error_code,data
  FROM performance_schema.error_log
 WHERE error_code='MY-010045' AND logged>@pfs_errlog_latest;
SELECT PROCESSLIST_STATE
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
SELECT COUNT(*) FROM t1 INTO @rows_before;
SELECT @rows_before > 0;
SELECT SLEEP(2);
SELECT COUNT(*) FROM t1 INTO @rows_after;
SELECT @rows_after - @rows_before;
SELECT error_code,data
  FROM performance_schema.error_log
 WHERE error_code='MY-010045' AND logged>@pfs_errlog_latest LIMIT 1;
SELECT PROCESSLIST_STATE
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
let $wait_timeout= 60;
let $wait_condition= SELECT (COUNT(*)-@rows_after)>0 FROM t1;
SELECT error_code,data
  FROM performance_schema.error_log
 WHERE error_code='MY-010045' AND logged>@pfs_errlog_latest;
SELECT COUNT(thread_id)
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
SELECT PROCESSLIST_STATE
  FROM performance_schema.threads
 WHERE name='thread/sql/event_scheduler';
SELECT @@global.event_scheduler;

DROP EVENT mysql.event33711304;
DROP TABLE t1;
DROP USER 'user33711304'@'127.0.0.1';
