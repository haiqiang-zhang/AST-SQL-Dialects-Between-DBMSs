SELECT * FROM alter_compression_codec ORDER BY id;
ALTER TABLE alter_compression_codec ADD COLUMN alter_column String DEFAULT 'default_value' CODEC(ZSTD);
SELECT compression_codec FROM system.columns WHERE database = currentDatabase() AND table = 'alter_compression_codec' AND name = 'alter_column';
INSERT INTO alter_compression_codec VALUES('2018-01-01', 3, '3');
INSERT INTO alter_compression_codec VALUES('2018-01-01', 4, '4');
SELECT * FROM alter_compression_codec ORDER BY id;
ALTER TABLE alter_compression_codec MODIFY COLUMN alter_column CODEC(NONE);
SELECT compression_codec FROM system.columns WHERE database = currentDatabase() AND table = 'alter_compression_codec' AND name = 'alter_column';
INSERT INTO alter_compression_codec VALUES('2018-01-01', 5, '5');
INSERT INTO alter_compression_codec VALUES('2018-01-01', 6, '6');
SELECT * FROM alter_compression_codec ORDER BY id;
OPTIMIZE TABLE alter_compression_codec FINAL;
SELECT * FROM alter_compression_codec ORDER BY id;
SET allow_suspicious_codecs = 1;
ALTER TABLE alter_compression_codec MODIFY COLUMN alter_column CODEC(ZSTD, LZ4HC, LZ4, LZ4, NONE);
SELECT compression_codec FROM system.columns WHERE database = currentDatabase() AND table = 'alter_compression_codec' AND name = 'alter_column';
INSERT INTO alter_compression_codec VALUES('2018-01-01', 7, '7');
INSERT INTO alter_compression_codec VALUES('2018-01-01', 8, '8');
OPTIMIZE TABLE alter_compression_codec FINAL;
SELECT * FROM alter_compression_codec ORDER BY id;
ALTER TABLE alter_compression_codec MODIFY COLUMN alter_column FixedString(100);
SELECT compression_codec FROM system.columns WHERE database = currentDatabase() AND table = 'alter_compression_codec' AND name = 'alter_column';
DROP TABLE IF EXISTS alter_compression_codec;
DROP TABLE IF EXISTS alter_bad_codec;
CREATE TABLE alter_bad_codec (
    somedate Date CODEC(LZ4),
    id UInt64 CODEC(NONE)
) ENGINE = MergeTree() ORDER BY tuple();
DROP TABLE IF EXISTS alter_bad_codec;
DROP TABLE IF EXISTS large_alter_table_00804;
DROP TABLE IF EXISTS store_of_hash_00804;
CREATE TABLE store_of_hash_00804 (hash UInt64) ENGINE = Memory();
SELECT compression_codec FROM system.columns WHERE database = currentDatabase() AND table = 'large_alter_table_00804' AND name = 'data';
SELECT COUNT(hash) FROM store_of_hash_00804;
DROP TABLE IF EXISTS large_alter_table_00804;
DROP TABLE IF EXISTS store_of_hash_00804;
