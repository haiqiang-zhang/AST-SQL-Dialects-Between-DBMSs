CREATE TABLE bftest (
    k Int64,
    y Array(Int64) DEFAULT x,
    x Array(Int64),
    index ix1(x) TYPE bloom_filter GRANULARITY 3
)
Engine=MergeTree
ORDER BY k;
INSERT INTO bftest (k, x) SELECT number, arrayMap(i->rand64()%565656, range(10)) FROM numbers(1000);
SET force_data_skipping_indices='ix1';