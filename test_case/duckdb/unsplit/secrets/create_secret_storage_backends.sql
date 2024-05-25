PRAGMA enable_verification;
set allow_persistent_secrets=false;
CREATE TEMPORARY SECRET temp_s1 ( TYPE s3 );
CREATE SECRET temp_s2 ( TYPE s3 );
SELECT * EXCLUDE (secret_string) FROM duckdb_secrets() ORDER BY name;
SELECT * EXCLUDE (secret_string) FROM duckdb_secrets() ORDER BY name;
