SELECT @@gtid_mode;
SELECT @@gtid_mode;
SELECT SLEEP(2);
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME IN ('enforce_gtid_consistency', 'gtid_mode');
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME IN ('enforce_gtid_consistency', 'gtid_mode');
