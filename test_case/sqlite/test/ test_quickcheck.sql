CREATE TABLE t1(
    a INTEGER NOT NULL, b INTEGER NOT NULL, c AS (a+1),
    PRIMARY KEY(b, a)
  ) WITHOUT ROWID;
INSERT INTO t1 VALUES(1, 2);
INSERT INTO t1 VALUES(3, 4);
PRAGMA quick_check;
