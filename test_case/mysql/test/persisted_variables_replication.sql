
SELECT @@gtid_mode;

SET GLOBAL gtid_mode=1, gtid_mode=2, enforce_gtid_consistency=ON, gtid_mode=3;

SELECT @@gtid_mode;

SET PERSIST enforce_gtid_consistency=ON;
SELECT SLEEP(2);
SET PERSIST gtid_mode=ON;
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME IN ('enforce_gtid_consistency', 'gtid_mode');
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME IN ('enforce_gtid_consistency', 'gtid_mode');
