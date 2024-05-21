DROP TABLE IF EXISTS defaults;
CREATE TABLE defaults
(
    x UInt32,
    y UInt32,
    a DEFAULT x + y,
    b Float32 DEFAULT round(log(1 + x + y), 5),
    c UInt32 DEFAULT 42,
    e MATERIALIZED x + y,
    f ALIAS x + y
) ENGINE = MergeTree ORDER BY x;
INSERT INTO defaults (x, y) SELECT x, y FROM defaults LIMIT 1;
SELECT * FROM defaults ORDER BY (x, y);
ALTER TABLE defaults ADD COLUMN n Nested(a UInt64, b String);
ALTER TABLE defaults ADD COLUMN n.c Array(UInt8) DEFAULT arrayMap(x -> 0, n.a) AFTER n.a;
DROP TABLE defaults;
