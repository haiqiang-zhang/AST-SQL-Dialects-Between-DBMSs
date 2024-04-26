
--
-- Bug#32705 - myisam corruption: Key in wrong position
--             at page 1024 with ucs2_bin
--
CREATE TABLE t1 (
  c1 CHAR(255) CHARACTER SET UCS2 COLLATE UCS2_BIN NOT NULL,
  KEY(c1)
  ) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('marshall\'s');
INSERT INTO t1 VALUES ('marsh');
DROP TABLE t1;
