SELECT object_type, object_schema, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_type = 'BACKUP LOCK';
SELECT object_schema, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_type = 'BACKUP LOCK';
SELECT object_schema, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_type = 'BACKUP LOCK';
