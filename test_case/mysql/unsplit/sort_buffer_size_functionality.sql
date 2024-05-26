SELECT COUNT(@@GLOBAL.sort_buffer_size);
SELECT @@GLOBAL.sort_buffer_size;
SELECT @@SESSION.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='sort_buffer_size';
SELECT @@session.sort_buffer_size = VARIABLE_VALUE 
FROM performance_schema.session_variables 
WHERE VARIABLE_NAME='sort_buffer_size';
SELECT @@sort_buffer_size = @@GLOBAL.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
select @@session.sort_buffer_size;
select @@session.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
select variable_value from performance_schema.session_status where variable_name ='Sort_merge_passes';
select variable_value from performance_schema.session_status where variable_name ='Sort_rows';
select variable_value from performance_schema.session_status where variable_name ='Sort_scan';
select ( select variable_value from performance_schema.global_status where variable_name ='Sort_merge_passes') - @Sort_merge_passes;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_rows') - @Sort_rows;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_scan') - @Sort_scan;
select ( select variable_value from performance_schema.global_status where variable_name ='Sort_merge_passes') - @Sort_merge_passes;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_rows') - @Sort_rows;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_scan') - @Sort_scan;
DROP TABLE IF EXISTS tab1;
