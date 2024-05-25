DROP TABLE IF EXISTS m;
DROP TABLE IF EXISTS d;
CREATE TABLE m
(
    `v` UInt8
)
ENGINE = MergeTree()
PARTITION BY tuple()
ORDER BY v;
INSERT INTO m VALUES (123);
DROP TABLE m;
CREATE TABLE m
(
    `v` Enum8('a' = 1, 'b' = 2)
)
ENGINE = MergeTree()
PARTITION BY tuple()
ORDER BY v;
INSERT INTO m VALUES ('a');
SELECT '---';
INSERT INTO m VALUES ('b');
DROP TABLE m;