DROP TABLE IF EXISTS bad_conversions;
DROP TABLE IF EXISTS bad_conversions_2;
CREATE TABLE bad_conversions (a UInt32) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO bad_conversions VALUES (1);