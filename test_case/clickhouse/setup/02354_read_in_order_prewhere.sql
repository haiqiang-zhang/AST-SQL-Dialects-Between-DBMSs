drop table if exists order;
CREATE TABLE order
(
    ID Int64,
    Type Int64,
    Num UInt64,
    t DateTime
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(t)
ORDER BY (ID, Type, Num);
