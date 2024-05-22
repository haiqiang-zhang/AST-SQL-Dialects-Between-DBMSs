DROP TABLE IF EXISTS test_01640;
DROP TABLE IF EXISTS restore_01640;
SELECT partition_id
FROM system.detached_parts
WHERE (table = 'restore_01640') AND (database = currentDatabase());
SELECT partition_id
FROM system.detached_parts
WHERE (table = 'restore_01640') AND (database = currentDatabase());
