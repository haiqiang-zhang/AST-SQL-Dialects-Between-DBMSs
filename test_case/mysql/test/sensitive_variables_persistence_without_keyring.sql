SELECT @@global.persist_sensitive_variables_in_plaintext;
SET PERSIST test_component.sensitive_string_1 = 'haha';
SET PERSIST_ONLY test_component.sensitive_string_1 = 'haha';
SET PERSIST_ONLY test_component.sensitive_ro_string_1 = 'haha';

SELECT @@global.persist_sensitive_variables_in_plaintext;

SET PERSIST test_component.sensitive_string_1 = 'haha';

SET PERSIST_ONLY test_component.sensitive_string_1 = 'haha';

SET PERSIST_ONLY test_component.sensitive_ro_string_1 = 'haha';
SELECT a.variable_name, b.variable_value, a.variable_source FROM performance_schema.variables_info AS a, performance_schema.global_variables AS b WHERE a.variable_name = b.variable_name AND a.variable_name LIKE 'test_component.sensitive%';

let $MYSQLD_DATADIR= `select @@datadir`;
