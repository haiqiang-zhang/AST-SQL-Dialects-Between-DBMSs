DROP TABLE IF EXISTS map_lc;
SET allow_experimental_map_type = 1;
CREATE TABLE map_lc
(
    `kv` Map(LowCardinality(String), LowCardinality(String))
)
ENGINE = Memory;
INSERT INTO map_lc select map('a', 'b');
