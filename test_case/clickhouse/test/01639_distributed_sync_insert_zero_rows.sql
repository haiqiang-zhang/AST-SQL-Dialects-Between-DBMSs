SET distributed_foreground_insert = 1;
SELECT count() FROM local;
TRUNCATE TABLE local;
SELECT count() FROM local;
TRUNCATE TABLE local;
SELECT count() FROM local;
DROP TABLE local;
