pragma enable_verification;
select table_name, column_name
from duckdb_columns()
where database_name = 'system'
and schema_name = 'information_schema'
and data_type = 'NULL';
