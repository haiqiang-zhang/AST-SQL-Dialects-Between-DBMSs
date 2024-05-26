SET transform_null_in = 1;
DROP TABLE IF EXISTS null_in_1;
CREATE TABLE null_in_1 (u UInt32, n Nullable(UInt32)) ENGINE = Memory;
INSERT INTO null_in_1 VALUES (1, NULL), (2, 2), (3, NULL), (4, 4), (5, NULL);
SELECT count() FROM null_in_1 WHERE n IN (1, 2, NULL);
SELECT '==============';
DROP TABLE IF EXISTS null_in_1;
CREATE TABLE null_in_1 (a Nullable(UInt32), b Nullable(UInt32)) ENGINE = Memory;
INSERT INTO null_in_1 VALUES (1, NULL) (0, NULL) (NULL, NULL) (NULL, 1) (NULL, 0) (0, 0) (1, 1);
DROP TABLE IF EXISTS null_in_1;
