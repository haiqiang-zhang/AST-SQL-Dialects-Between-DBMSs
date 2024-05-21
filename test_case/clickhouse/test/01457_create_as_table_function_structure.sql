SET prefer_localhost_replica = 1;
DROP DATABASE IF EXISTS test_01457;
CREATE DATABASE test_01457;
CREATE TABLE tmp (n Int8) ENGINE=Memory;
CREATE TABLE test_01457.tf_numbers (number String) AS numbers(1);
SHOW CREATE TABLE test_01457.tf_numbers;
CREATE TABLE test_01457.tf_merge AS merge(currentDatabase(), 'tmp');
SHOW CREATE TABLE test_01457.tf_merge;
DROP TABLE tmp;
DETACH DATABASE test_01457;
ATTACH DATABASE test_01457;
SET send_logs_level='error';
CREATE TABLE tmp (n Int8) ENGINE=Memory;
SELECT * FROM tmp;
TRUNCATE TABLE tmp;
SELECT (*,).1 AS c, toTypeName(c) FROM tmp;
SELECT (*,).1 AS c, toTypeName(c) FROM test_01457.tf_numbers;
SELECT (*,).1 AS c, toTypeName(c) FROM test_01457.tf_merge;
DROP DATABASE test_01457;
DROP TABLE tmp;