DROP TABLE IF EXISTS bloom_filter_null_array;
CREATE TABLE bloom_filter_null_array (v Array(LowCardinality(Nullable(String))), INDEX idx v TYPE bloom_filter(0.1) GRANULARITY 1) ENGINE = MergeTree() ORDER BY v SETTINGS allow_nullable_key = 1;
INSERT INTO bloom_filter_null_array VALUES ([]);
INSERT INTO bloom_filter_null_array VALUES (['1', '2']) ([]) ([]);
INSERT INTO bloom_filter_null_array VALUES ([]) ([]) (['2', '3']);
