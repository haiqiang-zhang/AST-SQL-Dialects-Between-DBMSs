SELECT * FROM insert_fewer_columns;
DROP TABLE IF EXISTS insert_fewer_columns_2;
CREATE TABLE insert_fewer_columns_2 (b UInt8, a UInt8) ENGINE = Memory;
INSERT INTO insert_fewer_columns_2 SELECT * FROM insert_fewer_columns;
SELECT a, b FROM insert_fewer_columns;
SELECT a, b FROM insert_fewer_columns_2;
DROP TABLE IF EXISTS insert_fewer_columns_2;
DROP TABLE insert_fewer_columns;
