DROP TABLE IF EXISTS map_test_index_map_keys;
CREATE TABLE map_test_index_map_keys
(
    row_id UInt32,
    map Map(String, String),
    INDEX map_bloom_filter_keys mapKeys(map) TYPE bloom_filter GRANULARITY 1
) Engine=MergeTree() ORDER BY row_id SETTINGS index_granularity = 1;
INSERT INTO map_test_index_map_keys VALUES (0, {'K0':'V0'}), (1, {'K1':'V1'});
