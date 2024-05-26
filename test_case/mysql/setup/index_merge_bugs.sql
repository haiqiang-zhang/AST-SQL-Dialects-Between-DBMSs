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
