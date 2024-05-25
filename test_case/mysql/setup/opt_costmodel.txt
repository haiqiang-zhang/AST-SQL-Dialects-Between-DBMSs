CREATE TABLE t1 (
  i1 INTEGER,
  i2 INTEGER,
  i3 INTEGER,
  KEY(i1,i2)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1, 1, 1), (1, 1, 1),(1, 1, 1),(1, 1, 1),
                      (2, 2, 1), (2, 2, 1),(2, 2, 1),(2, 2, 1),
                      (3, 3, 1), (3, 3, 1),(3, 3, 1),(3, 3, 1);
DROP TABLE t1;
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  a INTEGER,
  b INTEGER,
  c CHAR(255),
  UNIQUE KEY k1 (a)
);
INSERT INTO t1 VALUES (1, 1, NULL, "Abc"), (2, 2, NULL, "Abc"),
                      (3, 3, NULL, "Abc"), (4, 4, NULL, "Abc");
INSERT INTO t1 SELECT a + 4, a + 4, b, c FROM t1;
INSERT INTO t1 SELECT a + 8, a + 8, b, c FROM t1;
INSERT INTO t1 SELECT a + 16, a + 16, b, c FROM t1;
INSERT INTO t1 SELECT a + 32, a + 32, b, c FROM t1;
INSERT INTO t1 SELECT a + 64, a + 64, b, c FROM t1;
INSERT INTO t1 SELECT a + 128, a + 128, b, c FROM t1;
CREATE TABLE t2 (
  d INTEGER PRIMARY KEY,
  e INTEGER
);
INSERT INTO t2 SELECT a, b FROM t1;
DROP TABLE t1, t2;
