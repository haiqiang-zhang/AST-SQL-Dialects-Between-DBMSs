SET autoinstall_known_extensions=true;
SET autoload_known_extensions=true;
SET enable_server_cert_verification = true;
SELECT count(*) FROM duckdb_extensions() WHERE extension_version != '' AND extension_name == 'httpfs';
