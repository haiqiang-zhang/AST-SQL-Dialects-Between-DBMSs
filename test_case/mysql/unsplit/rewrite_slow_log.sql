CREATE TABLE test_log (sql_text TEXT);
SELECT sql_text FROM test_log WHERE sql_text LIKE CONCAT('%azun','dris%');
SELECT count(*)=1 OR count(*)=2 FROM test_log WHERE sql_text LIKE 'CREATE USER %' AND sql_text LIKE '%<secret>%';
SELECT sql_text FROM test_log WHERE sql_text LIKE 'CHANGE REPLICATION SOURCE TO SOURCE_BIND %';
SELECT count(*) FROM test_log WHERE sql_text LIKE 'SET PASSWORD %' AND sql_text LIKE '%<secret>%';
SELECT sql_text FROM test_log WHERE sql_text LIKE 'CHANGE REPLICATION SOURCE TO SOURCE_BIND %';
DROP TABLE test_log;
