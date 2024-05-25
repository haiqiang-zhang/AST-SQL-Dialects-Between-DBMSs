DROP TABLE IF EXISTS t;
-- test that the check is implemented in all functions which use vectorscan

CREATE TABLE t(c String) Engine=MergeTree() ORDER BY c;
INSERT INTO t VALUES('Hallo Welt');
DROP TABLE t;
