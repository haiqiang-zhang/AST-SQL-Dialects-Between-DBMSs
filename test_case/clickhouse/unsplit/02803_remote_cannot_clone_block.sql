DROP TABLE IF EXISTS numbers_10_00223;
CREATE TABLE numbers_10_00223
ENGINE = Log AS
SELECT *
FROM system.numbers
LIMIT 10000;
SET allow_experimental_analyzer = 0;
DROP TABLE numbers_10_00223;
