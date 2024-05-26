SELECT EXISTS (
SELECT 1
FROM pg_class
WHERE oid = 'vacuum_in_leader_small_index'::regclass AND
  pg_relation_size(oid) <
  pg_size_bytes(current_setting('min_parallel_index_scan_size'))
) as leader_will_handle_small_index;
SELECT count(*) as trigger_parallel_vacuum_nindexes
FROM pg_class
WHERE oid in ('regular_sized_index'::regclass, 'typically_sized_index'::regclass) AND
  pg_relation_size(oid) >=
  pg_size_bytes(current_setting('min_parallel_index_scan_size'));
DELETE FROM parallel_vacuum_table;
VACUUM (PARALLEL 4, INDEX_CLEANUP ON) parallel_vacuum_table;
INSERT INTO parallel_vacuum_table SELECT i FROM generate_series(1, 10000) i;
RESET max_parallel_maintenance_workers;
RESET min_parallel_index_scan_size;
