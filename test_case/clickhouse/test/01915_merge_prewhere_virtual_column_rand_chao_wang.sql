DROP TABLE IF EXISTS abc;
CREATE TABLE abc
(
    `f1` String,
    `f2` String
)
ENGINE = MergeTree()
ORDER BY f1;
SELECT f2 FROM merge(currentDatabase(), '^abc$') PREWHERE _table = 'abc' AND f1 = 'a';
SELECT f2 FROM merge(currentDatabase(), '^abc$') PREWHERE f1 = 'a' WHERE _table = 'abc';
DROP TABLE abc;