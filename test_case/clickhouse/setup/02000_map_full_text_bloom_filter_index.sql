DROP TABLE IF EXISTS bf_tokenbf_map_keys_test;
DROP TABLE IF EXISTS bf_ngrambf_map_keys_test;
CREATE TABLE bf_tokenbf_map_keys_test
(
    row_id UInt32,
    map Map(String, String),
    map_fixed Map(FixedString(2), String),
    INDEX map_keys_tokenbf mapKeys(map) TYPE tokenbf_v1(256,2,0) GRANULARITY 1,
    INDEX map_fixed_keys_tokenbf mapKeys(map_fixed) TYPE ngrambf_v1(4,256,2,0) GRANULARITY 1
) Engine=MergeTree() ORDER BY row_id SETTINGS index_granularity = 1;
INSERT INTO bf_tokenbf_map_keys_test VALUES (0, {'K0':'V0'}, {'K0':'V0'}), (1, {'K1':'V1'}, {'K1':'V1'});
