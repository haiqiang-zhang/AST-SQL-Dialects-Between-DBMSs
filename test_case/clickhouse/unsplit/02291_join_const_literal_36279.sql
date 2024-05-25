DROP TABLE IF EXISTS test_distributed;
DROP TABLE IF EXISTS test_local;
SET prefer_localhost_replica = 1;
CREATE TABLE test_local (text String, text2 String) ENGINE = MergeTree() ORDER BY text;
SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS test_distributed;
DROP TABLE IF EXISTS test_local;
DROP TABLE IF EXISTS user_local;
DROP TABLE IF EXISTS user_all;
DROP TABLE IF EXISTS event;
CREATE TABLE user_local ( id Int64, name String, age Int32 )
ENGINE = MergeTree ORDER BY name;
CREATE TABLE event ( id Int64, user_id Int64, content String, created_time DateTime )
ENGINE = MergeTree ORDER BY user_id;
INSERT INTO user_local (id, name, age) VALUES (1, 'aaa', 21);
INSERT INTO event (id, user_id, content, created_time) VALUES(1, 1, 'hello', '2022-01-05 12:00:00');
DROP TABLE IF EXISTS user_local;
DROP TABLE IF EXISTS user_all;
DROP TABLE IF EXISTS event;
