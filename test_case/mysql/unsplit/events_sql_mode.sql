SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
CREATE SCHEMA s;
CREATE TABLE s.modes (time TIMESTAMP, sess VARCHAR(256), glob VARCHAR (256));
DROP SCHEMA s;
