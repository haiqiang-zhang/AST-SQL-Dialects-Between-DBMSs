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
