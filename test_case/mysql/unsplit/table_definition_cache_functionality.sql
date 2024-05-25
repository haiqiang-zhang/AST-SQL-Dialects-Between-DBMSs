SELECT COUNT(@@GLOBAL.table_definition_cache);
SELECT IF (@@open_files_limit < 5000, 2000, @@GLOBAL.table_definition_cache);
SELECT @@GLOBAL.table_definition_cache;
SELECT IF (@@open_files_limit < 5000, 2000, @@GLOBAL.table_definition_cache);
SELECT IF (@@open_files_limit < 5000, 2000, @@GLOBAL.table_definition_cache);
SELECT @@GLOBAL.table_definition_cache = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='table_definition_cache';
SELECT COUNT(@@GLOBAL.table_definition_cache);
SELECT COUNT(VARIABLE_VALUE)
FROM performance_schema.global_variables 
WHERE VARIABLE_NAME='table_definition_cache';
SELECT @@table_definition_cache = @@GLOBAL.table_definition_cache;
SELECT COUNT(@@GLOBAL.table_definition_cache);
DROP TABLE IF EXISTS tab1;
DROP TABLE IF EXISTS tab2;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 3;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 4;
DROP TABLE IF EXISTS tab1;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 1 + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 4 + 2;
DROP TABLE IF EXISTS tab2;
select (select variable_value from
        performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 4 + 2;
