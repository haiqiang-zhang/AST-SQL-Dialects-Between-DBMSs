SET allow_experimental_analyzer=1;
CREATE TABLE test1
(
    `pk` String,
    `x.y` Decimal(18, 4)
)
ENGINE = MergeTree()
ORDER BY (pk);
CREATE TABLE test2
(
    `pk` String,
    `x.y` Decimal(18, 4)
)
ENGINE = MergeTree()
ORDER BY (pk);
INSERT INTO test1 SELECT 'pk1', 1;
INSERT INTO test2 SELECT 'pk1', 2;
