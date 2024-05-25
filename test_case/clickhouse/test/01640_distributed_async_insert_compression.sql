SET distributed_foreground_insert = 0, network_compression_method = 'zstd';
SELECT count() FROM local;
DROP TABLE local;
