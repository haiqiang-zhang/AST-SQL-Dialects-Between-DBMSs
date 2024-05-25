DROP TABLE IF EXISTS foo_local;
DROP TABLE IF EXISTS foo_distributed;
CREATE TABLE foo_local (bar UInt64)
ENGINE = MergeTree()
ORDER BY tuple();
CREATE TEMPORARY TABLE _tmp_baz (qux UInt64);
DROP TABLE foo_local;
