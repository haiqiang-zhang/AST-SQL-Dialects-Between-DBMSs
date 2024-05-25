CREATE TABLE t1 (
  i1 INTEGER,
  c1 CHAR(200),
  INDEX idx (i1)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1, "Ullensvang"), (2, "Odda"), (3, "Jondal");
