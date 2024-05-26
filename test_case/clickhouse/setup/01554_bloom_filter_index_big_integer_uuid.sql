SET allow_experimental_bigint_types = 1;
CREATE TABLE 01154_test (x Int128, INDEX ix_x x TYPE bloom_filter(0.01) GRANULARITY 1) ENGINE = MergeTree() ORDER BY x SETTINGS index_granularity=8192;
INSERT INTO 01154_test VALUES (1), (2), (3);
