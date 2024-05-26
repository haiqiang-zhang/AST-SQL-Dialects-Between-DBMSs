SELECT JSON_PRETTY(JSON_REMOVE(histogram, '$."last-updated"'))
FROM INFORMATION_SCHEMA.column_statistics
WHERE table_name = 't1' AND column_name = 'x';
DROP TABLE t1;
