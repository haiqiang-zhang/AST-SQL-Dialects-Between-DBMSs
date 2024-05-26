SET max_block_size = 65409;
DROP TABLE IF EXISTS memory;
CREATE TABLE memory (i UInt32) ENGINE = Memory SETTINGS min_bytes_to_keep = 4096, max_bytes_to_keep = 16384;
