DROP TABLE IF EXISTS random_mt;
CREATE TABLE random_mt
(
    key UInt64,
    value String
)
ENGINE MergeTree()
ORDER BY tuple();
INSERT INTO random_mt VALUES (1, 'Hello');