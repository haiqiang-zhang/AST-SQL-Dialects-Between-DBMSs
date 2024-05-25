CREATE TABLE t0 (
  i1 INTEGER
);
INSERT INTO t0 VALUE (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  c1 CHAR(250),
  c2 CHAR(250),
  c3 CHAR(250),
  c4 CHAR(250),
  INDEX i1_key (i1)
) ENGINE=InnoDB;
INSERT INTO t1
SELECT a0.i1 + 10 * a1.i1, a0.i1, 'abc', 'def', 'ghi', 'jkl'
FROM t0 AS a0, t0 AS a1 ORDER BY a0.i1, a1.i1;
