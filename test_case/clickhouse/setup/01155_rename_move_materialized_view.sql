SET send_logs_level = 'fatal';
SET prefer_localhost_replica = 1;
DROP DATABASE IF EXISTS test_01155_ordinary;
DROP DATABASE IF EXISTS test_01155_atomic;
set allow_deprecated_database_ordinary=1;
CREATE DATABASE test_01155_ordinary ENGINE=Ordinary;
CREATE DATABASE test_01155_atomic ENGINE=Atomic;
