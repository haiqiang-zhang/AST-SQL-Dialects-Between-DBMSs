SELECT @@global.persist_sensitive_variables_in_plaintext;
SELECT @@global.persist_sensitive_variables_in_plaintext;
SELECT a.variable_name, b.variable_value, a.variable_source FROM performance_schema.variables_info AS a, performance_schema.global_variables AS b WHERE a.variable_name = b.variable_name AND a.variable_name LIKE 'test_component.sensitive%';
