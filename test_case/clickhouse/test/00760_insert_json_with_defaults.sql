SELECT * FROM defaults ORDER BY (x, y);
ALTER TABLE defaults ADD COLUMN n Nested(a UInt64, b String);
ALTER TABLE defaults ADD COLUMN n.c Array(UInt8) DEFAULT arrayMap(x -> 0, n.a) AFTER n.a;
DROP TABLE defaults;
