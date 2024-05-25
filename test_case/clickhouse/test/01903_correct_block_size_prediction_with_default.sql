ALTER TABLE test_extract ADD COLUMN `15Id` Nullable(UInt16) DEFAULT toUInt16OrNull(arrayFirst((v, k) -> (k = '4Id'), arr[2], arr[1]));
SELECT uniq(15Id) FROM test_extract SETTINGS max_threads=1, max_memory_usage=100000000;
SELECT uniq(15Id) FROM test_extract PREWHERE 15Id < 4 SETTINGS max_threads=1, max_memory_usage=100000000;
SELECT uniq(15Id) FROM test_extract WHERE 15Id < 4 SETTINGS max_threads=1, max_memory_usage=100000000;
