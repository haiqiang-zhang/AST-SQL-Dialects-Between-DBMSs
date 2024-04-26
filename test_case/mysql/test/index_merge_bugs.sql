
CREATE TABLE t1 (
  id int auto_increment NOT NULL,
  c1 int NOT NULL ,
  c2 int NOT NULL,
  c3 int NOT NULL,
  PRIMARY KEY(id),
  KEY c1 (c1),
  KEY c2 (c2)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1(c1, c2, c3) VALUES (1, 1, 1);
INSERT INTO t1 (c1, c2, c3) SELECT c1+1, c2+1, c3+1 FROM t1;
INSERT INTO t1 (c1, c2, c3) SELECT c1+8, c2+8, c3+8 FROM t1;
INSERT INTO t1 (c1, c2, c3) VALUES (1, 2, 888);

-- Optimizer should choose index merge scan to test if it takes
-- the right lock when handler is cloned because of merged scan.
EXPLAIN SELECT * FROM t1 WHERE c1 = 1 AND c2 = 2 FOR UPDATE;
SELECT * FROM t1 WHERE c1 = 1 AND c2 = 2 FOR UPDATE;

DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, INDEX i1(f1), INDEX i2(f2));

INSERT INTO t1 VALUES (1,1),(2,2);
INSERT INTO t1 SELECT f1+2, f2+2 FROM t1;

-- Should not assert
--skip_if_hypergraph
EXPLAIN FORMAT=tree SELECT * FROM t1 WHERE f1 < 3 or f2 > 1020;
SELECT * FROM t1 WHERE f1 < 3 or f2 > 1020;

DROP TABLE t1;

CREATE TABLE t1 (f1 INT, f2 INT, f3 INT, key(f1), key(f2, f3), key(f2));

INSERT INTO t1 VALUES (0,1,2);
INSERT INTO t1 VALUES (1,2,3);
INSERT INTO t1 VALUES (2,3,4);

DROP TABLE t1;

CREATE TABLE t1 (f1 INT, f2 INT, f3 INT, key(f1), key(f2, f3), key(f2));

INSERT INTO t1 VALUES (0,1,2);
INSERT INTO t1 VALUES (1,2,3);
INSERT INTO t1 VALUES (2,3,4);

DROP TABLE t1;
