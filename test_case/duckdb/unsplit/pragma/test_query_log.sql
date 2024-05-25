SELECT CURRENT_SETTING('log_query_path');
PRAGMA log_query_path='__TEST_DIR__/query_log.txt';
SELECT CURRENT_SETTING('log_query_path');
PRAGMA log_query_path='';
SELECT 42;
SELECT * FROM read_csv('__TEST_DIR__/query_log.txt', columns={'sql': 'VARCHAR'}, auto_detect=false);
