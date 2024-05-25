CREATE TABLE global_vars (id INT PRIMARY KEY AUTO_INCREMENT, var_name VARCHAR(64), var_value VARCHAR(1024));
INSERT INTO global_vars (var_name, var_value) SELECT * FROM
performance_schema.global_variables WHERE variable_name NOT IN
('innodb_monitor_enable',
'innodb_monitor_disable',
'innodb_monitor_reset',
'innodb_monitor_reset_all',
'rbr_exec_mode');
CREATE TABLE all_vars (id INT PRIMARY KEY AUTO_INCREMENT, var_name VARCHAR(64), var_value VARCHAR(1024));
INSERT INTO all_vars (var_name, var_value)
SELECT * FROM performance_schema.global_variables
WHERE variable_name NOT IN
('rbr_exec_mode')
AND variable_name NOT LIKE 'ndb_%'
AND variable_name NOT LIKE 'debug_%'
AND variable_name NOT LIKE '%telemetry%'
ORDER BY variable_name;
DROP TABLE all_vars;
DROP TABLE global_vars;
