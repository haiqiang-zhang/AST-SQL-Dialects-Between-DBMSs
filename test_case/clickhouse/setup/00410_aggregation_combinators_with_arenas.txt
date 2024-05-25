DROP TABLE IF EXISTS arena;
CREATE TABLE arena (k UInt8, d String) ENGINE = Memory;
INSERT INTO arena SELECT number % 10 AS k, hex(intDiv(number, 10) % 1000) AS d FROM system.numbers LIMIT 10000000;
