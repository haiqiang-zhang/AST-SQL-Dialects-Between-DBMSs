DROP TABLE IF EXISTS bloom_filter_nullable_index;
CREATE TABLE bloom_filter_nullable_index
    (
        order_key UInt64,
        str Nullable(String),

        INDEX idx (str) TYPE bloom_filter GRANULARITY 1
    )
    ENGINE = MergeTree() 
    ORDER BY order_key SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_nullable_index VALUES (1, 'test');
INSERT INTO bloom_filter_nullable_index VALUES (2, 'test2');
