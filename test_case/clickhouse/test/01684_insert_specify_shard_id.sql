DROP TABLE IF EXISTS x;
DROP TABLE IF EXISTS x_dist;
DROP TABLE IF EXISTS y;
DROP TABLE IF EXISTS y_dist;
CREATE TABLE x AS system.numbers ENGINE = MergeTree ORDER BY number;
CREATE TABLE y AS system.numbers ENGINE = MergeTree ORDER BY number;
DROP TABLE x;
DROP TABLE y;
