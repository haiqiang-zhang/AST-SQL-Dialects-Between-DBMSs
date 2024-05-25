DROP TABLE IF EXISTS nested;
CREATE TABLE nested (n Nested(x UInt8)) ENGINE = Memory;
INSERT INTO nested VALUES ([1, 2]);
DROP TABLE nested;
