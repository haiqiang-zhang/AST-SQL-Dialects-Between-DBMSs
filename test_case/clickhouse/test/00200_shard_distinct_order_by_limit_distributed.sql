DROP TABLE IF EXISTS numbers_memory;
CREATE TABLE numbers_memory AS system.numbers ENGINE = Memory;
INSERT INTO numbers_memory SELECT number FROM system.numbers LIMIT 100;
DROP TABLE numbers_memory;
