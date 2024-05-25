SET autoinstall_known_extensions=true;;
SET autoload_known_extensions=true;;
SET GLOBAL sqlite_all_varchar = true;;
SELECT count(*) FROM duckdb_extensions() WHERE extension_version != '' AND extension_name == 'sqlite_scanner';;
