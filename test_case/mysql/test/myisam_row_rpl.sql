
CREATE TABLE tmp (a VARCHAR(10), b INT) ENGINE=Memory;
INSERT INTO tmp VALUES ('aZa', 1), ('zAz', 2), ('M', 3);
INSERT INTO tmp SELECT * FROM tmp;
INSERT INTO tmp SELECT * FROM tmp;
INSERT INTO tmp SELECT * FROM tmp;
INSERT INTO tmp SELECT * FROM tmp;
INSERT INTO tmp SELECT * FROM tmp;
INSERT INTO tmp SELECT * FROM tmp;

CREATE TABLE t
(a VARCHAR(10),
 b INT,
 KEY a (a))
ENGINE = MyISAM;
INSERT INTO t SELECT * FROM tmp;
SELECT COUNT(*) FROM t WHERE b > -1;
SELECT COUNT(*) FROM t WHERE b > -1;
SELECT COUNT(*) FROM t WHERE b > -1;
DROP TABLE t, tmp;
