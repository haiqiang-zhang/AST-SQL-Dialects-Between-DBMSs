DROP TABLE IF EXISTS partitions;
CREATE TABLE partitions (x UInt64) ENGINE = MergeTree ORDER BY x PARTITION BY x;
SELECT count() FROM system.parts WHERE database = currentDatabase() AND table = 'partitions';
INSERT INTO partitions SELECT * FROM system.numbers LIMIT 100;
SET max_partitions_per_insert_block = 1;
INSERT INTO partitions SELECT * FROM system.numbers LIMIT 1;
DROP TABLE partitions;
