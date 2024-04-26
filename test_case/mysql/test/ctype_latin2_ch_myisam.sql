
--
-- Bug #30462 Character sets: search failures with case sensitive collations
--
SET collation_connection=latin2_czech_cs;
CREATE TABLE t1 ENGINE=MYISAM AS SELECT repeat('a', 5) AS s1 LIMIT 0;
INSERT INTO t1 VALUES ('x'),('y'),('z'),('X'),('Y'),('Z');
SELECT * FROM t1 GROUP BY s1;
SELECT * FROM t1 ORDER BY s1;
CREATE INDEX i1 ON t1 (s1);
SELECT * FROM t1 GROUP BY s1;
SELECT * FROM t1 ORDER BY s1;
DROP TABLE t1;


--
-- Bug#40805 Cannot restore table
--
CREATE TABLE `t1` (
  `ID` smallint(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Post` enum('','B','O','Z','U') COLLATE latin2_czech_cs DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=135 DEFAULT CHARSET=latin2;
INSERT INTO t1 (ID,Post) VALUES (00041,'');
SELECT ID, Post, HEX(WEIGHT_STRING(Post)) FROM t1;
DROP TABLE t1;
