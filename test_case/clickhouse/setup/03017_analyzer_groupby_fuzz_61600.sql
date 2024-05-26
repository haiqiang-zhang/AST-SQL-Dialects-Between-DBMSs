CREATE TABLE set_index_not__fuzz_0 (`name` String, `status` Enum8('alive' = 0, 'rip' = 1), INDEX idx_status status TYPE set(2) GRANULARITY 1)
ENGINE = MergeTree ORDER BY name
SETTINGS index_granularity = 8192;
INSERT INTO set_index_not__fuzz_0 SELECT * from generateRandom() limit 1;
