-- no-shared-merge-tree: different sychronization, replaced with another test

SELECT '===Ordinary case===';
SET replication_alter_partitions_sync = 2;
DROP TABLE IF EXISTS clear_column;
CREATE TABLE clear_column (d Date, num Int64, str String) ENGINE = MergeTree ORDER BY d PARTITION by toYYYYMM(d) SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO clear_column VALUES ('2016-12-12', 1, 'a'), ('2016-11-12', 2, 'b');
SELECT data_uncompressed_bytes FROM system.columns WHERE (database = currentDatabase()) AND (table = 'clear_column') AND (name = 'num');
SELECT num, str FROM clear_column ORDER BY num;
ALTER TABLE clear_column CLEAR COLUMN num IN PARTITION '201612';
SELECT num, str FROM clear_column ORDER BY num;
SELECT data_uncompressed_bytes FROM system.columns WHERE (database = currentDatabase()) AND (table = 'clear_column') AND (name = 'num');
ALTER TABLE clear_column CLEAR COLUMN num IN PARTITION '201611';
SELECT data_compressed_bytes, data_uncompressed_bytes FROM system.columns WHERE (database = currentDatabase()) AND (table = 'clear_column') AND (name = 'num');
DROP TABLE clear_column;
SELECT '===Replicated case===';
DROP TABLE IF EXISTS clear_column1;
DROP TABLE IF EXISTS clear_column2;
SET replication_alter_partitions_sync=2;
SELECT 'all';
SELECT 'w/o i 1';
SELECT 'w/o is 1';
SELECT 'w/o is 12';
SELECT 'sizes';
SELECT sum(data_uncompressed_bytes) FROM system.columns WHERE database=currentDatabase() AND table LIKE 'clear_column_' AND (name = 'i' OR name = 's') GROUP BY table;
SET optimize_throw_if_noop = 1;
