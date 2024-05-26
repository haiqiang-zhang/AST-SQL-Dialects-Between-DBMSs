DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
DROP TABLE IF EXISTS m;
CREATE TABLE a (key UInt32) ENGINE = MergeTree ORDER BY key;
CREATE TABLE b (key UInt32, ID UInt32) ENGINE = MergeTree ORDER BY key;
CREATE TABLE m (key UInt32) ENGINE = Merge(currentDatabase(), 'a');
INSERT INTO a VALUES (0);
INSERT INTO b VALUES (0, 1);
SELECT * FROM m INNER JOIN b USING(key);
SELECT * FROM a INNER JOIN b USING(key) GROUP BY ID, key;
SELECT * FROM m INNER JOIN b USING(key) WHERE ID = 1;
SELECT * FROM m INNER JOIN b USING(key) GROUP BY ID, key;
SELECT ID FROM m INNER JOIN b USING(key) GROUP BY ID;
SELECT * FROM m INNER JOIN b USING(key) WHERE ID = 1 HAVING ID = 1 ORDER BY ID;
SELECT * FROM m INNER JOIN b USING(key) WHERE ID = 1 GROUP BY ID, key HAVING ID = 1 ORDER BY ID;
SELECT sum(b.ID), sum(m.key) FROM m FULL JOIN b ON (m.key == b.key) GROUP BY key;
DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
DROP TABLE IF EXISTS m;
