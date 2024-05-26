SELECT name, provider, type, scope FROM duckdb_secrets();
SELECT name, provider, type, scope FROM duckdb_secrets() ORDER BY name;
SELECT name, persistent, storage, provider, type, scope FROM duckdb_secrets() ORDER BY name;
