CREATE TABLE t1
(
  a INTEGER NOT NULL,
  b VARCHAR(50) NOT NULL DEFAULT '',
  PRIMARY KEY  (a),
  KEY b (b(10))
) ENGINE=MyISAM CHARACTER SET 'ujis' COLLATE 'ujis_japanese_ci';
INSERT INTO t1 (a, b) VALUES (0, 'aaabbbcccddd');
INSERT INTO t1 (a, b) VALUES (1, 'eeefffggghhh');
INSERT INTO t1 (a, b) VALUES (2, 'iiijjjkkkl');
SELECT t1.* FROM t1 WHERE b='aaabbbcccddd' ORDER BY a;
SELECT t1.* FROM t1 WHERE b='eeefffggghhh' ORDER BY a;
SELECT t1.* FROM t1 WHERE b='iiijjjkkkl'   ORDER BY a;
DROP TABLE t1;
