DROP TABLE IF EXISTS json;
CREATE TABLE json (x Enum8('browser' = 1, 'mobile' = 2), y String) ENGINE = Memory;
INSERT INTO json (y) VALUES ('Hello');
SELECT * FROM json ORDER BY y;
SELECT * FROM json ORDER BY y;
SELECT * FROM json ORDER BY y;
DROP TABLE json;