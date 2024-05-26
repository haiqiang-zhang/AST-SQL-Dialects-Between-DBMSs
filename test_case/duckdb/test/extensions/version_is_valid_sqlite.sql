SELECT count(*) FROM duckdb_extensions() WHERE extension_version != '' AND extension_name == 'sqlite_scanner';
