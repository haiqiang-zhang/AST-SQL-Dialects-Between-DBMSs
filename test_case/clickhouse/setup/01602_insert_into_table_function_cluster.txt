DROP TABLE IF EXISTS x;
DROP TABLE IF EXISTS y;
CREATE TABLE x AS system.numbers ENGINE = MergeTree ORDER BY number;
CREATE TABLE y AS system.numbers ENGINE = MergeTree ORDER BY number;
