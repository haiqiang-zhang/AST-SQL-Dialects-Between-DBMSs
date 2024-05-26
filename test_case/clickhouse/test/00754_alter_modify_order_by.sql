SELECT '*** Check that the parts are sorted according to the new key. ***';
SELECT * FROM summing;
INSERT INTO summing(x, y, z, val) values (1, 2, 0, 20), (1, 2, 2, 50);
SELECT '*** Check that the rows are collapsed according to the new key. ***';
SELECT * FROM summing FINAL ORDER BY x, y, z;
SELECT '*** Check SHOW CREATE TABLE ***';
SHOW CREATE TABLE summing;
DROP TABLE summing;
