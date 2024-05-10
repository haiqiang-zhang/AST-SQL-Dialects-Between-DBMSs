CREATE TABLE t1 (
  pk_col1 INT NOT NULL,
  a1 CHAR(64),
  a2 CHAR(64),
  PRIMARY KEY(pk_col1),
  KEY t1_a1_idx (a1),
  KEY t1_a1_a2_idx (a1, a2)
) ENGINE=INNODB;
INSERT INTO t1 (pk_col1, a1, a2) VALUES (1,'a','b'), (2,'a','b'), (3,'d','c'),
                                        (4,'b','c'), (5,'c','d'), (6,'a','b');
CREATE TABLE t2 (
  pk_col1 INT NOT NULL,
  pk_col2 INT NOT NULL,
  a1 CHAR(64),
  a2 CHAR(64),
  PRIMARY KEY(pk_col1, pk_col2),
  KEY t2_a1_idx (a1),
  KEY t2_a1_a2_idx (a1, a2)
) ENGINE=INNODB;
INSERT INTO t2 (pk_col1, pk_col2, a1, a2) VALUES (1,1,'a','b'),(1,2,'a','b'),
                                                 (1,3,'d','c'),(1,4,'b','c'),
                                                 (2,1,'c','d'),(3,1,'a','b');
SELECT t2.a1, t2.a2
FROM t1 FORCE INDEX(t1_a1_a2_idx) JOIN t2 ON (t1.pk_col1 = t2.pk_col2)
WHERE t1.a1 > 'a';
DROP TABLE t1, t2;
CREATE TABLE t1 (v3 INT, KEY(v3));
CREATE view v1 AS SELECT v3  FROM t1 FORCE KEY (v3) GROUP BY v3;
DROP VIEW v1;
DROP TABLE t1;
