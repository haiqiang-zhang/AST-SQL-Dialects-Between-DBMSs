DROP TABLE IF EXISTS local;
DROP TABLE IF EXISTS distributed;
CREATE TABLE local (x UInt8) ENGINE = Memory;
SET distributed_foreground_insert = 0, network_compression_method = 'zstd';
