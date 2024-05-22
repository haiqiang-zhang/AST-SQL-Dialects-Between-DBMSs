DROP TABLE IF EXISTS numbers500k;
CREATE TABLE numbers500k (`number` UInt32) ENGINE = MergeTree() ORDER BY tuple();
INSERT INTO numbers500k SELECT number FROM system.numbers LIMIT 500000;
DROP TABLE IF EXISTS numbers500k;
