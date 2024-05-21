DROP TABLE IF EXISTS test;
CREATE TABLE test (x UInt8) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/test', 'replica-{server_uuid}') ORDER BY x;
SELECT engine_full LIKE ('%replica-' || serverUUID()::String || '%') FROM system.tables WHERE database = currentDatabase() AND name = 'test';
CREATE TABLE test2 (x UInt8) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/test', 'replica-{server_uuid}') ORDER BY x;
-- The macro {server_uuid} is special, not a configuration-type macro. It's normal that it is inaccessible with the getMacro function.
SELECT getMacro('server_uuid');
DROP TABLE test SYNC;