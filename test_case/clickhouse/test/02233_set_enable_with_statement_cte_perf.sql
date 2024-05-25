WITH 'test' AS u SELECT count() FROM ev WHERE a IN (SELECT a FROM idx) SETTINGS enable_global_with_statement = 1;
SELECT count() FROM ev WHERE a IN (SELECT a FROM idx) SETTINGS enable_global_with_statement = 1;
WITH 'test' AS u SELECT count() FROM ev WHERE a IN (SELECT a FROM idx) SETTINGS enable_global_with_statement = 0;
SYSTEM FLUSH LOGS;
DROP TABLE IF EXISTS ev;
DROP TABLE IF EXISTS idx;
