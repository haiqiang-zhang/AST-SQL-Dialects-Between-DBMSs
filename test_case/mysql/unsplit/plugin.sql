select * from performance_schema.global_status where variable_name like 'example%' order by variable_name;
select @@session.sql_mode into @old_sql_mode;
SELECT * FROM performance_schema.global_status WHERE variable_name LIKE 'example_func_example' ORDER BY variable_name;
