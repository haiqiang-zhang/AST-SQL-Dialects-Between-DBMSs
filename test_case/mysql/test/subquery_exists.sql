CREATE TABLE t1(
 pk INTEGER PRIMARY KEY,
 uk INTEGER UNIQUE,
 ukn INTEGER UNIQUE NOT NULL,
 ik INTEGER,
 d INTEGER,
 INDEX ik(ik));
INSERT INTO t1 VALUES
(0, NULL, 0, NULL, NULL),
(1, 10, 20, 30, 40),
(2, 20, 40, 60, 80);
CREATE TABLE t2(
 pk INTEGER PRIMARY KEY);
INSERT INTO t2 VALUES
 (1), (2), (3), (4), (5), (6), (7), (8), (9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),
(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),
(51),(52),(53),(54),(55),(56),(57),(58),(59),(60),
(61),(62),(63),(64),(65),(66),(67),(68),(69),(70),
(71),(72),(73),(74),(75),(76),(77),(78),(79),(80);
SELECT 1 FROM dual
WHERE EXISTS (SELECT * FROM t1 AS it);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT 1 FROM dual);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT 1 FROM dual WHERE FALSE);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.pk = 1);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.uk = 1);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ukn = 1);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ik = 1);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.d = 1);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.pk = ot.pk);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.uk = ot.uk);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ukn = ot.ukn);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ik = ot.ik);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.d = ot.d);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.pk > ot.pk);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.uk > ot.uk);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ukn > ot.ukn);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ik > ot.ik);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.d > ot.d);
SELECT * FROM t2 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ik = ot.pk);
SELECT * FROM t2 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.pk = ot.pk);
SELECT * FROM t2 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.uk = ot.pk);
SELECT * FROM t2 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.ukn = ot.pk);
SELECT * FROM t2 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it WHERE it.d = ot.pk);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t2 AS it WHERE ot.d = it.pk - 1);
SELECT * FROM t1 AS ot
WHERE EXISTS (SELECT * FROM t1 AS it1 JOIN t2 AS it2 ON it1.pk > it2.pk
              WHERE ot.d = it2.pk);
DROP TABLE t1, t2;
CREATE TABLE t1 (a INTEGER);
SELECT * FROM t1 WHERE EXISTS (SELECT * FROM t1 WHERE 127 = 55);
SELECT * FROM t1
WHERE EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1);
SELECT * FROM t1
WHERE EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1) AND
      EXISTS (SELECT * FROM t1);
DROP TABLE t1;
