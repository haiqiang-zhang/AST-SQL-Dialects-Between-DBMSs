CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1),(2);
DROP TABLE t1;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME='validate_password.length';
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
