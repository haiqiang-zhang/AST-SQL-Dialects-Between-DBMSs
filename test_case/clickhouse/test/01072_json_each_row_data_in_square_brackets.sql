DROP TABLE IF EXISTS json_square_brackets;
CREATE TABLE json_square_brackets (id UInt32, name String) ENGINE = Memory;
SELECT * FROM json_square_brackets ORDER BY id;
DROP TABLE IF EXISTS json_square_brackets;