DROP TABLE IF EXISTS local;
DROP TABLE IF EXISTS distributed;
CREATE TABLE local (x UInt8) ENGINE = Memory;
SET distributed_foreground_insert = 1;
SELECT count() FROM local;
TRUNCATE TABLE local;
TRUNCATE TABLE local;
DROP TABLE local;
