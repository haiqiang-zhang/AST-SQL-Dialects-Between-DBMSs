DROP TABLE IF EXISTS table_with_single_pk;
CREATE TABLE table_with_single_pk
(
  key UInt8,
  value String
)
ENGINE = MergeTree
ORDER BY key
SETTINGS min_compress_block_size=65536, max_compress_block_size=65536;
INSERT INTO table_with_single_pk SELECT number, toString(number % 10) FROM numbers(10000000);
ALTER TABLE table_with_single_pk DELETE WHERE key % 77 = 0 SETTINGS mutations_sync = 1;