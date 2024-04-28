SELECT * FROM duckdb_extensions();;
SELECT aliases FROM duckdb_extensions() WHERE extension_name='postgres_scanner';;
SELECT extension_name FROM duckdb_extensions() WHERE loaded AND extension_name='tpch';;
