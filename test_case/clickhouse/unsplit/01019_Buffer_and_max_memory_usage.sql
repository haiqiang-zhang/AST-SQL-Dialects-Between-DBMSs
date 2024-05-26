DROP TABLE IF EXISTS null_;
DROP TABLE IF EXISTS buffer_;
DROP TABLE IF EXISTS aggregation_;
CREATE TABLE null_ (key UInt64) Engine=Null();
CREATE TABLE buffer_ (key UInt64) Engine=Buffer(currentDatabase(), null_,
    1,    /* num_layers */
    10e6, /* min_time, placeholder */
    10e6, /* max_time, placeholder */
    0,    /* min_rows   */
    10e6, /* max_rows   */
    0,    /* min_bytes  */
    80e6  /* max_bytes  */
);
SET max_memory_usage=10e6;
SET max_block_size=100e3;
SET max_insert_threads=1;
SET min_insert_block_size_bytes=9e6;
SET min_insert_block_size_rows=0;
OPTIMIZE TABLE buffer_;
CREATE MATERIALIZED VIEW aggregation_ engine=Memory() AS SELECT toString(key) FROM null_;
SET min_insert_block_size_bytes=0;
SET min_insert_block_size_rows=100e3;
INSERT INTO buffer_ SELECT toUInt64(number) FROM system.numbers LIMIT toUInt64(10e6+1);
SELECT count() FROM buffer_;
DROP TABLE null_;
DROP TABLE buffer_;
DROP TABLE aggregation_;
