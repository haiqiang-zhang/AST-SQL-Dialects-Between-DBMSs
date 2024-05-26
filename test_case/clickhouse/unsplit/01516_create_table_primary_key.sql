SET send_logs_level = 'fatal';
DROP DATABASE IF EXISTS test_01516;
set allow_deprecated_database_ordinary=1;
DROP TABLE IF EXISTS primary_key_test;
CREATE TABLE primary_key_test(v Int32, PRIMARY KEY(v)) ENGINE=ReplacingMergeTree ORDER BY v;
INSERT INTO primary_key_test VALUES (1), (1), (1);
DETACH TABLE primary_key_test;
