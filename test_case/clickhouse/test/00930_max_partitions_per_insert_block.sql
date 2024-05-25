SELECT count() FROM system.parts WHERE database = currentDatabase() AND table = 'partitions';
INSERT INTO partitions SELECT * FROM system.numbers LIMIT 100;
SELECT count() FROM system.parts WHERE database = currentDatabase() AND table = 'partitions';
SET max_partitions_per_insert_block = 1;
INSERT INTO partitions SELECT * FROM system.numbers LIMIT 1;
DROP TABLE partitions;
