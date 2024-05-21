SET allow_experimental_inverted_index = 0;
DROP TABLE IF EXISTS tab;
CREATE TABLE tab
(
    `key` UInt64,
    `str` String
)
ENGINE = MergeTree
ORDER BY key;
DROP TABLE tab;
