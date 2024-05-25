SELECT * FROM duckdb_settings();
SET profile_output='__TEST_DIR__/profile_output';
SELECT * FROM duckdb_settings();
PRAGMA disable_print_progress_bar;
SET enable_progress_bar=true;
SELECT * FROM duckdb_settings();
