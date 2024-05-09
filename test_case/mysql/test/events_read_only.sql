SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
SELECT definer,event_name
  FROM information_schema.events
 WHERE event_schema='mysql'
   AND event_name='event31633859';
SELECT @@global.offline_mode;
SELECT @@global.super_read_only;
SELECT @@global.event_scheduler;
SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
SELECT @@global.offline_mode;
SELECT @@global.super_read_only;
SELECT @@global.read_only;
SELECT @@global.event_scheduler;
SELECT @@global.offline_mode;
SELECT @@global.super_read_only;
SELECT @@global.read_only;
SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
CREATE table t1 (f1 INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, f2 TIMESTAMP);
LOCK INSTANCE FOR BACKUP;
SELECT COUNT(*) FROM t1 INTO @rows_before;
SELECT @rows_before > 0;
SELECT SLEEP(2);
SELECT COUNT(*) FROM t1 INTO @rows_after;
SELECT @rows_after - @rows_before;
UNLOCK INSTANCE;
UNLOCK TABLES;
SELECT @@global.event_scheduler;
DROP TABLE t1;
