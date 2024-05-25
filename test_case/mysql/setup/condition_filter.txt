CREATE TABLE t0 (
  i0 INTEGER NOT NULL
);
INSERT INTO t0 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  INDEX k1 (i1)
) ENGINE=InnoDB;
INSERT INTO t1
SELECT a0.i0 + 10*a1.i0 + 100*a2.i0,
       (a0.i0 + 10*a1.i0 + 100*a2.i0) % 50,
       a0.i0 + 10*a1.i0 + 100*a2.i0
FROM t0 AS a0, t0 AS a1, t0 AS a2;
CREATE TABLE t2 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  INDEX k1 (i1)
) ENGINE=InnoDB;
INSERT INTO t2
SELECT a0.i0 + 10*a1.i0 + 100*a2.i0,
       (a0.i0 + 10*a1.i0 + 100*a2.i0) % 500,
       a0.i0 + 10*a1.i0 + 100*a2.i0
FROM t0 AS a0, t0 AS a1, t0 AS a2;
