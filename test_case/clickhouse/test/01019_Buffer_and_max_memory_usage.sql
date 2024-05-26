OPTIMIZE TABLE buffer_;
CREATE MATERIALIZED VIEW aggregation_ engine=Memory() AS SELECT toString(key) FROM null_;
SET min_insert_block_size_bytes=0;
SET min_insert_block_size_rows=100e3;
INSERT INTO buffer_ SELECT toUInt64(number) FROM system.numbers LIMIT toUInt64(10e6+1);
SELECT count() FROM buffer_;
DROP TABLE null_;
DROP TABLE buffer_;
DROP TABLE aggregation_;
