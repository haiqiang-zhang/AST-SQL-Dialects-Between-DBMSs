SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME='validate_password.length';
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
