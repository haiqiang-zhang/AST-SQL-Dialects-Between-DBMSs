SET local_filesystem_read_method = 'mmap', min_bytes_to_use_mmap_io = 1;
SELECT * FROM test_01343;
SYSTEM FLUSH LOGS;
DROP TABLE test_01343;
