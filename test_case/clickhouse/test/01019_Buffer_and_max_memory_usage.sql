SET max_memory_usage=10e6;
SET max_block_size=100e3;
SET max_insert_threads=1;
SET min_insert_block_size_bytes=9e6;
SET min_insert_block_size_rows=0;
OPTIMIZE TABLE buffer_;
-- create complex aggregation to fail with Memory limit exceede error while writing to Buffer()
-- String over UInt64 is enough to trigger the problem.
CREATE MATERIALIZED VIEW aggregation_ engine=Memory() AS SELECT toString(key) FROM null_;
SET min_insert_block_size_bytes=0;
SET min_insert_block_size_rows=100e3;
INSERT INTO buffer_ SELECT toUInt64(number) FROM system.numbers LIMIT toUInt64(10e6+1);
SELECT count() FROM buffer_;
DROP TABLE null_;
DROP TABLE buffer_;
DROP TABLE aggregation_;
